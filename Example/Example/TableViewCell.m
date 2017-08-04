//
//  TableViewCell.m
//  DKNightVersion
//
//  Created by Draveness on 5/1/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "TableViewCell.h"
#import <DKNightVersion/DKNightVersion.h>

@interface TableViewCell ()

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 270, 80)];
        self.label.numberOfLines = 0;
        self.label.text = @"DKNightVersion is a light weight framework adding night mode to your iOS app.";
        self.label.textColor = [UIColor darkGrayColor];
        self.label.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:self.label];

        CGRect rect = CGRectMake(250, 10, 120, 80);
        self.button = [[UIButton alloc] initWithFrame:rect];
        self.button.titleLabel.font = [UIFont systemFontOfSize:20];
        [self.button setTitleColor:[UIColor colorWithRed:0.478 green:0.651 blue:0.988 alpha:1.0] forState:UIControlStateNormal];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.button];

//        self.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 25, 50, 50)];

        imageView.dk_imagePicker = DKImagePickerWithNames(@"normal1", @"night1", @"normal1");
//        imageView.dk_alphaPicker = DKAlphaPickerWithAlphas(1.f, 0.5f, 0.1f);
        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)setCellTintColor:(UIColor *)cellTintColor {
    _cellTintColor = cellTintColor;
    self.contentView.backgroundColor = _cellTintColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(HIGHLIGHTED);
    } else {
        self.contentView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    }
}

@end
