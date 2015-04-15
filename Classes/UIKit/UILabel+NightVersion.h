//
//  UILabel+NightVersion.h
//  UILabel+NightVersion
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (NightVersion)

/**
 Set this property when switch to night version label text color turns to this color.
 */
@property (nonatomic, strong) UIColor *nightTextColor;

/**
 Label text color in normal version.
 */
@property (nonatomic, strong, readonly) UIColor *normalTextColor;


@end
