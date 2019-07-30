//
//  UITabBarItem+Night.h
//  ESports
//
//  Created by 时彬强 on 2017/5/5.
//  Copyright © 2017年 QQLS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DKAttribute.h"
#import <DKNightVersion/DKNightVersion.h>
//#import "NSObject+Night.h"

@interface UITabBarItem (Night)

- (void)dk_setTitleAttributePicker:(DKAttributePicker)picker forState:(UIControlState)state;
- (void)dk_setImage:(DKImagePicker)picker forState:(UIControlState)state;

@end
