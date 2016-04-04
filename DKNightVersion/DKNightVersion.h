//
//  DKNightVersion.h
//  DKNightVerision
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

//! Project version string for MyFramework.
FOUNDATION_EXPORT const unsigned char DKNightVersionVersionString[];
//! Project version number for MyFramework.
FOUNDATION_EXPORT double DKNightVersionVersionNumber;

#ifndef _DKNIGHTVERSION_
#define _DKNIGHTVERSION_

#import <objc/runtime.h>

#import "DKColor.h"
#import "DKImage.h"
#import "DKNightVersionManager.h"
#import "NSObject+Night.h"

#import "DKColorTable.h"

#import "CoreAnimation+Night.h"

#import "UIBarButtonItem+Night.h"
#import "UIControl+Night.h"
#import "UILabel+Night.h"
#import "UINavigationBar+Night.h"
#import "UIPageControl+Night.h"
#import "UIProgressView+Night.h"
#import "UISearchBar+Night.h"
#import "UISlider+Night.h"
#import "UISwitch+Night.h"
#import "UITabBar+Night.h"
#import "UITableView+Night.h"
#import "UITextField+Night.h"
#import "UITextView+Night.h"
#import "UIToolbar+Night.h"
#import "UIView+Night.h"
#import "UIButton+Night.h"
#import "UIImageView+Night.h"

#define _DKSetterWithProperty(lowercase) [NSString stringWithFormat:@"set%@:", [[[lowercase substringToIndex:1] uppercaseString] stringByAppendingString:[lowercase substringFromIndex:1]]]

#define pickerify(klass, prop) interface \
    klass (Night) \
    @property (nonatomic, copy, setter = dk_set ## prop ## Picker:) DKColorPicker dk_ ## prop ## Picker; \
    @end \
    @interface \
    klass () \
    @property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers; \
    @end \
    @implementation \
    klass (Night) \
    - (DKColorPicker)dk_ ## prop ## Picker { \
    return objc_getAssociatedObject(self, @selector(dk_ ## prop ## Picker)); \
    } \
    - (void)dk_set ## prop ## Picker:(DKColorPicker)picker { \
    objc_setAssociatedObject(self, @selector(dk_ ## prop ## Picker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC); \
    [self setValue:picker(self.dk_manager.themeVersion) forKeyPath:@#prop];\
    [self.pickers setValue:[picker copy] forKey:_DKSetterWithProperty(@#prop)]; \
    } \
    @end




#endif /* _DKNIGHTVERSION_ */