//
//  PresentingViewController.m
//  DKNightVersion
//
//  Created by apple on 15/5/10.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "PresentingViewController.h"
#import "DKNightVersion.h"

@interface PresentingViewController ()

@end

@implementation PresentingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:self.view.frame];
    button.center = self.view.center;
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    CGRect rect = CGRectMake(100, 100, 120, 80);
    UIButton *night = [[UIButton alloc] initWithFrame:rect];
    night.titleLabel.font = [UIFont systemFontOfSize:20];
    [night setTitleColor:[UIColor colorWithRed:0.478 green:0.651 blue:0.988 alpha:1.0] forState:UIControlStateNormal];

    rect = CGRectMake(100, 200, 120, 80);
    UIButton *day = [[UIButton alloc] initWithFrame:rect];
    day.titleLabel.font = [UIFont systemFontOfSize:20];
    [day setTitleColor:[UIColor colorWithRed:0.478 green:0.651 blue:0.988 alpha:1.0] forState:UIControlStateNormal];

    [night setTitle:@"Night Falls" forState:UIControlStateNormal];
    [night addTarget:self action:@selector(nightFalls) forControlEvents:UIControlEventTouchUpInside];

    [day setTitle:@"Dawn Comes" forState:UIControlStateNormal];
    [day addTarget:self action:@selector(dawnComes) forControlEvents:UIControlEventTouchUpInside];


    [self.view addSubview:button];
//    [self.view addSubview:night];
//    [self.view addSubview:day];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)nightFalls {
    [DKNightVersionManager nightFalling];
}

- (void)dawnComes {
    [DKNightVersionManager dawnComing];
}


@end
