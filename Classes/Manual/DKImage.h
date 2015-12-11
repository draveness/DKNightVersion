//
//  DKImage.h
//  DKNightVersion
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKNightVersionManager.h"

DKImagePicker DKImageWithNames(NSString *normal, NSString *night);
DKImagePicker DKImageWithImages(UIImage *normal, UIImage *night);

@interface DKImage : NSObject

+ (DKImagePicker)imageNamed:(NSString *)name;
+ (DKImagePicker)pickerWithNormalImage:(UIImage *)normalImage nightImage:(UIImage *)nightImage;

@end
