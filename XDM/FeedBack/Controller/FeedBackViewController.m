//
//  FeedBackViewController.m
//  XDM
//
//  Created by admin on 15/6/15.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 设置导航条
- (void)setNavigationBar
{
    self.navTitle = @"信息反馈";
    [self setNavigationBarButtonWithImageName:@"top_right" withSelector:@selector(backBtnAction:) withOffset:15];
}

#pragma mark - Ations
- (void)backBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
