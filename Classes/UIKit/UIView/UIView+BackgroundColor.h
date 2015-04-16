//
//  UIView+BackgroundColor.h
//  UIView+BackgroundColor
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIView (BackgroundColor)

/**
 Set this property when switch to night version view backgroundcolor turns to this color.
*/
@property (nonatomic, strong) UIColor *nightBackgroundColor;

/**
 View backgroundcolor in normal version.
*/
@property (nonatomic, strong, readonly) UIColor *normalBackgroundColor;


@end
