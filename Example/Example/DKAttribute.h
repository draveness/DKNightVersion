//
//  DKAttribute.h
//  ESports
//
//  Created by 时彬强 on 2017/5/5.
//  Copyright © 2017年 QQLS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString DKThemeVersion;

typedef NSDictionary *(^DKAttributePicker)(DKThemeVersion *themeVersion);

DKAttributePicker DKAttributePickerWithAttributes(NSDictionary *normal, ...);

@interface DKAttribute : NSObject

@end
