//
//  UITabBarItem+Night.m
//  IXApp
//
//  Created by Seven on 2017/6/13.
//  Copyright © 2017年 IX. All rights reserved.
//

#import "UITabBarItem+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UITabBarItem ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UITabBarItem (Night)

- (DKImagePicker)dk_imagePicker
{
    return objc_getAssociatedObject(self, @selector(dk_imagePicker));
}

- (DKImagePicker)dk_selectedImagePicker
{
    return objc_getAssociatedObject(self, @selector(dk_selectedImagePicker));
}

- (void)dk_setImagePicker:(DKImagePicker)picker
{
    objc_setAssociatedObject(self, @selector(dk_imagePicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.image = picker(self.dk_manager.themeVersion);
    
    NSString *key = NSStringFromSelector(@selector(setImage:));
    [self.pickers setValue:[picker copy] forKey:key];
}

- (void)dk_setSelectedImagePicker:(DKImagePicker)picker
{
    objc_setAssociatedObject(self, @selector(dk_imagePicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.selectedImage = picker(self.dk_manager.themeVersion);
    
    NSString *key = NSStringFromSelector(@selector(setSelectedImage:));
    [self.pickers setValue:[picker copy] forKey:key];
}

@end
