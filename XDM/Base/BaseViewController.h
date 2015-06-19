//
//  BaseViewController.h
//  XDM
//
//  Created by admin on 15/6/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

@interface BaseViewController : UIViewController
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIImageView *customNavigationBar;
@property(nonatomic,copy)NSString *navTitle;
//设置导航条供子类重写的
- (void)setNavigationBar;

// 导航条按钮
- (void)setNavigationBarButtonWithImageName:(NSString *)imageName withSelector:(SEL)selector withOffset:(CGFloat)offset;
@end
