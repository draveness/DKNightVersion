//
//  UINavigationBar+NightVersion.m
//  UINavigationBar+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "UINavigationBar+NightVersion.h"
#import "UIView+NightVersion.h"
#import "DKNightVersionManager.h"
#import "DKNightVersionConstants.h"

@implementation UINavigationBar (NightVersion)

#pragma mark - SwitchColor

- (void)switchColor {
    [super switchColor];
    [UIView animateWithDuration:NIGHT_ANIMATION_DURATION animations:^{
        self.barTintColor = ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightBarTintColor : self.normalBarTintColor;
    }];
}

@end
