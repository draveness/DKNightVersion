//
//  SuccViewController.m
//  DKNightVersion
//
//  Created by apple on 4/28/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "SuccViewController.h"
#import "DKNightVersion.h"

@interface SuccViewController ()

@end

@implementation SuccViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.nightBackgroundColor = [UIColor colorWithRed:0.141 green:0.145 blue:0.153 alpha:1.0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DKNightVersionManager nightFalling];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DKNightVersionManager dawnComing];
    });

}

@end
