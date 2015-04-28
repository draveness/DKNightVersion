//
//  UIView+TintColor.h
//  UIView+TintColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIView (TintColor)

/**
 Set this property when switch to night version view tintcolor turns to this color.
*/
@property (nonatomic, strong) UIColor *nightTintColor;

/**
 View tintcolor in normal version.
*/
@property (nonatomic, strong, readonly) UIColor *normalTintColor;


@end
