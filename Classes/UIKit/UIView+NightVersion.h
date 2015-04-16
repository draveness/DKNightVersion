//
//  UIView+NightVersion.h
//  UIView+NightVersion
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+backgroundColor.h"

@interface UIView (NightVersion)

/**
 *  Every time color changes, this method should called to rerender view's color
 */
- (void)switchColor;

@end
