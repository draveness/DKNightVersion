//
//  NSObject+Night.m
//  DKNightVersion
//
//  Created by Draveness on 15/11/7.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "NSObject+Night.h"
#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation NSObject (Night)

- (void)setPickers:(NSMutableDictionary<NSString *,DKColorPicker> *)pickers {
    objc_setAssociatedObject(self, @selector(pickers), pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (pickers == nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:DKNightVersionNightFallingNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:DKNightVersionDawnComingNotification object:nil];
    }
}

- (NSMutableDictionary<NSString *,DKColorPicker> *)pickers {
    NSMutableDictionary<NSString *, DKColorPicker> *pickers = objc_getAssociatedObject(self, @selector(pickers));
    if (!pickers) {
        pickers = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, @selector(pickers), pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(night_updateColor) name:DKNightVersionNightFallingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(night_updateColor) name:DKNightVersionDawnComingNotification object:nil];
    }
    return pickers;
}

- (void)night_updateColor {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DKColorPicker  _Nonnull picker, BOOL * _Nonnull stop) {
        SEL sel = NSSelectorFromString(selector);
        UIColor *resultColor = picker();
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:sel withObject:resultColor];
#pragma clang diagnostic pop
    }];
}

@end
