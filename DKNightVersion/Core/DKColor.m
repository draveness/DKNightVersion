//
//  DKColor.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "DKColor.h"
#import "DKNightVersionManager.h"

@implementation DKColor

DKColorPicker DKColorPickerWithRGB(NSUInteger normal, NSUInteger night) {
    UIColor *normalColor = [UIColor colorWithRed:((float)((normal & 0xFF0000) >> 16))/255.0 green:((float)((normal & 0xFF00) >> 8))/255.0 blue:((float)(normal & 0xFF))/255.0 alpha:1.0];
    UIColor *nightColor = [UIColor colorWithRed:((float)((night & 0xFF0000) >> 16))/255.0 green:((float)((night & 0xFF00) >> 8))/255.0 blue:((float)(night & 0xFF))/255.0 alpha:1.0];
    return DKColorPickerWithColors(normalColor, nightColor);
}

DKColorPicker DKColorPickerWithColors(UIColor *normalColor, UIColor *nightColor) {
    return ^(DKThemeVersion *themeVersion) {
        return [themeVersion isEqualToString:DKThemeVersionNormal] ? normalColor : nightColor;
    };
}

+ (DKColorPicker)pickerWithNormalColor:(UIColor *)normalColor nightColor:(UIColor *)nightColor {
    return ^(DKThemeVersion *themeVersion) {
        return [themeVersion isEqualToString:DKThemeVersionNormal] ? normalColor : nightColor;
    };
}

+ (DKColorPicker)colorPickerWithUIColor:(UIColor *)color {
    return ^(DKThemeVersion *themeVersion) {
        return color;
    };
}

+ (DKColorPicker)blackColor {
    return [self colorPickerWithUIColor:[UIColor blackColor]];
}

+ (DKColorPicker)darkGrayColor {
    return [self colorPickerWithUIColor:[UIColor darkGrayColor]];
}

+ (DKColorPicker)lightGrayColor {
    return [self colorPickerWithUIColor:[UIColor lightGrayColor]];
}

+ (DKColorPicker)whiteColor {
    return [self colorPickerWithUIColor:[UIColor whiteColor]];
}

+ (DKColorPicker)grayColor {
    return [self colorPickerWithUIColor:[UIColor grayColor]];
}

+ (DKColorPicker)redColor {
    return [self colorPickerWithUIColor:[UIColor redColor]];
}

+ (DKColorPicker)greenColor {
    return [self colorPickerWithUIColor:[UIColor greenColor]];
}

+ (DKColorPicker)blueColor {
    return [self colorPickerWithUIColor:[UIColor blueColor]];
}

+ (DKColorPicker)cyanColor {
    return [self colorPickerWithUIColor:[UIColor cyanColor]];
}

+ (DKColorPicker)yellowColor {
    return [self colorPickerWithUIColor:[UIColor yellowColor]];
}

+ (DKColorPicker)magentaColor {
    return [self colorPickerWithUIColor:[UIColor magentaColor]];
}

+ (DKColorPicker)orangeColor {
    return [self colorPickerWithUIColor:[UIColor orangeColor]];
}

+ (DKColorPicker)purpleColor {
    return [self colorPickerWithUIColor:[UIColor purpleColor]];
}

+ (DKColorPicker)brownColor {
    return [self colorPickerWithUIColor:[UIColor brownColor]];
}

+ (DKColorPicker)clearColor {
    return [self colorPickerWithUIColor:[UIColor clearColor]];
}

+ (DKColorPicker)colorPickerWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
    return [self colorPickerWithUIColor:[UIColor colorWithWhite:white alpha:alpha]];
}

+ (DKColorPicker)colorPickerWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
    return [self colorPickerWithUIColor:[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha]];
}

+ (DKColorPicker)colorPickerWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [self colorPickerWithUIColor:[UIColor colorWithRed:red green:green blue:blue alpha:alpha]];
}

+ (DKColorPicker)colorPickerWithCGColor:(CGColorRef)cgColor {
    return [self colorPickerWithUIColor:[UIColor colorWithCGColor:cgColor]];
}

+ (DKColorPicker)colorPickerWithPatternImage:(UIImage *)image {
    return [self colorPickerWithUIColor:[UIColor colorWithPatternImage:image]];
}

#if __has_include(<CoreImage/CoreImage.h>)
+ (DKColorPicker)colorPickerWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0) {
    return [self colorPickerWithUIColor:[UIColor colorWithCIColor:ciColor]];
}
#endif

@end

