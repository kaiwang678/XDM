//
//  UserHeaderIcon.m
//  XDM
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UserHeaderIcon.h"
#import "UIImageView+WebCache.h"

@implementation UserHeaderIcon
{
    UIImageView *_userHeaderImageView;
    UILabel     *_userNameLabel;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat wid = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        
        self.backgroundColor = [UIColor clearColor];
        
        _userHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, wid, wid)];
        _userHeaderImageView.layer.masksToBounds = YES;
        _userHeaderImageView.layer.cornerRadius = wid/2;
        _userHeaderImageView.image = [UIImage imageNamed:@"touxiang_tupian"];
        [self addSubview:_userHeaderImageView];
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height-10-15, wid,15)];
        _userNameLabel.textColor = [UIColor grayColor];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        _userNameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_userNameLabel];
    }
    
    return self;
}

- (void)setIconImageName:(NSString *)iconImageName
{
    if (iconImageName.length<=0) {
        return;
    }
    
    if ([iconImageName hasPrefix:@"http"]) {
        
        [_userHeaderImageView setImageWithURL:[NSURL URLWithString:iconImageName] placeholderImage:[UIImage imageNamed:@"touxiang_tupian"]];
        
    }else
    {
        _userHeaderImageView.image = [UIImage imageNamed:iconImageName];
    }
    
}

- (void)setUserName:(NSString *)userName
{
    if (userName.length > 0) {
        _userNameLabel.text = userName;
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
