//
//  UILabel+NightVersion.m
//  UILabel+NightVersion
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "UILabel+NightVersion.h"
#import "UIView+NightVersion.h"
#import "DSUtilities.h"

static char *nightTextColorKey;
static char *normalTextColorKey;

@implementation UILabel (NightVersion)

+ (void)load {
    DKNightVersionMethodSwzzling(setTextColor:, hook_setTextColor:)
}

- (void)hook_setTextColor:(UIColor *)textColor {
    objc_setAssociatedObject(self, &normalTextColorKey, textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self hook_setTextColor:textColor];
}

- (UIColor *)normalTextColor {
    return objc_getAssociatedObject(self, &normalTextColorKey);
}

#pragma mark - textColor

- (UIColor *)nightTextColor {
    return objc_getAssociatedObject(self, &nightTextColorKey) ? : self.textColor;
}

- (void)setNightTextColor:(UIColor *)nightTextColor {
    objc_setAssociatedObject(self, &nightTextColorKey, nightTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - RenderColor

- (void)rerenderColor {
    [super rerenderColor];
    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
    if (manager.themeVersion == DSThemeVersionNight) {
        self.textColor = self.nightTextColor;
    } else if (manager.themeVersion == DSThemeVersionNormal) {
        self.textColor = self.normalTextColor;
    }
}

@end
