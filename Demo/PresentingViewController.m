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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:self.view.frame];
    button.center = self.view.center;
    [button setTitle:@"Back" forState:UIControlStateNormal];

    [self.view addSubview:button];

    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
        self.view.normalBackgroundColor = [UIColor whiteColor];
        self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
        button.normalTitleColor = [UIColor blueColor];
        button.nightTitleColor = [UIColor whiteColor];
    }];
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
