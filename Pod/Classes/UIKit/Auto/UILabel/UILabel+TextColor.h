//
//  UILabel+TextColor.h
//  UILabel+TextColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import <UIKit/UIKit.h>

@interface UILabel (TextColor)

/**
 Set this property when switch to night version label textcolor turns to this color.
*/
@property (nonatomic, strong) UIColor *nightTextColor;

/**
 Label textcolor in normal version.
*/
@property (nonatomic, strong, readonly) UIColor *normalTextColor;


@end
