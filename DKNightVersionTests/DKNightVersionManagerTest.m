//
//  DKNightVersionManagerTest.m
//  DKNightVersion
//
//  Created by Draveness on 15/5/5.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DKNightVersionManager.h"

@interface DKNightVersionManagerTest : XCTestCase

@property (nonatomic, strong) DKNightVersionManager *manager;

@end

@implementation DKNightVersionManagerTest

- (void)setUp {
    [super setUp];
    self.manager = [DKNightVersionManager sharedManager];
}

- (void)tearDown {
    [super tearDown];
    self.manager = nil;
}

- (void)testDawnComing {
    [DKNightVersionManager dawnComing];
    DKThemeVersion *themeVersion = self.manager.themeVersion;
    XCTAssert([self.manager.themeVersion isEqualToString:themeVersion], @"After execute dawn coming method, DKNightVersionManager theme version should be DKThemeVersionNormal");
}

- (void)testNightFalling {
    [DKNightVersionManager nightFalling];
    DKThemeVersion *themeVersion = self.manager.themeVersion;
    XCTAssert([self.manager.themeVersion isEqualToString:themeVersion], @"After execute night falling method, DKNightVersionManager theme version should be DKThemeVersionNight");
}

- (void)testDawnComingPerformance {
    [self measureBlock:^{
        [DKNightVersionManager dawnComing];
    }];
}

- (void)testNightFallingPerformance {
    [self measureBlock:^{
        [DKNightVersionManager nightFalling];
    }];
}

@end
