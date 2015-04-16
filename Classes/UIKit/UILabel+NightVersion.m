//
//  UILabel+NightVersion.m
//  UILabel+NightVersion
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

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