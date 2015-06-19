//
//  BaseViewController.m
//  XDM
//
//  Created by admin on 15/6/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end
@implementation BaseViewController
@synthesize contentView = _contentView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_contentView];
    
    //导航条
    _customNavigationBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kWidth , kNavigationBarHeight+kStatusBarHeigth)];
    _customNavigationBar.image = [UIImage imageNamed:@"titleBg"];
    _customNavigationBar.userInteractionEnabled = YES;
    [_contentView addSubview:_customNavigationBar];
    [self setNavigationBar];
}

//设置导航条供子类重写的
- (void)setNavigationBar
{
    
}

- (void)setNavTitle:(NSString *)navTitle
{
    if (navTitle.length <= 0) {
            return;
        }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/2-100/2, kStatusBarHeigth+kNavigationBarHeight/2-30/2, 100, 30)];
    label.text = navTitle;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:17];
    [_customNavigationBar addSubview:label];
}

#pragma mark - 导航条按钮
- (void)setNavigationBarButtonWithImageName:(NSString *)imageName withSelector:(SEL)selector withOffset:(CGFloat)offset 
{
    UIButton *navigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navigationButton.frame = CGRectMake(offset,20+kNavigationBarHeight/2-23/2, 12, 23);
    [navigationButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [navigationButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_customNavigationBar addSubview:navigationButton];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
