//
//  UILabel+NightVersion.m
//  UILabel+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "UILabel+NightVersion.h"
#import "UIView+NightVersion.h"
#import "DKNightVersionManager.h"
#import "DKNightVersionConstants.h"

@implementation UILabel (NightVersion)

#pragma mark - SwitchColor

- (void)switchColor {
    [super switchColor];
    [UIView animateWithDuration:NIGHT_ANIMATION_DURATION animations:^{
        self.textColor = ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? self.nightTextColor : self.normalTextColor;
    }];
}

@end
