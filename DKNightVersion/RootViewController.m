//
//  RootViewController.m
//  DKNightVerision
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "RootViewController.h"
#import "DKNightVersion.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.center = self.view.center;
    label.clipsToBounds = YES;
    label.layer.cornerRadius = 10;
    label.text = @"label";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    label.nightTextColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor lightGrayColor];
    label.nightBackgroundColor = [UIColor darkGrayColor];

    [self.view addSubview:label];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[DKNightVersionManager sharedNightVersionManager] nightFalling];
    });
}



@end
