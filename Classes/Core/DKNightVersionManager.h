//
//  DKNightVersionManager.h
//  DKNightVersionManager
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKColor.h"
#import "DKImage.h"

typedef NS_ENUM(NSUInteger, DKThemeVersion) {
    DKThemeVersionNormal,
    DKThemeVersionNight
};

typedef id(^DKPicker)(void);

extern NSString *const DKNightVersionNightFallingNotification;
extern NSString *const DKNightVersionDawnComingNotification;

extern CGFloat const DKNightVersionAnimationDuration;

@interface DKNightVersionManager : NSObject

/**
 *  if `changeStatusBar` is set to `YES`, the status bar will change to `UIStatusBarStyleLightContent` when invoke `+ nightFalling` and `UIStatusBarStyleDefault` for `+ dawnComing`. if you would like to use `-[UIViewController preferredStatusBarStyle]`, set this value to `NO`. Default to `YES`
 */
@property (nonatomic, assign, getter=shouldChangeStatusBar) BOOL changeStatusBar;

/**
 *  Return the shared night version manager instance
 *
 *  @return singleton instance for DKNightVersionManager
 */
+ (DKNightVersionManager *)sharedNightVersionManager;

/**
 *  Current ThemeVersion, default is DKThemeVersionNormal.
 *
 *  @return Current theme version, default is DKThemeVersionNormal. Readonly
 */
+ (DKThemeVersion)currentThemeVersion;

/**
 *  Night falling. When nightFalling is called, post DKNightVersionNightFallingNotification. You  can setup customize with observing the notification.
 */
+ (void)nightFalling;

/**
 *  Dawn coming. When dawnComing is called, post DKNightVersionDawnComingNotification. You  can setup customize with observing the notification.
 */
+ (void)dawnComing;

@end
