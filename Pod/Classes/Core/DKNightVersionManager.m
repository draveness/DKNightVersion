//
//  DKNightVersionManager.m
//  DKNightVersionManager
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "DKNightVersionManager.h"
#import "objc/runtime.h"

@interface DKNightVersionManager ()

/**
 Set themeVersion to swich to night or normal theme, default is DKThemeVersionNormal.
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

- (void)nightFalling {
    self.themeVersion = DKThemeVersionNight;
}

- (void)dawnComing {
    self.themeVersion = DKThemeVersionNormal;
}

- (void)setThemeVersion:(DKThemeVersion)themeVersion {
    if (_themeVersion == themeVersion) {
        // if the type does not change, do not execute code below to enhance performance.
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
