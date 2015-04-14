//
//  DKNightVersionManager.m
//  DKNightVersionManager
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "DKNightVersionManager.h"
#import "AppDelegate.h"

#define applicationDelegate [UIApplication sharedApplication].delegate

@implementation DKNightVersionManager

+ (DKNightVersionManager *)sharedNightVersionManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

//- (instancetype)init {
//    if (self = [super init]) {
//        _themeVersion = DSThemeVersionNight;
//    }
//    return self;
//}

- (void)setThemeVersion:(DKThemeVersion)themeVersion {
    if (_themeVersion == themeVersion) {
        // if the type does not change, do not execute code below to enhance performance.
        return;
    }
    _themeVersion = themeVersion;
    [self darkenView:applicationDelegate.window];
}

- (void)darkenView:(id)object {
    if ([object respondsToSelector:@selector(rerenderColor)]) {
        [object rerenderColor];
    }
    if ([object respondsToSelector:@selector(subviews)]) {
        if (![object subviews]) {
            // Basic case, do nothing.
            return;
        } else {
            for (id subview in [object subviews]) {
                if ([subview respondsToSelector:@selector(rerenderColor)]) {
                    [subview rerenderColor];
                }
                // recursice darken all the subviews of current view.
                [self darkenView:subview];
            }
        }
    }
}

@end
