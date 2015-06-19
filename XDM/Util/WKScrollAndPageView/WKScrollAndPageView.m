//
//  WKScrollAndPageView.m
//  XDM
//
//  Created by admin on 15/6/18.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "WKScrollAndPageView.h"

@interface WKScrollAndPageView ()<UIScrollViewDelegate>
{
    UIView *_firstView;
    UIView *_middleView;
    UIView *_lastView;
    
    float _viewWidth;
    float _viewHeight;
    
    NSTimer *_autoScrollTimer;
    UITapGestureRecognizer *_tap;
}

@end

@implementation WKScrollAndPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewWidth = self.bounds.size.width;
        _viewHeight = self.bounds.size.height;
        _currentPage = 0;
        //设置scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        [_scrollView setContentOffset:CGPointMake(_viewWidth, 0) animated:NO];
        _scrollView.backgroundColor = [UIColor blackColor];
        [self addSubview:_scrollView];
        
        //设置分页
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _viewHeight-30, _viewWidth, 30)];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        
        //设置单击手势
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
        [_scrollView addGestureRecognizer:_tap];
    }
    
    return self;
}

#pragma mark - 单击手势
- (void)handleTap:(UITapGestureRecognizer *)sender
{

    if ([self.delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [self.delegate didClickPage:self atIndex:_currentPage];
    }
}

#pragma mark - 设置imageViewAry
- (void)setImageViewAry:(NSMutableArray *)imageViewAry
{
    if (imageViewAry.count<=0) {
        return;
    }
    _imageViewAry = imageViewAry;
    id frisrObject = [imageViewAry firstObject];
    id lastObject = [imageViewAry lastObject];
    [_imageViewAry insertObject:lastObject atIndex:0];
    [_imageViewAry addObject:frisrObject];
    
    _pageControl.numberOfPages = _imageViewAry.count-2;
    _scrollView.contentSize = CGSizeMake(_viewWidth*_imageViewAry.count, _viewHeight);
    
    for (int i = 0; i< _imageViewAry.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*_viewWidth, 0, _viewWidth, _viewHeight)];
        NSString *imageName = _imageViewAry[i];
        imageView.image = [UIImage imageNamed:imageName];
        [_scrollView addSubview:imageView];
    }
}

#pragma mark - UIScrollViewDelegate
////开始滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_scrollView.contentOffset.x/_viewWidth == _imageViewAry.count-1)
    {
        [_scrollView setContentOffset:CGPointMake(_viewWidth, 0) animated:NO];
    }else if(_scrollView.contentOffset.x/_viewWidth == 0)
    {
        [_scrollView setContentOffset:CGPointMake(_viewWidth*(_imageViewAry.count-2), 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_autoScrollTimer.isValid) {
        [_autoScrollTimer invalidate];
        _autoScrollTimer = nil;
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_autoScrollTimer == nil) {
        _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_autoScrollTimer forMode:NSRunLoopCommonModes];
    }
    
    CGFloat offset = _scrollView.contentOffset.x/_viewWidth;
    if (offset==1||offset == _imageViewAry.count-1) {
        _currentPage = 0;
    }else if (offset == 0||offset==_imageViewAry.count-2)
    {
        _currentPage = _imageViewAry.count-3;
    }else
    {
        _currentPage = offset-1;
    }
    _pageControl.currentPage = _currentPage;
}

#pragma mark - 自动滚动
- (void)shouldAutoShow:(BOOL)shouldStart
{
    if(shouldStart)
    {
        _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_autoScrollTimer forMode:NSRunLoopCommonModes];
    }
    else
    {
        [_autoScrollTimer invalidate];
        _autoScrollTimer = nil;
    }
}

//自动滚动
- (void)autoScroll
{
    CGFloat offset = _scrollView.contentOffset.x;
    [_scrollView setContentOffset:CGPointMake(offset+_viewWidth, 0) animated:YES];
    
    if(_scrollView.contentOffset.x/_viewWidth == _imageViewAry.count-1)
    {
        [_scrollView setContentOffset:CGPointMake(_viewWidth, 0) animated:NO];
    }
    
    
    if (offset/_viewWidth == _imageViewAry.count-2) {
        _currentPage = 0;
    }else
    {
        _currentPage = offset/_viewWidth;
    }
    _pageControl.currentPage = _currentPage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
