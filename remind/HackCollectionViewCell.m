//
//  HackCollectionViewCell.m
//  remind
//
//  Created by Mango on 14-5-24.
//  Copyright (c) 2014年 Mango. All rights reserved.
//

#import "HackCollectionViewCell.h"

@interface HackCollectionViewCell ()

@property (strong,nonatomic) UILabel *remindTitle;
@property (strong,nonatomic) UIImageView *imageView;

@end
@implementation HackCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //_remindTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 100, 130)];
        //[self addSubview:self.remindTitle];
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140/2, 140/2)];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setCellWithIconName:(NSString*)name
{
    //self.remindTitle.text = name;
    NSString *imagename = [NSString stringWithFormat:@"%@.png",name];
    self.imageView.image = [UIImage imageNamed:imagename];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
