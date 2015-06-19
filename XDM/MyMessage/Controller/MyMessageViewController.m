//
//  MyMessageViewController.m
//  XDM
//
//  Created by admin on 15/6/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyMessageViewController.h"
#import "WKScrollAndPageView.h"

@interface MyMessageViewController ()<WKScrollAndPageViewDelegate>
{
    NSMutableArray *_dataArr;
    WKScrollAndPageView *_scrollAndPageCiew;
}

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc] init];
    
    [_dataArr addObject:@"c_item0.jpg"];
    [_dataArr addObject:@"c_item1.jpg"];
    [_dataArr addObject:@"c_item2.jpg"];
    [_dataArr addObject:@"c_item3.jpg"];
    [_dataArr addObject:@"c_item4.jpg"];
    
    _scrollAndPageCiew = [[WKScrollAndPageView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight+kStatusBarHeigth, kWidth, 300)];
    [self.contentView addSubview:_scrollAndPageCiew];
    _scrollAndPageCiew.delegate = self;
    [_scrollAndPageCiew setImageViewAry:_dataArr];
    [_scrollAndPageCiew shouldAutoShow:YES];
}

- (void)didClickPage:(WKScrollAndPageView *)view atIndex:(NSInteger)index
{
    
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

- (void)dealloc
{
     [_scrollAndPageCiew shouldAutoShow:NO];
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
