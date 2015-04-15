//
//  UIView+NightVersion.m
//  UIView+NightVersion
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "UIView+NightVersion.h"
#import "DKUtilities.h"

@interface UIView ()

@property (nonatomic, strong) UIColor *normalBackgroundColor;

@end

static char *nightBackgroundColorKey;
static char *normalBackgroundColorKey;

@implementation UIView (NightVersion)

#pragma mark - Hook

+ (void)load {
    DK_MEHTOD_SWIZZLING(setBackgroundColor:, hook_setBackgroundColor:)
}

- (void)hook_setBackgroundColor:(UIColor *)backgroundColor {
    self.normalBackgroundColor = backgroundColor;
    [self hook_setBackgroundColor:backgroundColor];
}

#pragma mark - BackgroundColor

- (UIColor *)normalBackgroundColor {
    return objc_getAssociatedObject(self, &normalBackgroundColorKey);
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor {
    objc_setAssociatedObject(self, &normalBackgroundColorKey, normalBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)nightBackgroundColor {
    return objc_getAssociatedObject(self, &nightBackgroundColorKey) ? : self.backgroundColor;
}

- (void)setNightBackgroundColor:(UIColor *)nightBackgroundColor {
    objc_setAssociatedObject(self, &nightBackgroundColorKey, nightBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - SwitchColor

- (void)switchColor {
    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
    self.backgroundColor = (manager.themeVersion == DKThemeVersionNight) ? self.nightBackgroundColor : self.normalBackgroundColor;
}

@end
