//
//  UITabBarItem+Night.h
//  IXApp
//
//  Created by Seven on 2017/6/13.
//  Copyright © 2017年 IX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UITabBarItem (Night)

@property (nullable, nonatomic, copy, setter = dk_setImagePicker:) DKImagePicker dk_imagePicker;

@property (nullable, nonatomic, copy, setter = dk_setSelectedImagePicker:) DKImagePicker dk_selectedImagePicker;

@end
