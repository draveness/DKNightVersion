//
//  DKNightVersionManager.m
//  DKNightVersionManager
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "DKNightVersionManager.h"

NSString *const DKNightVersionNightFallingNotification = @"DKNightVersionNightFallingNotification";
NSString *const DKNightVersionDawnComingNotification = @"DKNightVersionDawnComingNotification";

CGFloat const DKNightVersionAnimationDuration = 0;

@interface DKNightVersionManager ()

/**
 Set themeVersion to switch to night or normal theme, default is DKThemeVersionNormal.
 */
@property (nonatomic, assign) DKThemeVersion themeVersion;

@end

@implementation DKNightVersionManager

+ (DKNightVersionManager *)sharedNightVersionManager {
    static dispatch_once_t once;
    static DKNightVersionManager *instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

+ (void)nightFalling {
    self.sharedNightVersionManager.themeVersion = DKThemeVersionNight;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

+ (void)dawnComing {
    self.sharedNightVersionManager.themeVersion = DKThemeVersionNormal;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

+ (DKThemeVersion)currentThemeVersion {
    return self.sharedNightVersionManager.themeVersion;
}

- (void)setThemeVersion:(DKThemeVersion)themeVersion {
    if (_themeVersion == themeVersion) {
        // if type does not change, don't execute code below to enhance performance.
        return;
    }
    _themeVersion = themeVersion;
    if (themeVersion == DKThemeVersionNight) {
        [[NSNotificationCenter defaultCenter] postNotificationName:DKNightVersionNightFallingNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:DKNightVersionDawnComingNotification object:nil];
    }
}

@end
