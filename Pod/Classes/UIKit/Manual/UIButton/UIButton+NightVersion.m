//
//  UIButton+NightVersion.m
//  UIButton+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "UIButton+NightVersion.h"
#import "UIView+NightVersion.h"
#import "DKNightVersionManager.h"
#import "DKNightVersionConstants.h"

@implementation UIButton (NightVersion)

#pragma mark - SwitchColor

- (void)switchColor {
    [super switchColor];
    [UIView animateWithDuration:NIGHT_ANIMATION_DURATION animations:^{
        UIColor *titleColor = ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTitleColor : self.normalTitleColor;
        [self setTitleColor:titleColor forState:UIControlStateNormal];
    }];
}

@end
