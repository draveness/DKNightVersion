//
//  DKNightVersionConfig.h
//  DKNightVersion
//
//  Created by Draveness on 12/5/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKNightVersionManager.h"

@interface DKNightVersion : NSObject

+ (void)setThemes:(NSArray<DKThemeVersion *> *)themes;

+ (NSArray<DKThemeVersion *> *)themes;

@end
