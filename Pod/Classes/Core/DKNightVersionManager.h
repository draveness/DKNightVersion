//
//  DKNightVersionManager.h
//  DKNightVersionManager
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DKThemeVersionNormal,
    DKThemeVersionNight,
} DKThemeVersion;

@interface DKNightVersionManager : NSObject

/**
 *
 *  Current ThemeVersion, default is DKThemeVersionNormal.
 */
+ (DKThemeVersion)currentThemeVersion;

/**
 *
 *  Night falling
 */
+ (void)nightFalling;

/**
 *
 *  Dawn coming
 */
+ (void)dawnComing;


@end
