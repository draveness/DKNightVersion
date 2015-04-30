//
//  DKNightVersionManager.h
//  DKNightVersionManager
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


typedef enum : NSUInteger {
    DKThemeVersionNormal,
    DKThemeVersionNight,
} DKThemeVersion;

@interface DKNightVersionManager : NSObject

/**
 *  Current ThemeVersion, default is DKThemeVersionNormal.
 */
+ (DKThemeVersion)currentThemeVersion;

/**
 *  Night falling
 */
+ (void)nightFalling;

/**
 *  Dawn coming
 */
+ (void)dawnComing;

/**
 *  Use default night color or not, default is YES, set it use setUseDefaultNightColor: method
 *
 *  @return Use default night color or not, default is YES
 */
+ (BOOL)useDefaultNightColor;

/**
 *  Set whether or not use default night color
 *
 *  @param use Bool value to set whether to use default color
 */
+ (void)setUseDefaultNightColor:(BOOL)use;


@end
