//
//  DKNightVersion+Internel.h
//  DKNightVersion
//
//  Created by Draveness on 12/5/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

#import "DKNightVersionConfig.h"

@interface DKNightVersion (Internel)

+ (DKNightVersion *)sharedInstance;

@property (nonatomic, strong) NSArray<DKThemeVersion *> *themes;

@end
