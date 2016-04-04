//
//  TableViewCell.h
//  DKNightVersion
//
//  Created by Draveness on 5/1/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIButton *button;

@property (strong, nonatomic) UIColor *cellTintColor;

@end
