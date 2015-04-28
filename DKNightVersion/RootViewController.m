//
//  RootViewController.m
//  DKNightVerision
//
//  Created by apple on 4/14/15.
//  Copyright (c) 2015 DeltaX. All rights reserved.
//

#import "RootViewController.h"
#import "SuccViewController.h"
#import "DKNightVersion.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.nightTintColor = [UIColor whiteColor];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    label.center = CGPointMake(self.view.center.x, 240);
    label.clipsToBounds = YES;
    label.font = [UIFont systemFontOfSize:25];
    label.layer.cornerRadius = 10;
    label.numberOfLines = 0;
    label.text = @"DKNightVersion is a light weight framework adding night version to your app. ";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    label.nightTextColor = [UIColor colorWithRed:0.396 green:0.400 blue:0.408 alpha:1.0];

    UIButton *nightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    nightButton.center = CGPointMake(self.view.center.x, 350);
    nightButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [nightButton setTitle:@"Night Falls" forState:UIControlStateNormal];
    [nightButton setTitleColor:[UIColor colorWithRed:0.478 green:0.651 blue:0.988 alpha:1.0] forState:UIControlStateNormal];
    nightButton.nightTitleColor = [UIColor whiteColor];
    [nightButton addTarget:self action:@selector(nightFalls) forControlEvents:UIControlEventTouchUpInside];

    UIButton *dawnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    [dawnButton setTitle:@"Dawn Comes" forState:UIControlStateNormal];
    dawnButton.titleLabel.font = [UIFont systemFontOfSize:30];
    dawnButton.center = CGPointMake(self.view.center.x, 450);
    [dawnButton setTitleColor:[UIColor colorWithRed:0.478 green:0.651 blue:0.988 alpha:1.0] forState:UIControlStateNormal];
    dawnButton.nightTitleColor = [UIColor whiteColor];
    [dawnButton addTarget:self action:@selector(dawnComes) forControlEvents:UIControlEventTouchUpInside];

    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    nextButton.center = CGPointMake(self.view.center.x, 550);
    [nextButton setTitleColor:[UIColor colorWithRed:0.478 green:0.651 blue:0.988 alpha:1.0] forState:UIControlStateNormal];
    nextButton.nightTitleColor = [UIColor whiteColor];
    [nextButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];

    self.view.nightBackgroundColor = [UIColor colorWithRed:0.141 green:0.145 blue:0.153 alpha:1.0];
    self.navigationController.navigationBar.nightBarTintColor = [UIColor colorWithRed:0.196 green:0.201 blue:0.212 alpha:1.0];

    [self.view addSubview:label];
    [self.view addSubview:nightButton];
    [self.view addSubview:dawnButton];
    [self.view addSubview:nextButton];
}

- (void)nightFalls {
    [DKNightVersionManager nightFalling];
}

- (void)dawnComes {
    [DKNightVersionManager dawnComing];
}

- (void)push {
    [self.navigationController pushViewController:[[SuccViewController alloc] init] animated:YES];
}


@end
