//
//  UIView+NightVersion.h
//  UIView+NightVersion
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NightVersion)

/**
 Set this property when swich to night version view background color turns to this color.
 */
@property (nonatomic, strong) UIColor *nightBackgroundColor;

/**
 View background color in normal version.
 */
@property (nonatomic, strong, readonly) UIColor *normalBackgroundColor;


/**
 *  Every time color changes, this method should called to rerender view's color
 */
- (void)switchColor;

@end
