//
//  UIView+BackgroundColor.m
//  UIView+BackgroundColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "UIView+backgroundColor.h"
#import "DKNightVersionManager.h"
#import "objc/runtime.h"

@interface UIView ()

@property (nonatomic, strong) UIColor *normalBackgroundColor;

@end

@implementation UIView (BackgroundColor)

static char *nightBackgroundColorKey;
static char *normalBackgroundColorKey;

#pragma mark - Hook

+ (void)load {
    static dispatch_once_t onceToken;                                              
    dispatch_once(&onceToken, ^{                                                   
        Class class = [self class];                                                
        SEL originalSelector = @selector(setBackgroundColor:);                                  
        SEL swizzledSelector = @selector(hook_setBackgroundColor:);                                 
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

- (void)hook_setBackgroundColor:(UIColor *)backgroundColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal) {
        self.normalBackgroundColor = backgroundColor;
    }
    [self hook_setBackgroundColor:backgroundColor];
}

#pragma mark - BackgroundColor

- (UIColor *)normalBackgroundColor {
    return objc_getAssociatedObject(self, &normalBackgroundColorKey);
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor {
    objc_setAssociatedObject(self, &normalBackgroundColorKey, normalBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)nightBackgroundColor {
    return objc_getAssociatedObject(self, &nightBackgroundColorKey) ? : self.backgroundColor;
}

- (void)setNightBackgroundColor:(UIColor *)nightBackgroundColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        self.backgroundColor = nightBackgroundColor;
    }
    objc_setAssociatedObject(self, &nightBackgroundColorKey, nightBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

