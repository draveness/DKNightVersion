//
//  DKColorTable.h
//  DKNightVersion
//
//  Created by Draveness on 15/12/11.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKNightVersionManager.h"

DKColorPicker DKPickerFromTable(NSString *key);

@interface DKColorTable : NSObject


+ (instancetype)sharedColorTable;
+ (DKColorPicker)pickerWithKey:(NSString *)key;

@end
