//
//  SuccViewController.m
//  DKNightVersion
//
//  Created by Draveness on 4/28/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "SuccViewController.h"
#import <DKNightVersion/DKNightVersion.h>

@interface SuccViewController ()

@end

@implementation SuccViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.navigationController.navigationBar.dk_tintColorPicker = DKColorPickerWithKey(TINT);

    UITextField *textField = [[UITextField alloc] init];
    textField.frame = self.view.frame;
    textField.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    [self.view addSubview:textField];
}

@end
