//
//  DKNightVersion.h
//  DKNightVerision
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#ifndef DKNightVerision_DKNightVersion_h
#define DKNightVerision_DKNightVersion_h

#import "DKColor.h"
#import "DKNightVersionManager.h"
#import "NSObject+Night.h"
#import "UIButton+Night.h"
#import "UIView+Night.h"
#import "UILabel+Night.h"
#import "UINavigationBar+Night.h"
#import "UITabBar+Night.h"
#import "UITableView+Night.h"
#import "UIBarButtonItem+Night.h"
#import "UITextField+Night.h"
#import "UITextView+Night.h"
#import "UIControl+Night.h"

#endif

#ifndef weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
    _Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
    _Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif