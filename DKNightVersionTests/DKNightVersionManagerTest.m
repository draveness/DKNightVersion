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

@end

@implementation DKNightVersionManagerTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testManagerDefaultThemeVersion {
    DKThemeVersion themeVersion = [DKNightVersionManager currentThemeVersion];
    XCTAssert(themeVersion == DKThemeVersionNormal, @"DKNightVersionManager default theme version should be DKThemeVersionNormal");
}

- (void)testDawnComing {
    [DKNightVersionManager dawnComing];
    DKThemeVersion themeVersion = [DKNightVersionManager currentThemeVersion];
    XCTAssert(themeVersion == DKThemeVersionNormal, @"After execute dawn coming method, DKNightVersionManager theme version should be DKThemeVersionNormal");
}

- (void)testNightFalling {
    [DKNightVersionManager nightFalling];
    DKThemeVersion themeVersion = [DKNightVersionManager currentThemeVersion];
    XCTAssert(themeVersion == DKThemeVersionNight, @"After execute night falling method, DKNightVersionManager theme version should be DKThemeVersionNight");
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
