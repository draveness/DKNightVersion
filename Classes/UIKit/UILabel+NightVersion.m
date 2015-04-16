//
//  UILabel+NightVersion.m
//  UILabel+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "UILabel+NightVersion.h"
#import "UIView+NightVersion.h"
#import "DKNightVersionManager.h"

@implementation UILabel (NightVersion)

#pragma mark - SwitchColor

- (void)switchColor {
    [super switchColor];
    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
    self.textColor = (manager.themeVersion == DKThemeVersionNight) ? self.nightTextColor : self.normalTextColor;
}

@end
