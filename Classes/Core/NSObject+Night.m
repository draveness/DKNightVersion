//
//  NSObject+Night.m
//  DKNightVersion
//
//  Created by Draveness on 15/11/7.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "NSObject+Night.h"
#import "NSObject+DeallocBlock.h"
#import <objc/runtime.h>

static void *DKViewDeallocHelperKey;

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKPicker> *pickers;

@end

@implementation NSObject (Night)

- (NSMutableDictionary<NSString *, DKPicker> *)pickers {
    NSMutableDictionary<NSString *, DKPicker> *pickers = objc_getAssociatedObject(self, @selector(pickers));
    if (!pickers) {
        
        @autoreleasepool {
            // Need to removeObserver in dealloc
            if (objc_getAssociatedObject(self, &DKViewDeallocHelperKey) == nil) {
                __unsafe_unretained typeof(self) weakSelf = self; // NOTE: need to be __unsafe_unretained because __weak var will be reset to nil in dealloc
                id deallocHelper = [self addDeallocBlock:^{
                    [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
                }];
                objc_setAssociatedObject(self, &DKViewDeallocHelperKey, deallocHelper, OBJC_ASSOCIATION_ASSIGN);
            }
        }

        pickers = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, @selector(pickers), pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:DKNightVersionThemeChangingNotificaiton object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(night_updateColor) name:DKNightVersionThemeChangingNotificaiton object:nil];
    }
    return pickers;
}

- (void)night_updateColor {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DKPicker  _Nonnull picker, BOOL * _Nonnull stop) {
        SEL sel = NSSelectorFromString(selector);
        id result = picker();
        [UIView animateWithDuration:DKNightVersionAnimationDuration
                         animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [self performSelector:sel withObject:result];
#pragma clang diagnostic pop
                         }];
    }];
}

@end
