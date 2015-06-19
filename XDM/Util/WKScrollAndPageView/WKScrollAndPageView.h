//
//  WKScrollAndPageView.h
//  XDM
//
//  Created by admin on 15/6/18.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKScrollAndPageViewDelegate;

@interface WKScrollAndPageView : UIView
{
    
}

@property(nonatomic,assign)id<WKScrollAndPageViewDelegate>delegate;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)NSMutableArray *imageViewAry;
@property(nonatomic,readonly)UIScrollView *scrollView;
@property(nonatomic,readonly)UIPageControl *pageControl;

- (void)shouldAutoShow:(BOOL)shouldStart;

@end

@protocol WKScrollAndPageViewDelegate <NSObject>

@optional

- (void)didClickPage:(WKScrollAndPageView *)view atIndex:(NSInteger)index;

@end