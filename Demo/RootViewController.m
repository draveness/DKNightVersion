//
//  RootViewController.m
//  DKNightVerision
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "RootViewController.h"
#import "SuccViewController.h"
#import "PresentingViewController.h"
#import "DKNightVersion.h"
#import "TableViewCell.h"



@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    navigationLabel.text = @"DKNightVersion";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navigationLabel;

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Present" style:UIBarButtonItemStylePlain target:self action:@selector(present)];
    self.navigationItem.leftBarButtonItem = item;

    item = [[UIBarButtonItem alloc] initWithTitle:@"Change" style:UIBarButtonItemStylePlain target:self action:@selector(change)];
    self.navigationItem.rightBarButtonItem = item;


    self.tableView.dk_backgroundColorPicker =  DKColorPickerWithKey(BG);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithRGB(0xaaaaaa, 0x313131);
    navigationLabel.dk_textColorPicker = DKColorPickerWithColors([UIColor blackColor], [UIColor whiteColor]);
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithRGB(0xffffff, 0x444444);
    self.navigationItem.leftBarButtonItem.dk_tintColorPicker = DKColorPickerWithColors([UIColor blueColor], [UIColor whiteColor]);
    self.navigationItem.rightBarButtonItem.dk_tintColorPicker = DKColorPickerWithColors([UIColor blueColor], [UIColor whiteColor]);

}

- (void)change {
    DKNightVersionManager *manager = [DKNightVersionManager sharedManager];

    if ([manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        [DKNightVersionManager dawnComing];
    } else {
        [DKNightVersionManager nightFalling];
    }
}

- (void)push {
    [self.navigationController pushViewController:[[SuccViewController alloc] init] animated:YES];
}

- (void)present {
    [self presentViewController:[[PresentingViewController alloc] init] animated:YES completion:nil];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self push];
}

@end
