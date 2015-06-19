//
//  DPSLightGridView.h
//  DarlingPresentStore
//
//  Created by neusoft on 15/4/29.
//  Copyright (c) 2015年 WK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DPSLightGridViewDataSource,DPSLightGridViewDelegate;

@interface DPSLightGridView : UIView

@property (nonatomic,assign) id <DPSLightGridViewDataSource> dataSource;
@property (nonatomic,assign) id <DPSLightGridViewDelegate> delegate;

- (UIControl *)itemAtIndex:(NSInteger)index;

@end

@protocol DPSLightGridViewDataSource <NSObject>
@required
- (NSInteger)countOfCellForLightGridView:(DPSLightGridView *)gridView;
- (NSInteger)columnForLightGridView:(DPSLightGridView *)gridView;
- (CGSize)itemSizeForLightGridView:(DPSLightGridView *)gridView;
- (CGFloat)minimumLineSpacingForLightGridView:(DPSLightGridView *)gridView;
- (UIEdgeInsets)edgeInsetsForLightGridView:(DPSLightGridView *)gridView;
- (UIControl *)lightGridView:(DPSLightGridView *)lightGridView cellForItemAtIndex:(NSInteger)index;
@end

@protocol DPSLightGridViewDelegate <NSObject>
@optional
- (void)lightGridView:(DPSLightGridView *)lightGridView didSelectItemAtIndex:(NSInteger)index;
@end