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
 *  @author Draveness
 *
 *  Current ThemeVersion, default is DKThemeVersionNormal.
 */
+ (DKThemeVersion)currentThemeVersion;

/**
 *  @author Draveness
 *
 *  Night falling
 */
+ (void)nightFalling;

/**
 *  @author Draveness
 *
 *  Dawn coming
 */
+ (void)dawnComing;


@end
