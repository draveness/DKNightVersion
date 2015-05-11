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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
