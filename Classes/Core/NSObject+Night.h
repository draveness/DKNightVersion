//
//  NSObject+Night.h
//  DKNightVersion
//
//  Created by Draveness on 15/11/7.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DKNightVersionColorChangedBlock)(void);

@interface NSObject (Night)

- (void)addColorChangedBlock:(DKNightVersionColorChangedBlock)block;

@end
