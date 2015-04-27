//
//  UINavigationBar+BarTintColor.m
//  UINavigationBar+BarTintColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.

#import "UINavigationBar+barTintColor.h"
#import "DKNightVersionManager.h"
#import "objc/runtime.h"

@interface UINavigationBar ()

@property (nonatomic, strong) UIColor *normalBarTintColor;

@end

@implementation UINavigationBar (BarTintColor)

static char *nightBarTintColorKey;
static char *normalBarTintColorKey;

#pragma mark - Hook

+ (void)load {
    static dispatch_once_t onceToken;                                              
    dispatch_once(&onceToken, ^{                                                   
        Class class = [self class];                                                
        SEL originalSelector = @selector(setBarTintColor:);                                  
        SEL swizzledSelector = @selector(hook_setBarTintColor:);                                 
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

- (void)hook_setBarTintColor:(UIColor *)barTintColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal) {
        self.normalBarTintColor = barTintColor;
    }
    [self hook_setBarTintColor:barTintColor];
}

#pragma mark - BarTintColor

- (UIColor *)normalBarTintColor {
    return objc_getAssociatedObject(self, &normalBarTintColorKey);
}

- (void)setNormalBarTintColor:(UIColor *)normalBarTintColor {
    objc_setAssociatedObject(self, &normalBarTintColorKey, normalBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)nightBarTintColor {
    return objc_getAssociatedObject(self, &nightBarTintColorKey) ? : self.barTintColor;
}

- (void)setNightBarTintColor:(UIColor *)nightBarTintColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        self.barTintColor = nightBarTintColor;
    }
    objc_setAssociatedObject(self, &nightBarTintColorKey, nightBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

