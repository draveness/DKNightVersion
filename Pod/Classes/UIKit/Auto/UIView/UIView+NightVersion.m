//
//  UIView+NightVersion.m
//  UIView+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "UIView+NightVersion.h"

#import "DKNightVersionManager.h"
#import "DKNightVersionConstants.h"

@implementation UIView (NightVersion)

#pragma mark - SwitchColor

- (void)switchColor {
    [UIView animateWithDuration:NIGHT_ANIMATION_DURATION animations:^{
        self.backgroundColor = ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor;self.tintColor = ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTintColor : self.normalTintColor;
    }];
}

@end
