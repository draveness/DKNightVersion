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
#import "TableViewCell.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"Cell"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self nightFalls];
//    });
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    navigationLabel.text = @"DKNightVersion";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.nightTextColor = [UIColor whiteColor];
    self.navigationItem.titleView = navigationLabel;
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

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSLog(@"isisisisis %@",cell.contentView.class);
    if (indexPath.row % 2 == 0) {
        [cell.button setTitle:@"Night Falls" forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(nightFalls) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [cell.button setTitle:@"Dawn Comes" forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(dawnComes) forControlEvents:UIControlEventTouchUpInside];
    }

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
