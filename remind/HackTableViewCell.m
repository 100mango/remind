//
//  HackTableViewCell.m
//  remind
//
//  Created by Mango on 14-5-24.
//  Copyright (c) 2014年 Mango. All rights reserved.
//

#import "HackTableViewCell.h"

@interface HackTableViewCell ()

@property (strong,nonatomic) UIImageView *iconView;
@property (strong,nonatomic) UIImageView *backGroundView;
@property (strong,nonatomic) UILabel *titleLabel;
@end

@implementation HackTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(39/2, 19/2, 82/2, 82/2)];
        _backGroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 120/2)];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(168/2, 24/2, 160, 38)];
        self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        self.titleLabel.textColor = [UIColor colorWithRed:119/255.0 green:82/255.0 blue:42/255.0 alpha:1];
        
        [self addSubview:self.iconView];
        [self addSubview:self.backGroundView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)configureCellWithNumber:(NSInteger)number IconName:(NSString*)name Titile:(NSString*)titile
{
    if (number %2 == 0) {
        self.backGroundView.image = [UIImage imageNamed:@"title1"];
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:168/255.0 blue:0/255.0 alpha:1];
    }
    else
    {
        self.backGroundView.image = [UIImage imageNamed:@"title2"];
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:196/255.0 blue:38/255.0 alpha:1];
    }
    
    self.iconView.image = [UIImage imageNamed:name];
    self.titleLabel.text = titile;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
