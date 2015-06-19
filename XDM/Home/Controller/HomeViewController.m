//
//  HomeViewController.m
//  XDM
//
//  Created by admin on 15/6/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HomeViewController.h"

#import "MyMessageViewController.h"
#import "MyOrderViewController.h"
#import "SetUpViewController.h"
#import "FeedBackViewController.h"
#import "AboutViewController.h"

#import "UserHeaderIcon.h"
#import "DPSLightGridView.h"
#import "CountView.h"
#import "LeftViewCell.h"

#import "LeftCellModel.h"

#import "CycleScrollViewTableViewCell.h"
#import "HomeSecondRowUITableViewCell.h"
#import "ListTableViewCell.h"

#import "WKSizeUtil.h"

#define kWelcomeViewCount 5

@interface HomeViewController ()<UIScrollViewDelegate,DPSLightGridViewDataSource,DPSLightGridViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *_welcomeScrollView;
    UIPageControl *_pagControl;
    BOOL          _isOpen;
    UIView *_leftView;
    
    UserHeaderIcon *_userHeaderIcon;
    UILabel *_userIDLabel;
    CountView *_integral;
    CountView *_balance;
    DPSLightGridView *_lightGridView;
    
    NSMutableArray *_leftViewData;
    
    UITableView  *_tableView;
}

@end

@implementation HomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _isOpen = YES;
        _leftViewData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    // Do any additional setup after loading the view.
    //是否第一次安装，如果是第一次安装就在加载引导页，否则直接进入主界面
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstOpenKey"]){
        [self createWelcomeView];
    }
    else{
        [self createSubViews];
        [self setLeftViewData];
    }
}

#pragma mark - 制造假数据
- (void)setLeftViewData
{
    LeftCellModel *model1 = [[LeftCellModel alloc] init];
    model1.iconImageName = @"navbar_xiaoxi.png";
    model1.titleStr = @"我的消息";
    [_leftViewData addObject:model1];
    
    LeftCellModel *model2 = [[LeftCellModel alloc] init];
    model2.iconImageName = @"navbar_dingdan.png";
    model2.titleStr = @"我的订单";
    [_leftViewData addObject:model2];
    
    LeftCellModel *model3 = [[LeftCellModel alloc] init];
    model3.iconImageName = @"navbar_shezhi.png";
    model3.titleStr = @"个人设置";
    [_leftViewData addObject:model3];
    
    LeftCellModel *model4 = [[LeftCellModel alloc] init];
    model4.iconImageName = @"navbar_fankui.png";
    model4.titleStr = @"信息反馈";
    [_leftViewData addObject:model4];
    
    LeftCellModel *model5 = [[LeftCellModel alloc] init];
    model5.iconImageName = @"navbar_contact.png";
    model5.titleStr = @"关于我们";
    [_leftViewData addObject:model5];
    
}

#pragma mark - 设置导航条
- (void)setNavigationBar
{
    //左边的button
    UIButton *userCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    userCenterBtn.frame = CGRectMake(10, 25, 28, 28);
    userCenterBtn.layer.masksToBounds = YES;
    userCenterBtn.layer.cornerRadius = 14;
    [userCenterBtn setImage:[UIImage imageNamed:@"touxiang_tupian"] forState:UIControlStateNormal];
    [userCenterBtn addTarget:self action:@selector(userCenterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar addSubview:userCenterBtn];
    
    //标题
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/2-60/2, 20+44/2-20/2, 60, 20)];
    titleImageView.image = [UIImage imageNamed:@"title"];
    [self.customNavigationBar addSubview:titleImageView];
    
}

#pragma mark - 创建引导页
- (void)createWelcomeView
{
    _welcomeScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _welcomeScrollView.delegate = self;
    _welcomeScrollView.contentSize = CGSizeMake(kWidth*kWelcomeViewCount, KHeight);
    _welcomeScrollView.pagingEnabled = YES;
    _welcomeScrollView.bounces = NO;
    _welcomeScrollView.showsHorizontalScrollIndicator = NO;
    _welcomeScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_welcomeScrollView];
    for (int i = 0; i < kWelcomeViewCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth*i, 0, kWidth, KHeight)];
        NSString *imaName = [NSString stringWithFormat:@"welcom%d.jpg",i+1];
        imageView.image = [UIImage imageNamed:imaName];
        [_welcomeScrollView addSubview:imageView];
        if (i == kWelcomeViewCount-1) {
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tapGestureRecognizer];
        }
    }
    
    _pagControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kWidth/2-100/2, KHeight-50, 100, 10)];
    _pagControl.numberOfPages = kWelcomeViewCount;
    _pagControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:_pagControl];
}

#pragma mark -  创建主界面的view
- (void)createSubViews
{
    [self createLeftView];
    
    //添加左滑右滑手势
    [self addGestureRecognizerForContentView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight+kStatusBarHeigth-3, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-kStatusBarHeigth-kNavigationBarHeight+3) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.contentView addSubview:_tableView];
    [_tableView registerClass:[CycleScrollViewTableViewCell class] forCellReuseIdentifier:@"CycleScrollViewTableViewCell"];
    
    [_tableView registerClass:[HomeSecondRowUITableViewCell class] forCellReuseIdentifier:@"HomeSecondRowUITableViewCell"];
    
    [_tableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:@"ListTableViewCell"];
    
    //用来作为判断是不是第一安装的标志
    [[NSUserDefaults standardUserDefaults] setObject:@"isFirstOpenAppFlag" forKey:@"isFirstOpenKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//给contentview添加左滑右滑的手势
- (void)addGestureRecognizerForContentView
{
    //向左滑
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.contentView addGestureRecognizer:swipeLeft];
    
    //向右滑
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.contentView addGestureRecognizer:swipeRight];
    
}

//创建左边的视图
- (void)createLeftView
{
    CGFloat wid = kWidth/3*2;
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wid, KHeight)];
    _leftView.backgroundColor =[UIColor blackColor];
    [self.view addSubview:_leftView];
    [self.view bringSubviewToFront:self.contentView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wid, KHeight/3)];
    headerView.backgroundColor = [UIColor blackColor];
    
    UIImageView *backIamge = [[UIImageView alloc] initWithFrame:headerView.frame];
    backIamge.image = [UIImage imageNamed:@"touxiang_bg"];
    [headerView addSubview:backIamge];
    
    _userHeaderIcon = [[UserHeaderIcon alloc] initWithFrame:CGRectMake(wid/2-80/2, CGRectGetHeight(headerView.frame)/2-80/2-30, 80, 80)];
    [_userHeaderIcon addTarget:self action:@selector(userHeaderIconAction:) forControlEvents:UIControlEventTouchUpInside];
    _userHeaderIcon.userName = @"清雨杨";
    [headerView addSubview:_userHeaderIcon];
    
    _userIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_userHeaderIcon.frame)+5, wid, 15)];
    _userIDLabel.textAlignment = NSTextAlignmentCenter;
    _userIDLabel.font = [UIFont boldSystemFontOfSize:15];
    _userIDLabel.textColor = [UIColor whiteColor];
    _userIDLabel.text = @"ID12345678";
    [headerView addSubview:_userIDLabel];
    
    _integral = [[CountView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_userIDLabel.frame)+30, wid/2, 50)];
    _integral.titleStr = @"人缘积分";
    _integral.countStr = @"3280";
    [headerView addSubview:_integral];
    
    _balance = [[CountView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_integral.frame), CGRectGetMaxY(_userIDLabel.frame)+30, wid/2, 50)];
    _balance.titleStr = @"现金余额";
    _balance.countStr = @"12280";
    [headerView addSubview:_balance];
    
    _lightGridView = [[DPSLightGridView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), wid, CGRectGetHeight(self.view.frame)/3*2)];
    _lightGridView.delegate = self;
    _lightGridView.dataSource = self;
    [_leftView addSubview:_lightGridView];
    
    [_leftView addSubview:headerView];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        CycleScrollViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CycleScrollViewTableViewCell" forIndexPath:indexPath];
        return cell;
        
    }else if(indexPath.row == 1)
    {
        HomeSecondRowUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSecondRowUITableViewCell" forIndexPath:indexPath];
        return cell;
        
    }else
    {
        ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return [WKSizeUtil sizeFloat:300];
        
    }else if (indexPath.row == 1)
    {
        return [WKSizeUtil sizeFloat:200];
    }else
    {
      return [WKSizeUtil sizeFloat:200];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - DPSLightGridViewDataSource && DPSLightGridViewDelegate

- (NSInteger)countOfCellForLightGridView:(DPSLightGridView *)gridView
{
    return 5;
}
- (NSInteger)columnForLightGridView:(DPSLightGridView *)gridView
{
    return 1;
}
- (CGSize)itemSizeForLightGridView:(DPSLightGridView *)gridView
{
    return CGSizeMake(CGRectGetWidth(_leftView.frame), kLeftViewCellHeight);
}
- (CGFloat)minimumLineSpacingForLightGridView:(DPSLightGridView *)gridView
{
    return 0;
}
- (UIEdgeInsets)edgeInsetsForLightGridView:(DPSLightGridView *)gridView
{
    return UIEdgeInsetsMake(15, 0, 0, 0);
}

- (UIControl *)lightGridView:(DPSLightGridView *)lightGridView cellForItemAtIndex:(NSInteger)index
{
    LeftViewCell *cell = [[LeftViewCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_leftView.frame), kLeftViewCellHeight)];
    LeftCellModel *model = _leftViewData[index];
    [cell setCellWithModel:model];
    return cell;
}

- (void)lightGridView:(DPSLightGridView *)lightGridView didSelectItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [self restIsOpen];
            MyMessageViewController *myMessageVC = [[MyMessageViewController alloc] init];
            [self.navigationController pushViewController:myMessageVC animated:YES];
        }
            break;
        case 1:
        {
            [self restIsOpen];
            MyOrderViewController *myOrderVC = [[MyOrderViewController alloc] init];
            [self.navigationController pushViewController:myOrderVC animated:YES];
            
        }
            break;
        case 2:
        {
            [self restIsOpen];
            SetUpViewController *setUpVC = [[SetUpViewController alloc] init];
            [self.navigationController pushViewController:setUpVC animated:YES];
            
        }
            break;
        case 3:
        {
            [self restIsOpen];
            FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
            [self.navigationController pushViewController:feedBackVC animated:YES];
            
        }
            break;
        case 4:
        {
            [self restIsOpen];
            AboutViewController *aboutVC = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
            
        }
            break;
        default:
            break;
    }

}

- (void)restIsOpen
{
    if (!_isOpen) {
        [self userCenterBtnAction:nil];
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pagControl.currentPage = _welcomeScrollView.contentOffset.x/kWidth;
}

#pragma mark - actions
//点击引导页最后一张
- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)sender
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        _welcomeScrollView.alpha = 0;
        _pagControl.alpha = 0;
    } completion:^(BOOL finished) {
        [_welcomeScrollView removeFromSuperview];
        [_pagControl removeFromSuperview];
        for (UIView *vi in _welcomeScrollView.subviews) {
            [vi removeGestureRecognizer:sender];
        }
        [weakSelf createSubViews];
    }];
}

//点击首页左边的按钮
- (void)userCenterBtnAction:(UIButton *)sender
{
    //打开状态
    if (_isOpen) {
        _isOpen = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.transform = CGAffineTransformMakeTranslation(kWidth/3*2, 0);
        } completion:^(BOOL finished) {
            
        }];
        
    }else//关闭状态
    {
        _isOpen = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
}

//左滑手势
- (void)swipeLeftAction:(UISwipeGestureRecognizer *)sender
{
    if (!_isOpen) {
        [self userCenterBtnAction:nil];
    }
}

//右滑手势
- (void)swipeRightAction:(UISwipeGestureRecognizer *)sender
{

    if (_isOpen) {
        [self userCenterBtnAction:nil];
    }
}

- (void)userHeaderIconAction:(UserHeaderIcon*)sender
{
    //测试显示小红圈
//    LeftViewCell *cell  =  (LeftViewCell *)[_lightGridView itemAtIndex:0];
//    cell.countStr = @"5";
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
