//
//  DRUtilities.h
//  DRDarkTheme
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#ifndef DKNightVersion_DKUtilities_h
#define DKNightVersion_DKUtilities_h

#import "objc/runtime.h"
#import "DKNightVersionManager.h"

#define DK_MEHTOD_SWIZZLING(origin, swizzle)                                       \
    static dispatch_once_t onceToken;                                              \
    dispatch_once(&onceToken, ^{                                                   \
        Class class = [self class];                                                \
        SEL originalSelector = @selector(origin);                                  \
        SEL swizzledSelector = @selector(swizzle);                                 \
        Method originalMethod = class_getInstanceMethod(class, originalSelector);  \
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);  \
        BOOL didAddMethod =                                                        \
        class_addMethod(class,                                                     \
                        originalSelector,                                          \
                        method_getImplementation(swizzledMethod),                  \
                        method_getTypeEncoding(swizzledMethod));                   \
        if (didAddMethod){                                                         \
            class_replaceMethod(class,                                             \
                                swizzledSelector,                                  \
                                method_getImplementation(originalMethod),          \
                                method_getTypeEncoding(originalMethod));           \
        } else {                                                                   \
            method_exchangeImplementations(originalMethod, swizzledMethod);        \
        }                                                                          \
    });


#endif
