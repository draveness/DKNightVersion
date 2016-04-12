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
    return [DKImage pickerWithNames:names];
}

DKImagePicker DKImagePickerWithImages(NSArray<UIImage *> *images) {
    return [DKImage pickerWithImages:images];
}

+ (DKImagePicker)pickerWithNormalImage:(UIImage *)normalImage nightImage:(UIImage *)nightImage {
    NSParameterAssert(normalImage);
    NSParameterAssert(nightImage);
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

+ (DKImagePicker)pickerWithNames:(NSArray<NSString *> *)names {
    DKColorTable *colorTable = [DKColorTable sharedColorTable];
    NSParameterAssert(names.count == colorTable.themes.count);
    return ^(DKThemeVersion *themeVersion) {
        NSUInteger index = [colorTable.themes indexOfObject:themeVersion];
        if (index >= colorTable.themes.count) {
            return [UIImage imageNamed:names[[colorTable.themes indexOfObject:DKThemeVersionNormal]]];
        }
        return [UIImage imageNamed:names[index]];
    };
}

+ (DKImagePicker)pickerWithImages:(NSArray<UIImage *> *)images {
    DKColorTable *colorTable = [DKColorTable sharedColorTable];
    NSParameterAssert(images.count == colorTable.themes.count);
    return ^(DKThemeVersion *themeVersion) {
        NSUInteger index = [colorTable.themes indexOfObject:themeVersion];
        if (index >= colorTable.themes.count) {
            return images[[colorTable.themes indexOfObject:DKThemeVersionNormal]];
        }
        return images[index];
    };
}

@end
