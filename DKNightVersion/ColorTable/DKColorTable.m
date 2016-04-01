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

@end

@implementation DKColorTable

UIColor *colorFromRGB(NSUInteger hex) {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0];
}

+ (instancetype)sharedColorTable {
    static DKColorTable *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[DKColorTable alloc] init];
        sharedInstance.file = @"DKColorTable.txt";
    });
    return sharedInstance;
}

- (void)reloadColorTable {
    // Clear previos color table
    self.table = nil;

    // Load color table file
    NSString *filepath = [[NSBundle mainBundle] pathForResource:self.file.stringByDeletingPathExtension ofType:self.file.pathExtension];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];

    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);

    NSLog(@"DKColorTable:\n%@", fileContents);


    NSMutableArray *entries = [[fileContents componentsSeparatedByString:@"\n"] mutableCopy];
    [entries removeObjectAtIndex:0]; // Remove theme entry

    NSArray *themes = [self themesFromContents:fileContents];

    // Add entry to color table
    for (NSString *entry in entries) {
        NSArray *colors = [self colorsFromEntry:entry];
        NSString *key = [self keyFromEntry:entry];

        [self addEntryWithKey:key colors:colors themes:themes];
    }
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
        [result addObject:colorFromRGB([self intFromHexString:number])];
    }
    return result;
}

- (NSString *)keyFromEntry:(NSString *)entry {
    return [self separateString:entry].lastObject;
}

- (void)addEntryWithKey:(NSString *)key colors:(NSArray *)colors themes:(NSArray *)themes {
    NSAssert(themes.count == colors.count, @"FATAL ERROR: Themes count must equal to colors count!");

    __block NSMutableDictionary *themeToColorDictionary = [@{} mutableCopy];

    [themes enumerateObjectsUsingBlock:^(NSString * _Nonnull theme, NSUInteger idx, BOOL * _Nonnull stop) {
        [themeToColorDictionary setValue:colors[idx] forKey:theme];
    }];

    [self.table setValue:themeToColorDictionary forKey:key];
}

- (DKColorPicker)pickerWithKey:(NSString *)key {
    NSAssert(key != nil, @"Parameter key must not be nil");
    NSDictionary *themeToColorDictionary = [self.table valueForKey:key];
    DKColorPicker picker = ^() {
        return [themeToColorDictionary valueForKey:[[DKNightVersionManager sharedNightVersionManager] themeVersion]];
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

- (NSUInteger)intFromHexString:(NSString *)hexStr {
    unsigned int hexInt = 0;

    NSScanner *scanner = [NSScanner scannerWithString:hexStr];

    NSMutableCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"#"] mutableCopy];
    [set addCharactersInString:@"0x"];

    [scanner setCharactersToBeSkipped:set];
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

- (NSArray *)separateString:(NSString *)string {
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return[array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
}

@end
