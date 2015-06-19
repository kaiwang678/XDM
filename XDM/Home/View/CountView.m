//
//  CountView.m
//  XDM
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "CountView.h"

@implementation CountView
{
    UILabel *_countLabel;
    UILabel *_titleLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat wid = CGRectGetWidth(frame);
//        CGFloat height = CGRectGetHeight(frame);
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wid, 20)];
        _countLabel.font = [UIFont systemFontOfSize:17];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_countLabel];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_countLabel.frame), wid, 15)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setCountStr:(NSString *)countStr
{
    if (countStr<=0) {
        return;
    }
    _countLabel.text = countStr;
    
}

- (void)setTitleStr:(NSString *)titleStr
{
    if (titleStr <= 0) {
        return;
    }
    _titleLabel.text = titleStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
