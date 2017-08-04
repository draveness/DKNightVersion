//
//  DKColorTable.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/11.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "DKColorTable.h"

@interface DKColorTable ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, UIColor *> *> *table;
@property (nonatomic, strong, readwrite) NSArray<DKThemeVersion *> *themes;

@end

@implementation DKColorTable

UIColor *DKColorFromRGB(NSUInteger hex) {
    return [UIColor colorWithRed:((CGFloat)((hex >> 16) & 0xFF)/255.0) green:((CGFloat)((hex >> 8) & 0xFF)/255.0) blue:((CGFloat)(hex & 0xFF)/255.0) alpha:1.0];
}

UIColor *DKColorFromRGBA(NSUInteger hex) {
    return [UIColor colorWithRed:((CGFloat)((hex >> 24) & 0xFF)/255.0) green:((CGFloat)((hex >> 16) & 0xFF)/255.0) blue:((CGFloat)((hex >> 8) & 0xFF)/255.0) alpha:((CGFloat)(hex & 0xFF)/255.0)];
}

+ (instancetype)sharedColorTable {
    static DKColorTable *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[DKColorTable alloc] init];
        sharedInstance.file = @"DKColorTable.plist";
    });
    return sharedInstance;
}

- (void)reloadColorTable {
    // Clear previos color table
    self.table = nil;
    self.themes = nil;

    // Load color table file
    NSString *filepath = [[NSBundle bundleForClass:[self class]] pathForResource:self.file.stringByDeletingPathExtension ofType:self.file.pathExtension];
    NSDictionary *themeConfig = [NSDictionary dictionaryWithContentsOfFile:filepath];
    NSLog(@"DKColorTable:\n%@", themeConfig);
    
    for (NSString *uiKey in themeConfig.allKeys) {
        
        NSMutableDictionary *toDict = [NSMutableDictionary dictionary];
        NSDictionary *themes = themeConfig[uiKey];
        
        for (NSString *themeKey in themes.allKeys) {
            [toDict setObject:[self colorFromString:themes[themeKey]] forKey:themeKey];
        }
        
        [self.table setObject:toDict forKey:uiKey];
        self.themes = themes.allKeys;
    }
}

- (DKColorPicker)pickerWithKey:(NSString *)key {
    NSParameterAssert(key);

    NSDictionary *themeToColorDictionary = [self.table valueForKey:key];
    DKColorPicker picker = ^(DKThemeVersion *themeVersion) {
        return [themeToColorDictionary valueForKey:themeVersion];
    };
    return picker;

}

#pragma mark - Getter/Setter

- (NSMutableDictionary *)table {
    if (!_table) {
        _table = [[NSMutableDictionary alloc] init];
    }
    return _table;
}

- (void)setFile:(NSString *)file {
    _file = file;
    [self reloadColorTable];
}

#pragma mark - Helper

- (UIColor*)colorFromString:(NSString*)hexStr {
    hexStr = [hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([hexStr hasPrefix:@"0x"]) {
        hexStr = [hexStr substringFromIndex:2];
    }
    if([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    }

    NSUInteger hex = [self intFromHexString:hexStr];
    if(hexStr.length > 6) {
        return DKColorFromRGBA(hex);
    }

    return DKColorFromRGB(hex);
}

- (NSUInteger)intFromHexString:(NSString *)hexStr {
    unsigned int hexInt = 0;

    NSScanner *scanner = [NSScanner scannerWithString:hexStr];

    [scanner scanHexInt:&hexInt];

    return hexInt;
}

@end
