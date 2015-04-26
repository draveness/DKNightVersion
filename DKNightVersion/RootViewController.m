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

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.center = self.view.center;
    label.clipsToBounds = YES;
    label.layer.cornerRadius = 10;
    label.numberOfLines = 0;
    label.text = @"DKNightVersion is a light weight framework adding night version to your app. ";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    label.nightTextColor = [UIColor colorWithRed:0.396 green:0.400 blue:0.408 alpha:1.0];

    UIButton *nightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    nightButton.center = CGPointMake(self.view.center.x, 400);
    [nightButton setTitle:@"Night Falls" forState:UIControlStateNormal];
    [nightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [nightButton addTarget:self action:@selector(nightFalls) forControlEvents:UIControlEventTouchUpInside];

    UIButton *dawnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [dawnButton setTitle:@"Dawn Comes" forState:UIControlStateNormal];
    dawnButton.center = CGPointMake(self.view.center.x, 500);
    [dawnButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [dawnButton addTarget:self action:@selector(dawnComes) forControlEvents:UIControlEventTouchUpInside];

    self.view.nightBackgroundColor = [UIColor colorWithRed:0.141 green:0.145 blue:0.153 alpha:1.0];
    self.navigationController.navigationBar.nightBarTintColor = [UIColor colorWithRed:0.196 green:0.201 blue:0.212 alpha:1.0];

    [self.view addSubview:label];
    [self.view addSubview:nightButton];
    [self.view addSubview:dawnButton];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[DKNightVersionManager sharedNightVersionManager] nightFalling];
//    });
}

- (void)nightFalls {
    [[DKNightVersionManager sharedNightVersionManager] nightFalling];
}

- (void)dawnComes {
    [[DKNightVersionManager sharedNightVersionManager] dawnComing];
}


@end
