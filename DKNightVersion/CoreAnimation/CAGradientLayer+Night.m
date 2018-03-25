//
//  CAGradientLayer+Night.m
//  IXApp
//
//  Created by Seven on 2017/12/8.
//  Copyright © 2017年 IX. All rights reserved.
//

#import "CAGradientLayer+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface CAGradientLayer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation CAGradientLayer (Night)

- (NSArray *)dk_colors
{
    return objc_getAssociatedObject(self, @selector(dk_colors));
}

- (void)setDk_colors:(NSArray *)dk_colors
{
    objc_setAssociatedObject(self, @selector(dk_colors), dk_colors, OBJC_ASSOCIATION_COPY_NONATOMIC);
    NSMutableArray  * arr = [@[] mutableCopy];
    for (int i = 0; i < dk_colors.count; i ++) {
        DKColorPicker picker = dk_colors[i];
        [arr addObject:(__bridge id)picker(self.dk_manager.themeVersion).CGColor];
    }
    self.colors = arr.copy;
    [self.pickers setValue:dk_colors forKey:NSStringFromSelector(@selector(setColors:))];
}

- (void)night_updateColor {
    __block NSMutableArray  * colorArr = [@[] mutableCopy];
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, id _Nonnull obj, BOOL * _Nonnull stop) {
        if ([selector isEqualToString:NSStringFromSelector(@selector(setColors:))]) {
            NSArray * dk_colors = obj;
            for (int i = 0; i < dk_colors.count; i ++) {
                DKColorPicker picker = dk_colors[i];
                [colorArr addObject:(__bridge id)picker(self.dk_manager.themeVersion).CGColor];
            }
        }
    }];

    self.colors = colorArr.copy;
}

@end
