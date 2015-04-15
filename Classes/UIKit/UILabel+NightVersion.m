//
//  UILabel+NightVersion.m
//  UILabel+NightVersion
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "UILabel+NightVersion.h"
#import "UIView+NightVersion.h"
#import "DKUtilities.h"

@interface UILabel ()

@property (nonatomic, strong) UIColor *normalTextColor;

@end

@implementation UILabel (NightVersion)

static char *nightTextColorKey;
static char *normalTextColorKey;

#pragma mark - Hook

+ (void)load {
    DK_MEHTOD_SWIZZLING(setTextColor:, hook_setTextColor:)
}

- (void)hook_setTextColor:(UIColor *)textColor {
    self.normalTextColor = textColor;
    [self hook_setTextColor:textColor];
}

#pragma mark - TextColor

- (UIColor *)normalTextColor {
    return objc_getAssociatedObject(self, &normalTextColorKey);
}

- (void)setNormalTextColor:(UIColor *)normalTextColor {
    objc_setAssociatedObject(self, &normalTextColorKey, normalTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)nightTextColor {
    return objc_getAssociatedObject(self, &nightTextColorKey) ? : self.textColor;
}

- (void)setNightTextColor:(UIColor *)nightTextColor {
    objc_setAssociatedObject(self, &nightTextColorKey, nightTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - SwitchColor

- (void)switchColor {
    [super switchColor];
    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
    self.textColor = (manager.themeVersion == DKThemeVersionNight) ? self.nightTextColor : self.normalTextColor;
}

@end
