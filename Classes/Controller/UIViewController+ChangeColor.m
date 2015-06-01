//
//  UINavigationController+ChangeColor.m
//  DKNightVersion
//
//  Created by apple on 15/5/10.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "UIViewController+ChangeColor.h"
#import "DKNightVersionManager.h"
#import "UIBarButtonItem+NightVersion.h"
#import <objc/runtime.h>

@implementation UIViewController (ChangeColor)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(hook_viewDidLoad);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod =
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }

        originalSelector = @selector(viewWillAppear:);
        swizzledSelector = @selector(hook_viewWillAppear:);
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        didAddMethod =
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)hook_viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor) name:DKNightVersionNightFallingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor) name:DKNightVersionDawnComingNotification object:nil];
    [self hook_viewDidLoad];
}

- (void)hook_viewWillAppear:(BOOL)animated {
    [self hook_viewWillAppear:animated];
    [self changeColor];
}

- (void)changeColor {
    [DKNightVersionManager changeColor:self.view];
    [self.navigationItem.leftBarButtonItem changeColor];
    [self.navigationItem.rightBarButtonItem changeColor];
    [self.navigationItem.backBarButtonItem changeColor];
}

@end
