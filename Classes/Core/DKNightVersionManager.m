//
//  DKNightVersionManager.m
//  DKNightVersionManager
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "DKNightVersionManager.h"

NSString *const DKThemeVersionNormal = @"NORMAL";
NSString *const DKThemeVersionNight = @"NIGHT";

NSString *const DKNightVersionThemeChangingNotificaiton = @"DKNightVersionThemeChangingNotificaiton";

CGFloat const DKNightVersionAnimationDuration = 0.3;

@interface DKNightVersionManager ()

@end

@implementation DKNightVersionManager

+ (DKNightVersionManager *)sharedNightVersionManager {
    static dispatch_once_t once;
    static DKNightVersionManager *instance;
    dispatch_once(&once, ^{
        instance = [self new];
        instance.changeStatusBar = YES;
        instance.themeVersion = DKThemeVersionNormal;
    });
    return instance;
}

+ (void)nightFalling {
    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
    manager.themeVersion = DKThemeVersionNight;
    if (manager.shouldChangeStatusBar) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
#pragma clang diagnostic pop
    }
}

+ (void)dawnComing {
    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
    manager.themeVersion = DKThemeVersionNormal;
    if (manager.shouldChangeStatusBar) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
#pragma clang diagnostic pop
    }
}

- (void)setThemeVersion:(DKThemeVersion *)themeVersion {
    if (_themeVersion == themeVersion) {
        // if type does not change, don't execute code below to enhance performance.
        return;
    }
    _themeVersion = themeVersion;
    [[NSNotificationCenter defaultCenter] postNotificationName:DKNightVersionThemeChangingNotificaiton
                                                        object:nil];
}

@end
