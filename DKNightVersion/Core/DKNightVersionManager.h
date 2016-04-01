//
//  DKNightVersionManager.h
//  DKNightVersionManager
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKColor.h"
#import "DKImage.h"

typedef id(^DKPicker)(void);

typedef NSString DKThemeVersion;

extern NSString *const DKNightVersionThemeChangingNotificaiton;
extern DKThemeVersion *const DKThemeVersionNormal;
extern DKThemeVersion *const DKThemeVersionNight;

extern CGFloat const DKNightVersionAnimationDuration;

@interface DKNightVersionManager : NSObject

/**
 *  if `changeStatusBar` is set to `YES`, the status bar will change to `UIStatusBarStyleLightContent` when invoke `+ nightFalling` and `UIStatusBarStyleDefault` for `+ dawnComing`. if you would like to use `-[UIViewController preferredStatusBarStyle]`, set this value to `NO`. Default to `YES`
 */
@property (nonatomic, assign, getter=shouldChangeStatusBar) BOOL changeStatusBar;

/**
 *  Current ThemeVersion, default is DKThemeVersionNormal, change it to change the global
 *  theme
 */
@property (nonatomic, strong) DKThemeVersion *themeVersion;

/**
 *  Return the shared night version manager instance
 *
 *  @return singleton instance for DKNightVersionManager
 */
+ (DKNightVersionManager *)sharedNightVersionManager;

/**
 *  Night falling. When nightFalling is called, post DKNightVersionNightFallingNotification. You  can setup customize with observing the notification.
 */
+ (void)nightFalling;

/**
 *  Dawn coming. When dawnComing is called, post DKNightVersionDawnComingNotification. You  can setup customize with observing the notification.
 */
+ (void)dawnComing;

@end
