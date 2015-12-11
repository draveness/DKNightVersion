//
//  UIImageView+Night.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "UIImageView+Night.h"
#import <objc/runtime.h>

@implementation UIImageView (Night)

- (instancetype)dk_initWithImagePicker:(DKImagePicker)picker {
    UIImageView *imageView = [self initWithImage:picker()];
    imageView.dk_imagePicker = [picker copy];
    return imageView;
}

- (DKImagePicker)dk_imagePicker {
    return objc_getAssociatedObject(self, @selector(dk_imagePicker));
}

- (void)setDk_imagePicker:(DKImagePicker)dk_imagePicker {
    objc_setAssociatedObject(self, @selector(dk_imagePicker), dk_imagePicker, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
