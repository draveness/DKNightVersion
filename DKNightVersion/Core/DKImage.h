//
//  DKImage.h
//  DKNightVersion
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString DKThemeVersion;

typedef UIImage *(^DKImagePicker)(DKThemeVersion *themeVersion);

/**
 *  A C function takes an array of images return a image picker, the
 *  order of the images is just like the themes order in DKColorTable.txt
 *  file.
 *
 *  @param images An array of images
 *
 *  @return A DKImagePicker
 */
DKImagePicker DKImagePickerWithImages(NSArray<UIImage *> *images);

/**
 *  A C function takes an array of names return a image picker, the
 *  order of the images is just like the themes order in DKColorTable.txt
 *  file.
 *
 *  @param names An array of image names
 *
 *  @return A DKImagePicker
 */
DKImagePicker DKImagePickerWithNames(NSArray<NSString *> *names);

@interface DKImage : NSObject

+ (DKImagePicker)imageNamed:(NSString *)name;
+ (DKImagePicker)pickerWithNormalImage:(UIImage *)normalImage nightImage:(UIImage *)nightImage;

@end
