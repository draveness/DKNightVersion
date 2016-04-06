//
//  DKImage.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "DKImage.h"
#import "DKNightVersionManager.h"
#import "DKColorTable.h"

@implementation DKImage

DKImagePicker DKImagePickerWithNames(NSArray<NSString *> *names) {
    DKColorTable *colorTable = [DKColorTable sharedColorTable];
    return ^(DKThemeVersion *themeVersion) {
        NSUInteger index = [colorTable.themes indexOfObject:themeVersion];
        if (index >= colorTable.themes.count) {
            return [UIImage imageNamed:names[[colorTable.themes indexOfObject:DKThemeVersionNormal]]];
        }
        return [UIImage imageNamed:names[index]];
    };
}

DKImagePicker DKImagePickerWithImages(NSArray<UIImage *> *images) {
    DKColorTable *colorTable = [DKColorTable sharedColorTable];
    return ^(DKThemeVersion *themeVersion) {
        NSUInteger index = [colorTable.themes indexOfObject:themeVersion];
        if (index >= colorTable.themes.count) {
            return images[[colorTable.themes indexOfObject:DKThemeVersionNormal]];
        }
        return images[index];
    };
}

+ (DKImagePicker)pickerWithNormalImage:(UIImage *)normalImage nightImage:(UIImage *)nightImage {
    NSAssert(normalImage, @"- pickerWithNormalImage:nightImage: lack parameter normalImage");
    NSAssert(nightImage, @"- pickerWithNormalImage:nightImage: lack parameter nightImage");
    return ^(DKThemeVersion *themeVersion) {
        return [themeVersion isEqualToString:DKThemeVersionNight] ? nightImage : normalImage;
    };
}

+ (DKImagePicker)pickerWithImage:(UIImage *)image {
    return ^(DKThemeVersion *themeVersion) {
        return image;
    };
}

+ (DKImagePicker)imageNamed:(NSString *)name {
    return [self pickerWithImage:[UIImage imageNamed:name]];
}

@end
