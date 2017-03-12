//
//  DKAlpha.h
//  DKNightVersion
//
//  Created by History on 16/12/10.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString DKThemeVersion;

typedef CGFloat (^DKAlphaPicker)(DKThemeVersion *themeVersion);

DKAlphaPicker DKAlphaPickerWithAlphas(CGFloat normal, ...);

@interface DKAlpha : NSObject

+ (DKAlphaPicker)alphaPickerWithAlpha:(CGFloat)alpha;

@end
