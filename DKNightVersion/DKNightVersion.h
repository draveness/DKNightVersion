//
//  DKNightVersion.h
//  DKNightVerision
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for DKNightVersion.
FOUNDATION_EXPORT double DKNightVersionVersionNumber;

//! Project version string for DKNightVersion.
FOUNDATION_EXPORT const unsigned char DKNightVersionVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DKNightVersion/PublicHeader.h>

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

#import "metamacros.h"
#import "EXTKeyPathCoding.h"

#define _DKSetterWithPROPERTYerty(LOWERCASE) [NSString stringWithFormat:@"set%@:", [[[LOWERCASE substringToIndex:1] uppercaseString] stringByAppendingString:[LOWERCASE substringFromIndex:1]]]

#define pickerify(KLASS, PROPERTY) interface \
    KLASS (Night) \
    @property (nonatomic, copy, setter = dk_set ## PROPERTY ## Picker:) DKColorPicker dk_ ## PROPERTY ## Picker; \
    @end \
    @interface \
    KLASS () \
    @property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers; \
    @end \
    @implementation \
    KLASS (Night) \
    - (DKColorPicker)dk_ ## PROPERTY ## Picker { \
        return objc_getAssociatedObject(self, @selector(dk_ ## PROPERTY ## Picker)); \
    } \
    - (void)dk_set ## PROPERTY ## Picker:(DKColorPicker)picker { \
        objc_setAssociatedObject(self, @selector(dk_ ## PROPERTY ## Picker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC); \
        [self setValue:picker(self.dk_manager.themeVersion) forKeyPath:@keypath(self, PROPERTY)];\
        [self.pickers setValue:[picker copy] forKey:_DKSetterWithPROPERTYerty(@#PROPERTY)]; \
    } \
    @end




#endif /* _DKNIGHTVERSION_ */