//
//  DKNightVersionManager.m
//  DKNightVersionManager
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "DKNightVersionManager.h"

NSString *const DKNightVersionNightFallingNotification = @"DKNightVersionNightFallingNotification";
NSString *const DKNightVersionDawnComingNotification = @"DKNightVersionDawnComingNotification";

CGFloat const DKNightVersionAnimationDuration = 0.3f;

@protocol DKNightVersionChangeColorProtocol <NSObject>

- (void)changeColor;
- (void)changeColorWithDuration:(CGFloat)duration;
- (NSArray *)subviews;

@end

@interface DKNightVersionManager ()

/**
 Set themeVersion to switch to night or normal theme, default is DKThemeVersionNormal.
 */
@property (nonatomic, assign) DKThemeVersion themeVersion;

@property (nonatomic, strong) NSMutableSet *respondClasseses;

@end

@implementation DKNightVersionManager

+ (DKNightVersionManager *)sharedNightVersionManager {
    static dispatch_once_t once;
    static DKNightVersionManager *instance;
    dispatch_once(&once, ^{
        instance = [self new];
        instance.respondClasseses = [[NSMutableSet alloc] init];

    });
    return instance;
}

+ (void)nightFalling {
    self.sharedNightVersionManager.themeVersion = DKThemeVersionNight;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

+ (void)dawnComing {
    self.sharedNightVersionManager.themeVersion = DKThemeVersionNormal;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.class changeColor:window.subviews.lastObject withDuration:DKNightVersionAnimationDuration];
    if (themeVersion == DKThemeVersionNight) {
        [[NSNotificationCenter defaultCenter] postNotificationName:DKNightVersionNightFallingNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:DKNightVersionDawnComingNotification object:nil];
    }
}

+ (void)changeColor:(id <DKNightVersionChangeColorProtocol>)object {
    if ([object respondsToSelector:@selector(changeColor)]) {
        [object changeColor];
    }
    if ([object respondsToSelector:@selector(subviews)]) {
        if (![object subviews]) {
            // Basic case, do nothing.
            return;
        } else {
            for (id subview in [object subviews]) {
                // recursice darken all the subviews of current view.
                [self changeColor:subview];
                if ([subview respondsToSelector:@selector(changeColor)]) {
                    [subview changeColor];
                }
            }
        }
    }
}

+ (void)changeColor:(id <DKNightVersionChangeColorProtocol>)object withDuration:(CGFloat)duration {
    if ([object respondsToSelector:@selector(changeColorWithDuration:)]) {
        [object changeColorWithDuration:duration];
    }
    if ([object respondsToSelector:@selector(subviews)]) {
        if (![object subviews]) {
            // Basic case, do nothing.
            return;
        } else {
            for (id subview in [object subviews]) {
                // recursice darken all the subviews of current view.
                [self changeColor:subview withDuration:duration];
                if ([subview respondsToSelector:@selector(changeColorWithDuration:)]) {
                    [subview changeColorWithDuration:duration];
                }
            }
        }
    }
}

@end

@implementation DKNightVersionManager (RespondClasses)


+ (void)addClassToSet:(Class)klass {
    [self.sharedNightVersionManager.respondClasseses addObject:NSStringFromClass(klass)];
}

+ (void)removeClassFromSet:(Class)klass {
    [self.sharedNightVersionManager.respondClasseses removeObject:NSStringFromClass(klass)];
}

+ (NSSet *)respondClasseses {
    return [self.sharedNightVersionManager.respondClasseses copy];
}

@end
