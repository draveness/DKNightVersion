//
//  UIView+NightVersion.m
//  UIView+NightVersion
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "UIView+NightVersion.h"
#import "DKUtilities.h"

static char *nightBackgroundColorKey;
static char *normalBackgroundColorKey;

@implementation UIView (NightVersion)

+ (void)load {
    DKNightVersionMethodSwzzling(setBackgroundColor:, hook_setBackgroundColor:)
}

- (void)hook_setBackgroundColor:(UIColor *)backgroundColor {
    objc_setAssociatedObject(self, &normalBackgroundColorKey, backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self hook_setBackgroundColor:backgroundColor];
}

- (UIColor *)normalBackgroundColor {
    return objc_getAssociatedObject(self, &normalBackgroundColorKey);
}

#pragma mark - backgroundColor

- (UIColor *)nightBackgroundColor {
    return objc_getAssociatedObject(self, &nightBackgroundColorKey) ? : self.backgroundColor;
}

- (void)setNightBackgroundColor:(UIColor *)nightBackgroundColor {
    objc_setAssociatedObject(self, &nightBackgroundColorKey, nightBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - RenderColor

- (void)rerenderColor {
    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
    if (manager.themeVersion == DKThemeVersionNight) {
        self.backgroundColor = self.nightBackgroundColor;
    } else if (manager.themeVersion == DKThemeVersionNight) {
        self.backgroundColor = self.nightBackgroundColor;
    }
}

@end
