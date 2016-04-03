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

/**
 *  DKThemeVersion is just a alias to string, use `- isEqualToString` to
 *  compare with each `DKThemeVersion` instead of symbol `==`.
 */
typedef NSString DKThemeVersion;

extern DKThemeVersion * const DKThemeVersionNormal;
extern DKThemeVersion * const DKThemeVersionNight;

extern NSString * const DKNightVersionThemeChangingNotificaiton;

extern CGFloat const DKNightVersionAnimationDuration;

@interface DKNightVersionManager : NSObject

/**
 *  if `changeStatusBar` is set to `YES`, the status bar will change to `UIStatusBarStyleLightContent` when invoke `+ nightFalling` and `UIStatusBarStyleDefault` for `+ dawnComing`. if you would like to use `-[UIViewController preferredStatusBarStyle]`, set this value to `NO`. Default to `YES`
 */
@property (nonatomic, assign, getter=shouldChangeStatusBar) BOOL changeStatusBar;

/**
 *  Current ThemeVersion, default is DKThemeVersionNormal, change it to change the global
 *  theme, this will post `DKNightVersionThemeChangingNotificaiton`, if you want to customize
 *  your theme you can observe this notification.
 *  
 *  Ex:
 *
 *      ```objectivec
 *          DKNightVersionManager *manager = [DKNightVersionManager sharedManager];
 *          manager.themeVersion = @"RED"; // DKThemeVersionNormal or DKThemeVersionNight
 *      ```
 *
 */
@property (nonatomic, strong) DKThemeVersion *themeVersion;

/**
 *  Return the shared night version manager instance
 *
 *  @return singleton instance for DKNightVersionManager
 */
+ (DKNightVersionManager *)sharedManager;

/**
 *  Night falling. When nightFalling is called, post `DKNightVersionThemeChangingNotificaiton`.
 *  You can setup customize with observing the notification. `themeVersion` of the manager will
 *  be set to `DKNightVersionNight`. This is a convinient method for switching theme the
 *  `DKThemeVersionNight`.
 */
+ (void)nightFalling;

/**
 *  Dawn coming. When dawnComing is called, post `DKNightVersionThemeChangingNotificaiton`.
 *  You can setup customize with observing the notification.`themeVersion` of the manager will
 *  be set to `DKNightVersionNormal`. This is a convinient method for switching theme the
 *  `DKThemeVersionNormal`.
 */
+ (void)dawnComing;

/** 
 *  This method is deprecated, use `- [DKNightVersion sharedManager]` instead
 */
+ (DKNightVersionManager *)sharedNightVersionManager __deprecated_msg("use `- [DKNightVersion sharedManager]` instead");

@end
