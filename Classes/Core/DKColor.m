//
//  DKColor.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "DKColor.h"

@implementation DKColor

- (DKColorPicker)pickerWithUIColor:(UIColor *)color {
    return ^() {
        return color;
    };
}

+ (DKColorPicker)pickerWithUIColor:(UIColor *)color {
    return ^() {
        return color;
    };
}

- (DKColorPicker)blackColor {
    return [self pickerWithUIColor:[UIColor blackColor]];
}

- (DKColorPicker)darkGrayColor {
    return [self pickerWithUIColor:[UIColor darkGrayColor]];
}

- (DKColorPicker)lightGrayColor {
    return [self pickerWithUIColor:[UIColor lightGrayColor]];
}

- (DKColorPicker)whiteColor {
    return [self pickerWithUIColor:[UIColor whiteColor]];
}

- (DKColorPicker)grayColor {
    return [self pickerWithUIColor:[UIColor grayColor]];
}

- (DKColorPicker)redColor {
    return [self pickerWithUIColor:[UIColor redColor]];
}

- (DKColorPicker)greenColor {
    return [self pickerWithUIColor:[UIColor greenColor]];
}

- (DKColorPicker)blueColor {
    return [self pickerWithUIColor:[UIColor blueColor]];
}

- (DKColorPicker)cyanColor {
    return [self pickerWithUIColor:[UIColor cyanColor]];
}

- (DKColorPicker)yellowColor {
    return [self pickerWithUIColor:[UIColor yellowColor]];
}

- (DKColorPicker)magentaColor {
    return [self pickerWithUIColor:[UIColor magentaColor]];
}

- (DKColorPicker)orangeColor {
    return [self pickerWithUIColor:[UIColor orangeColor]];
}

- (DKColorPicker)purpleColor {
    return [self pickerWithUIColor:[UIColor purpleColor]];
}

- (DKColorPicker)brownColor {
    return [self pickerWithUIColor:[UIColor brownColor]];
}

- (DKColorPicker)clearColor {
    return [self pickerWithUIColor:[UIColor clearColor]];
}

+ (DKColorPicker)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
    return [self pickerWithUIColor:[UIColor colorWithWhite:white alpha:alpha]];
}

+ (DKColorPicker)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
    return [self pickerWithUIColor:[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha]];
}

+ (DKColorPicker)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [self pickerWithUIColor:[UIColor colorWithRed:red green:green blue:blue alpha:alpha]];
}

+ (DKColorPicker)colorWithCGColor:(CGColorRef)cgColor {
    return [self pickerWithUIColor:[UIColor colorWithCGColor:cgColor]];
}

+ (DKColorPicker)colorWithPatternImage:(UIImage *)image {
    return [self pickerWithUIColor:[UIColor colorWithPatternImage:image]];
}

#if __has_include(<CoreImage/CoreImage.h>)
+ (DKColorPicker)colorWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0) {
    return [self pickerWithUIColor:[UIColor colorWithCIColor:ciColor]];
}
#endif

@end

