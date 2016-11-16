//
//  CAShapeLayer+Night.m
//  tztMobileApp_HTSC
//
//  Created by YeTao on 2016/11/15.
//
//

#import "CAShapeLayer+Night.h"
#import <objc/runtime.h>

@interface CAShapeLayer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation CAShapeLayer (Night)

- (DKColorPicker)dk_strokeColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_strokeColorPicker));
}

- (void)setDk_strokeColorPicker:(DKColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_strokeColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.strokeColor = picker(self.dk_manager.themeVersion).CGColor;
    [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setStrokeColor:))];
}

- (DKColorPicker)dk_fillColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_strokeColorPicker));
}

- (void)setDk_fillColorPicker:(DKColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_fillColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.fillColor = picker(self.dk_manager.themeVersion).CGColor;
    [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setFillColor:))];
}

- (void)night_updateColor {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, DKColorPicker  _Nonnull picker, BOOL * _Nonnull stop) {
        CGColorRef result = picker(self.dk_manager.themeVersion).CGColor;
        [UIView animateWithDuration:DKNightVersionAnimationDuration
                         animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             if ([selector isEqualToString:NSStringFromSelector(@selector(setShadowColor:))]) {
                                 [self setShadowColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBorderColor:))]) {
                                 [self setBorderColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBackgroundColor:)) ]) {
                                 [self setBackgroundColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setStrokeColor:)) ]) {
                                 [self setStrokeColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setFillColor:)) ]) {
                                 [self setFillColor:result];
                             }
#pragma clang diagnostic pop
                         }];
    }];
}

@end
