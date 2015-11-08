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

- (void)night_updateColor {
    [self.blocks enumerateObjectsUsingBlock:^(DKNightVersionColorChangedBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
        [UIView animateWithDuration:DKNightVersionAnimationDuration
                         animations:block];
    }];
}

- (void)addColorChangedBlock:(DKNightVersionColorChangedBlock)block {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(night_updateColor) name:DKNightVersionNightFallingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(night_updateColor) name:DKNightVersionDawnComingNotification object:nil];
    [self.blocks addObject:[block copy]];
    block();
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
    if (blocks == nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:DKNightVersionNightFallingNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:DKNightVersionDawnComingNotification object:nil];
    }
}

@end
