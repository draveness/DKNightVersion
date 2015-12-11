//
//  DKColorTable.m
//  DKNightVersion
//
//  Created by Draveness on 15/12/11.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "DKColorTable.h"

@interface DKColorTable ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *table;

@end

@implementation DKColorTable

DKColorPicker DKPickerFromTable(NSString *key) {
    return [DKColorTable pickerWithKey:key];
}

+ (instancetype)sharedColorTable {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (void)addPicker:(DKColorPicker)picker withKey:(NSString *)key {
    NSAssert(picker != nil, @"Parameter picker must not be nil");
    NSAssert(key != nil, @"Parameter key must not be nil");
    [[[self sharedColorTable] table] setValue:picker forKey:key];
}

+ (DKColorPicker)removePickerWithKey:(NSString *)key {
    NSAssert(key != nil, @"Parameter key must not be nil");
    DKColorPicker picker = [[[self sharedColorTable] table] valueForKey:key];
    [[[self sharedColorTable] table] removeObjectForKey:key];
    return picker;
}

+ (DKColorPicker)pickerWithKey:(NSString *)key {
    NSAssert(key != nil, @"Parameter key must not be nil");
    DKColorPicker picker = [[[self sharedColorTable] table] valueForKey:key];
    NSAssert(picker != nil, @"picker with key %@ does not exist.", key);
    return picker;

}

#pragma mark - Getter/Setter

- (NSMutableDictionary<NSString *,DKColorPicker> *)table {
    if (!_table) {
        _table = [[NSMutableDictionary alloc] init];
    }
    return _table;
}

@end
