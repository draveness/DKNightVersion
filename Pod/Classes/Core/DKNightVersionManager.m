//
//  DKNightVersionManager.m
//  DKNightVersionManager
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "DKNightVersionManager.h"

@protocol DKNightVersionSwichColorProtocol <NSObject>

- (void)transformColor;
- (NSArray *)subviews;

@end

@interface DKNightVersionManager ()

/**
 Set themeVersion to switch to night or normal theme, default is DKThemeVersionNormal.
 */
@property (nonatomic, assign) DKThemeVersion themeVersion;

@end

@implementation DKNightVersionManager

+ (DKNightVersionManager *)sharedNightVersionManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

+ (void)nightFalling {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.sharedNightVersionManager.themeVersion = DKThemeVersionNight;
}

+ (void)dawnComing {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.sharedNightVersionManager.themeVersion = DKThemeVersionNormal;
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
    [self transformColor:[[UIApplication sharedApplication].delegate.window.subviews firstObject]];
}

- (void)transformColor:(id <DKNightVersionSwichColorProtocol>)object {
    if ([object respondsToSelector:@selector(transformColor)]) {
        [object transformColor];
    }
    if ([object respondsToSelector:@selector(subviews)]) {
        if (![object subviews]) {
            // Basic case, do nothing.
            return;
        } else {
            for (id subview in [object subviews]) {
                if ([subview respondsToSelector:@selector(transformColor)]) {
                    [subview transformColor];
                }
                // recursice darken all the subviews of current view.
                [self transformColor:subview];
            }
        }
    }
}

@end
