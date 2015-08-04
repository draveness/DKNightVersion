//
//  PresentingViewController.m
//  DKNightVersion
//
//  Created by Draveness on 15/5/10.
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
    self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:self.view.frame];
    button.center = self.view.center;
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.nightTitleColor = [UIColor whiteColor];

    [self.view addSubview:button];
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
