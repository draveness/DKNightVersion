//
//  UISearchBar+Keyboard.m
//  DKNightVersion
//
//  Created by Draveness on 6/8/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

#import "UISearchBar+Keyboard.h"
#import "NSObject+Night.h"
#import <objc/runtime.h>

@interface NSObject ()

- (void)night_updateColor;

@end

@implementation UISearchBar (Keyboard)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(init);
        SEL swizzledSelector = @selector(dk_init);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });

}

- (instancetype)dk_init {
    UISearchBar *obj = [self dk_init];
    if (self.dk_manager.supportsKeyboard && [self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {

#ifdef __IPHONE_7_0
        UITextField *searchField = [obj valueForKey:@"_searchField"];
        searchField.keyboardAppearance = UIKeyboardAppearanceDark;
#else
        obj.keyboardAppearance = UIKeyboardAppearanceAlert;
#endif
    } else {
#ifdef __IPHONE_7_0
        UITextField *searchField = [obj valueForKey:@"_searchField"];
        searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
#else
        obj.keyboardAppearance = UIKeyboardAppearanceDefault;
#endif
    }

    return obj;
}

- (void)night_updateColor {
    [super night_updateColor];
    if (self.dk_manager.supportsKeyboard && [self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
#ifdef __IPHONE_7_0
        UITextField *searchField = [self valueForKey:@"_searchField"];
        searchField.keyboardAppearance = UIKeyboardAppearanceDark;
#else
        self.keyboardAppearance = UIKeyboardAppearanceAlert;
#endif
    } else {
#ifdef __IPHONE_7_0
        UITextField *searchField = [self valueForKey:@"_searchField"];
        searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
#else
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
#endif
    }
}

@end
