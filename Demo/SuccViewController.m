//
//  SuccViewController.m
//  DKNightVersion
//
//  Created by Draveness on 4/28/15.
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

    self.view.backgroundColorPicker = [DKColor pickerWithNormalColor:[UIColor whiteColor] nightColor:DKColorFromRGB(0x343434)];
    self.navigationController.navigationBar.tintColorPicker = [DKColor pickerWithNormalColor:[UIColor blueColor] nightColor:[UIColor redColor]];
}

@end
