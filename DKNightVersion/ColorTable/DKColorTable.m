//
//  DKColorTable.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/11.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "DKColorTable.h"

@interface NSString (Trimming)

@end

@implementation NSString (Trimming)

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

@end

@interface DKColorTable ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, UIColor *> *> *table;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *customColorMapping;
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
        sharedInstance.file = @"DKColorTable.txt";
        sharedInstance.colorMappingFile = @"DKColorMapping.plist";
    });
    return sharedInstance;
}

- (void)reloadColorTable {
    // Clear previos color table
    self.table = nil;
    self.themes = nil;

    // Load color table file
    NSString *filepath = [[NSBundle mainBundle] pathForResource:self.file.stringByDeletingPathExtension ofType:self.file.pathExtension];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];

    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);

    NSLog(@"DKColorTable:\n%@", fileContents);


    NSMutableArray *tempEntries = [[fileContents componentsSeparatedByString:@"\n"] mutableCopy];
    
    // Fixed whitespace error in txt file, fix https://github.com/Draveness/DKNightVersion/issues/64
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    [tempEntries enumerateObjectsUsingBlock:^(NSString *  _Nonnull entry, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *trimmingEntry = [entry stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [entries addObject:trimmingEntry];
    }];
    [entries filterUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];

    [entries removeObjectAtIndex:0]; // Remove theme entry

    self.themes = [self themesFromContents:fileContents];
    
    // Add entry to color table
    for (NSString *entry in entries) {
        NSArray *colors = [self colorsFromEntry:entry];
        NSString *keys = [self keyFromEntry:entry];
        
        [self addEntryWithKey:keys colors:colors themes:self.themes];
    }
}

- (void)reloadCustomColorMapping{
    //Clear previos color table
    self.customColorMapping = nil;
    
    // Load color mapping file
    NSString *filepath = [[NSBundle mainBundle] pathForResource:self.file.stringByDeletingPathExtension ofType:self.file.pathExtension];
    self.customColorMapping = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
}

- (NSArray *)themesFromContents:(NSString *)content {
    NSString *rawThemes = [content componentsSeparatedByString:@"\n"].firstObject;
    return [self separateString:rawThemes];
}

- (NSArray *)colorsFromEntry:(NSString *)entry {
    NSMutableArray *colors = [[self separateString:entry] mutableCopy];
    [colors removeLastObject];
    NSMutableArray *result = [@[] mutableCopy];
    for (NSString *number in colors) {
        [result addObject:[self colorFromString:number]];
    }
    return result;
}

- (NSString *)keyFromEntry:(NSString *)entry {
    return [self separateString:entry].lastObject;
}

- (void)addEntryWithKey:(NSString *)key colors:(NSArray *)colors themes:(NSArray *)themes {
    NSParameterAssert(themes.count == colors.count);

    __block NSMutableDictionary *themeToColorDictionary = [@{} mutableCopy];

    [themes enumerateObjectsUsingBlock:^(NSString * _Nonnull theme, NSUInteger idx, BOOL * _Nonnull stop) {
        [themeToColorDictionary setValue:colors[idx] forKey:theme];
    }];

    [self.table setValue:themeToColorDictionary forKey:key];
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

- (void)setColorMappingFile:(NSString *)colorMappingFile {
    _colorMappingFile = colorMappingFile;
    [self reloadCustomColorMapping];
    [self reloadColorTable];
}

#pragma mark - Helper
- (UIColor*)colorFromString:(NSString*)colorStr {
    colorStr = [colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([colorStr hasPrefix:@"0x"]) {
        colorStr = [colorStr substringFromIndex:2];
    }
    if([colorStr hasPrefix:@"#"]) {
        colorStr = [colorStr substringFromIndex:1];
    }
    if([colorStr hasPrefix:@"@"]){
        colorStr = [colorStr substringFromIndex:1];
        return [self colorFromCustomDefine:colorStr];
    }

    NSUInteger hex = [self intFromHexString:colorStr];
    if(colorStr.length > 6) {
        return DKColorFromRGBA(hex);
    }

    return DKColorFromRGB(hex);
}

- (UIColor*)colorFromCustomDefine:(NSString*)customStr{
    NSArray *allKeys = [self.customColorMapping allKeys];
    NSParameterAssert([allKeys containsObject:customStr]);
    NSString *hexStr = self.customColorMapping[customStr];
    return [self colorFromString:hexStr];
}

- (NSUInteger)intFromHexString:(NSString *)hexStr {
    unsigned int hexInt = 0;

    NSScanner *scanner = [NSScanner scannerWithString:hexStr];

    [scanner scanHexInt:&hexInt];

    return hexInt;
}

- (NSArray *)separateString:(NSString *)string {
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
}

@end
