//
//  UINavigationBar+TintColor.h
//  UINavigationBar+TintColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import <UIKit/UIKit.h>

@interface UINavigationBar (TintColor)

/**
 Set this property when switch to night version navigationbar tintcolor turns to this color.
*/
@property (nonatomic, strong) UIColor *nightTintColor;

/**
 Navigationbar tintcolor in normal version.
*/
@property (nonatomic, strong, readonly) UIColor *normalTintColor;


@end
