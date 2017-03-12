//
//  DKAlpha.m
//  DKNightVersion
//
//  Created by History on 16/12/10.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import "DKAlpha.h"
#import "DKNightVersionManager.h"
#import "DKColorTable.h"

DKAlphaPicker DKAlphaPickerWithAlphas(CGFloat normal, ...) {
    NSArray<DKThemeVersion *> *themes = [DKColorTable sharedColorTable].themes;
    NSMutableArray<NSNumber *> *alphas = [[NSMutableArray alloc] initWithCapacity:themes.count];
    [alphas addObject:@(normal)];
    NSUInteger num_args = themes.count - 1;
    va_list args;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wvarargs"
    va_start(args, num_args);
#pragma clang diagnostic pop
    for (NSUInteger i = 0; i < num_args; i++) {
        double alpha = va_arg(args, double);
        [alphas addObject:@(alpha)];
    }
    va_end(args);
    
    return ^(DKThemeVersion *themeVersion) {
        NSUInteger index = [themes indexOfObject:themeVersion];
        return (CGFloat)[alphas[index] floatValue];
    };
}


@implementation DKAlpha

+ (DKAlphaPicker)alphaPickerWithAlpha:(CGFloat)alpha {
    return ^(DKThemeVersion *themeVersion) {
        return alpha;
    };
}

@end
