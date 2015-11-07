//
//  NSObject+Night.m
//  DKNightVersion
//
//  Created by Draveness on 15/11/7.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "NSObject+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic, strong) NSMutableArray<DKNightVersionColorChangedBlock> *blocks;

@end

@implementation NSObject (Night)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(init);
        SEL swizzledSelector = @selector(night_init);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod =
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)night_updateColor {
    [self.blocks enumerateObjectsUsingBlock:^(DKNightVersionColorChangedBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
        block(self);
    }];
}

- (void)addColorChangedBlock:(DKNightVersionColorChangedBlock)block {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(night_updateColor) name:DKNightVersionNightFallingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(night_updateColor) name:DKNightVersionDawnComingNotification object:nil];
    [self.blocks addObject:[block copy]];
}

- (NSMutableArray<DKNightVersionColorChangedBlock> *)blocks {
    NSMutableArray<DKNightVersionColorChangedBlock> *blocks = objc_getAssociatedObject(self, @selector(blocks));
    if (!blocks) {
        blocks = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, @selector(blocks), blocks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return blocks;
}

- (void)setBlocks:(NSMutableArray<DKNightVersionColorChangedBlock> *)blocks {
    objc_setAssociatedObject(self, @selector(blocks), blocks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
