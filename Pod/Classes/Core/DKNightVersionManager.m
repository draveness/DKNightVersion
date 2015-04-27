//
//  DKNightVersionManager.m
//  DKNightVersionManager
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "DKNightVersionManager.h"

@protocol DKNightVersionSwichColorProtocol <NSObject>

- (void)switchColor;
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
    [self switchColor:[[UIApplication sharedApplication].delegate.window.subviews firstObject]];
}

- (void)switchColor:(id <DKNightVersionSwichColorProtocol>)object {
    if ([object respondsToSelector:@selector(switchColor)]) {
        [object switchColor];
    }
    if ([object respondsToSelector:@selector(subviews)]) {
        if (![object subviews]) {
            // Basic case, do nothing.
            return;
        } else {
            for (id subview in [object subviews]) {
                if ([subview respondsToSelector:@selector(switchColor)]) {
                    [subview switchColor];
                }
                // recursice darken all the subviews of current view.
                [self switchColor:subview];
            }
        }
    }
}

@end
