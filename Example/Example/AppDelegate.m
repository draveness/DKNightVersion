//
//  AppDelegate.m
//  Example
//
//  Created by Draveness on 16/4/10.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "SuccViewController.h"
#import "ViewController.h"

#import "UITabBarItem+Night.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    RootViewController *vc1 = [[RootViewController alloc] init];
    vc1.tabBarItem.title = @"Root";
    [vc1.tabBarItem dk_setImage:DKImagePickerWithNames(@"tabBar_association_normal", @"tabBar_profile_normal") forState:(UIControlStateNormal)];
    [vc1.tabBarItem dk_setImage:DKImagePickerWithNames(@"tabBar_association_selected", @"tabBar_profile_selected") forState:(UIControlStateSelected)];
    [vc1.tabBarItem dk_setTitleAttributePicker:DKAttributePickerWithAttributes(@{NSForegroundColorAttributeName: [UIColor blackColor]}, @{NSForegroundColorAttributeName: [UIColor orangeColor]}, @{NSForegroundColorAttributeName: [UIColor grayColor]}) forState:(UIControlStateNormal)];
    [vc1.tabBarItem dk_setTitleAttributePicker:DKAttributePickerWithAttributes(@{NSForegroundColorAttributeName: [UIColor redColor]}, @{NSForegroundColorAttributeName: [UIColor blueColor]}, @{NSForegroundColorAttributeName: [UIColor greenColor]}) forState:(UIControlStateSelected)];
    UINavigationController *navigation1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    ViewController *vc2 = [[ViewController alloc] init];
    vc2.tabBarItem.title = @"My";
    [vc2.tabBarItem dk_setImage:DKImagePickerWithNames(@"tabBar_profile_normal", @"tabBar_association_normal") forState:(UIControlStateNormal)];
    [vc2.tabBarItem dk_setImage:DKImagePickerWithNames(@"tabBar_profile_selected", @"tabBar_association_selected") forState:(UIControlStateSelected)];
    [vc2.tabBarItem dk_setTitleAttributePicker:DKAttributePickerWithAttributes(@{NSForegroundColorAttributeName: [UIColor blackColor]}, @{NSForegroundColorAttributeName: [UIColor orangeColor]}, @{NSForegroundColorAttributeName: [UIColor grayColor]}) forState:(UIControlStateNormal)];
    [vc2.tabBarItem dk_setTitleAttributePicker:DKAttributePickerWithAttributes(@{NSForegroundColorAttributeName: [UIColor redColor]}, @{NSForegroundColorAttributeName: [UIColor blueColor]}, @{NSForegroundColorAttributeName: [UIColor greenColor]}) forState:(UIControlStateSelected)];
    UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.viewControllers = @[navigation1, navigation2];
    self.window.rootViewController = tabController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
