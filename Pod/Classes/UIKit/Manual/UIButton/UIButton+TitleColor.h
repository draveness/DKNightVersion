//
//  UIButton+TitleColor.h
//  UIButton+TitleColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIButton (TitleColor)

/**
 Set this property when switch to night version button titlecolor turns to this color.
*/
@property (nonatomic, strong) UIColor *nightTitleColor;

/**
 Button titlecolor in normal version.
*/
@property (nonatomic, strong, readonly) UIColor *normalTitleColor;

@end
