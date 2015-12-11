//
//  DKImage.h
//  DKNightVersion
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKNightVersionManager.h"

DKImagePicker DKPickerWithNames(NSString *normal, NSString *night);

@interface DKImage : NSObject

+ (DKImagePicker)imageNamed:(NSString *)name;

@end
