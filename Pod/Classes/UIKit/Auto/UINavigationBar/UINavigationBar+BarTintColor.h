//
//  UINavigationBar+BarTintColor.h
//  UINavigationBar+BarTintColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import <UIKit/UIKit.h>

@interface UINavigationBar (BarTintColor)

/**
 Set this property when switch to night version navigationbar bartintcolor turns to this color.
*/
@property (nonatomic, strong) UIColor *nightBarTintColor;

/**
 Navigationbar bartintcolor in normal version.
*/
@property (nonatomic, strong, readonly) UIColor *normalBarTintColor;


@end
