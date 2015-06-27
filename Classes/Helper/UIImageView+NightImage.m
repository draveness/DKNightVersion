//
//  UIImageView+NightImage.m
//  DKNightVersion
//
//  Created by apple on 15/6/27.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "UIImageView+NightImage.h"
#import <objc/runtime.h>

@implementation UIImageView (NightImage)

- (UIImage *)nightImage {
    return objc_getAssociatedObject(self, @selector(nightImage));
}

- (void)setNightImage:(UIImage *)nightImage {
    objc_setAssociatedObject(self, @selector(nightImage), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
