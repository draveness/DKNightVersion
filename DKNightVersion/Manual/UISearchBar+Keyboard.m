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

        if (@available(iOS 13.0, *)) { // 13 and later
            UISearchTextField *searchField = obj.searchTextField;
            searchField.keyboardAppearance = UIKeyboardAppearanceDark;
        }else if (@available(iOS 7.0, *)) { // 7 to 12
            UITextField *searchField = [obj valueForKey:@"_searchField"];
            searchField.keyboardAppearance = UIKeyboardAppearanceDark;
        }else{
            obj.keyboardAppearance = UIKeyboardAppearanceAlert;
        }
    } else {
        
        if (@available(iOS 13.0, *)) { // 13 and later
            UISearchTextField *searchField = obj.searchTextField;
            searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
        }else if (@available(iOS 7.0, *)) { // 7 to 12
            UITextField *searchField = [obj valueForKey:@"_searchField"];
            searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
        }else{ //before 7.0
            obj.keyboardAppearance = UIKeyboardAppearanceDefault;
        }
    }
    
    return obj;
}

- (void)night_updateColor {
    [super night_updateColor];
    if (self.dk_manager.supportsKeyboard && [self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
#if defined(__IPHONE_13_0)
        UISearchTextField *searchField = self.searchTextField;
        searchField.keyboardAppearance = UIKeyboardAppearanceDark;
#elif defined(__IPHONE_7_0)
        UITextField *searchField = [self valueForKey:@"_searchField"];
        searchField.keyboardAppearance = UIKeyboardAppearanceDark;
#else
        self.keyboardAppearance = UIKeyboardAppearanceAlert;
#endif
    } else {
#if defined(__IPHONE_13_0)
        UISearchTextField *searchField = self.searchTextField;
        searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
#elif defined(__IPHONE_7_0)
        UITextField *searchField = [self valueForKey:@"_searchField"];
        searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
#else
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
#endif
    }
}

@end
