//
//  LeftViewCell.m
//  XDM
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LeftViewCell.h"
#import "UIImageView+WebCache.h"
#import "LeftCellModel.h"

@implementation LeftViewCell
{
    UIImageView *_iconImageView;
    UILabel     *_titleLabel;
    
    UILabel     *_countLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 20, kLeftViewCellHeight-20-17, kLeftViewCellHeight-20-20)];
        [self addSubview:_iconImageView];
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)-10, CGRectGetMinY(_iconImageView.frame)-5, 14, 14)];
        _countLabel.backgroundColor = [UIColor redColor];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.layer.masksToBounds = YES;
        _countLabel.hidden = YES;
        _countLabel.layer.cornerRadius = 7;
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_countLabel];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+15, 20, CGRectGetWidth(frame)-CGRectGetMaxX(_iconImageView.frame)-10, kLeftViewCellHeight-20-20)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithRed:229/255.0 green:212/255.0 blue:201/255.0 alpha:1];
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setCellWithModel:(LeftCellModel *)model
{
    if (model.iconImageName.length>0) {
        if ([model.iconImageName hasPrefix:@"http"]) {
            [_iconImageView setImageWithURL:[NSURL URLWithString:model.iconImageName] placeholderImage:nil];
        }else
        {
            _iconImageView.image = [UIImage imageNamed:model.iconImageName];
        }
    }
    
    if (model.titleStr.length > 0 ) {
        _titleLabel.text = model.titleStr;
    }
}

- (void)setCountStr:(NSString *)countStr
{
    if (countStr.length==0) {
        _countLabel.hidden = YES;
    }else
    {
        _countLabel.hidden = NO;
          _countLabel.text = countStr;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
