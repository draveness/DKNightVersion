//
//  DKNightVersion+Internel.m
//  DKNightVersion
//
//  Created by Draveness on 12/5/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

#import "DKNightVersionConfig+Internel.h"
#import <objc/runtime.h>

@implementation DKNightVersion (Internel)

+ (instancetype)sharedInstance {
    static DKNightVersion *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.themes = @[DKThemeVersionNormal, DKThemeVersionNight];
    });
    return sharedInstance;
}

- (void)setThemes:(NSArray<DKThemeVersion *> *)themes {
    objc_setAssociatedObject(self, @selector(themes), themes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<DKThemeVersion *> *)themes {
    return objc_getAssociatedObject(self, @selector(themes));
}

@end
