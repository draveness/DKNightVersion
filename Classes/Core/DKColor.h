//
//  DKColor.h
//  DKNightVersion
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKNightVersionManager.h"

@interface DKColor : NSObject

- (DKColorPicker)pickerWithUIColor:(UIColor *)color;

+ (DKColorPicker)pickerWithUIColor:(UIColor *)color;

- (DKColorPicker)blackColor;

- (DKColorPicker)lightGrayColor;

- (DKColorPicker)grayColor;

- (DKColorPicker)greenColor;

- (DKColorPicker)cyanColor;

- (DKColorPicker)magentaColor;

- (DKColorPicker)purpleColor;

- (DKColorPicker)clearColor;

+ (DKColorPicker)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;

+ (DKColorPicker)colorWithCGColor:(CGColorRef)cgColor;

#if __has_include(<CoreImage/CoreImage.h>)
+ (DKColorPicker)colorWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0);
#endif

@end
