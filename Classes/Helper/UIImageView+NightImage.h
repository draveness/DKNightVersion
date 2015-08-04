//
//  UIImageView+NightImage.h
//  DKNightVersion
//
//  Created by Draveness on 15/6/27.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (NightImage)

@property (nonatomic, strong) UIImage *nightImage;

@property (nonatomic, strong, readonly) UIImage *normalImage;

- (void)changeColor;


@end
