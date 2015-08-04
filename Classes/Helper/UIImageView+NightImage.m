//
//  UIImageView+NightImage.m
//  DKNightVersion
//
//  Created by Draveness on 15/6/27.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "UIImageView+NightImage.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) UIImage *normalImage;

@end


@implementation UIImageView (NightImage)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(setImage:);
        SEL swizzledSelector = @selector(hook_setImage:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod =
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)hook_setImage:(UIImage *)image {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal)
        [self setNormalImage:image];
    [self hook_setImage:image];
}

- (UIImage *)nightImage {
    return objc_getAssociatedObject(self, @selector(nightImage));
}

- (void)setNightImage:(UIImage *)nightImage {
    objc_setAssociatedObject(self, @selector(nightImage), nightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)normalImage {
    return objc_getAssociatedObject(self, @selector(normalImage));
}

- (void)setNormalImage:(UIImage *)normalImage {
    objc_setAssociatedObject(self, @selector(normalImage), normalImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)changeColor {
    [self setImage:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal) ? self.normalImage : self.nightImage];
}

@end
