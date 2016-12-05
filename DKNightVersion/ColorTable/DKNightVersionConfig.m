//
//  DKNightVersionConfig.m
//  DKNightVersion
//
//  Created by Draveness on 12/5/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

#import "DKNightVersionConfig.h"
#import "DKNightVersionConfig+Internel.h"

@implementation DKNightVersion

+ (void)setThemes:(NSArray<DKThemeVersion *> *)themes {
    DKNightVersion *instance = [DKNightVersion sharedInstance];
    instance.themes = themes;
}

+ (NSArray<DKThemeVersion *> *)themes {
    DKNightVersion *instance = [DKNightVersion sharedInstance];
    return instance.themes;
}


@end

