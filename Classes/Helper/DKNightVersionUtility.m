//
//  DKNightVersionUtility.m
//  DKNightVersion
//
//  Created by Draveness on 15/5/20.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "DKNightVersionUtility.h"
#import "DKNightVersionManager.h"

@implementation DKNightVersionUtility

+ (BOOL)shouldChangeColor:(id)object {
    __block BOOL shouldChangeColor = NO;
    [[DKNightVersionManager respondClasseses] enumerateObjectsUsingBlock:^(NSString *klassString, BOOL *stop) {
        Class klass = NSClassFromString(klassString);
        if ([object isMemberOfClass:klass]) {
            shouldChangeColor = YES;
            *stop = YES;
        }
    }];
    return shouldChangeColor;
}


@end
