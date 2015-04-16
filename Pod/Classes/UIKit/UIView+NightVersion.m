//
//  UIView+NightVersion.m
//  UIView+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "UIView+NightVersion.h"

#import "DKNightVersionManager.h"

@implementation UIView (NightVersion)

#pragma mark - SwitchColor

- (void)switchColor {
    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
    self.backgroundColor = (manager.themeVersion == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor;
}

@end
