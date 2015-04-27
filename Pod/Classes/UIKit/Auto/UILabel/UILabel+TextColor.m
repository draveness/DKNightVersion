//
//  UILabel+TextColor.m
//  UILabel+TextColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "UILabel+textColor.h"
#import "DKNightVersionManager.h"
#import "objc/runtime.h"

@interface UILabel ()

@property (nonatomic, strong) UIColor *normalTextColor;

@end

@implementation UILabel (TextColor)

static char *nightTextColorKey;
static char *normalTextColorKey;

#pragma mark - Hook

+ (void)load {
    static dispatch_once_t onceToken;                                              
    dispatch_once(&onceToken, ^{                                                   
        Class class = [self class];                                                
        SEL originalSelector = @selector(setTextColor:);                                  
        SEL swizzledSelector = @selector(hook_setTextColor:);                                 
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

- (void)hook_setTextColor:(UIColor *)textColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal) {
        self.normalTextColor = textColor;
    }
    [self hook_setTextColor:textColor];
}

#pragma mark - TextColor

- (UIColor *)normalTextColor {
    return objc_getAssociatedObject(self, &normalTextColorKey);
}

- (void)setNormalTextColor:(UIColor *)normalTextColor {
    objc_setAssociatedObject(self, &normalTextColorKey, normalTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)nightTextColor {
    return objc_getAssociatedObject(self, &nightTextColorKey) ? : self.textColor;
}

- (void)setNightTextColor:(UIColor *)nightTextColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        self.textColor = nightTextColor;
    }
    objc_setAssociatedObject(self, &nightTextColorKey, nightTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

