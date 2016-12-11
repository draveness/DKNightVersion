//
//  UIImageView+Night.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "UIImageView+Night.h"
#import "NSObject+Night.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UIImageView (Night)

- (instancetype)dk_initWithImagePicker:(DKImagePicker)picker {
    UIImageView *imageView = [self initWithImage:picker(self.dk_manager.themeVersion)];
    imageView.dk_imagePicker = [picker copy];
    return imageView;
}

- (DKImagePicker)dk_imagePicker {
    return objc_getAssociatedObject(self, @selector(dk_imagePicker));
}

- (void)dk_setImagePicker:(DKImagePicker)picker {
    objc_setAssociatedObject(self, @selector(dk_imagePicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.image = picker(self.dk_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setImage:"];

}

- (DKAlphaPicker)dk_alphaPicker {
    return objc_getAssociatedObject(self, @selector(dk_alphaPicker));
}

- (void)dk_setAlphaPicker:(DKAlphaPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_alphaPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.alpha = picker(self.dk_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setAlpha:"];
}

- (void)night_updateColor {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"setAlpha:"]) {
            DKAlphaPicker picker = (DKAlphaPicker)obj;
            CGFloat alpha = picker(self.dk_manager.themeVersion);
            [UIView animateWithDuration:DKNightVersionAnimationDuration
                             animations:^{
                                ((void (*)(id, SEL, CGFloat))objc_msgSend)(self, NSSelectorFromString(key), alpha);
                             }];
        } else {
            SEL sel = NSSelectorFromString(key);
            DKColorPicker picker = (DKColorPicker)obj;
            UIColor *resultColor = picker(self.dk_manager.themeVersion);
            [UIView animateWithDuration:DKNightVersionAnimationDuration
                             animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                 [self performSelector:sel withObject:resultColor];
#pragma clang diagnostic pop
                             }];
            
        }
    }];
}

@end
