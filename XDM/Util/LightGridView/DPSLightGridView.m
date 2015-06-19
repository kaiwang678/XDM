//
//  DPSLightGridView.m
//  DarlingPresentStore
//
//  Created by neusoft on 15/4/29.
//  Copyright (c) 2015年 WK. All rights reserved.
//

#import "DPSLightGridView.h"

@interface DPSLightGridView ()
{
    NSMutableArray *_items;
}

@end

@implementation DPSLightGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *subViews in self.subviews) {
        [_items removeAllObjects];
        [subViews removeFromSuperview];
    }
    
    NSInteger    itemCount = [self.dataSource countOfCellForLightGridView:self];
    NSInteger    column    = [self.dataSource columnForLightGridView:self];
    CGFloat      lineSpacing = [self.dataSource minimumLineSpacingForLightGridView:self];
    CGSize       itemSize  = [self.dataSource itemSizeForLightGridView:self];
    UIEdgeInsets edgeInsets = [self.dataSource edgeInsetsForLightGridView:self];
    CGFloat      interitemSpacing;
    if (column <= 1) {
        interitemSpacing = 0.0f;
    }else
    {
        interitemSpacing = (CGRectGetWidth(self.frame)-edgeInsets.left-edgeInsets.right-column*itemSize.width)/(column-1);
    }
    for (NSInteger i = 0; i < itemCount; i++) {
        NSInteger columnIndex = i%column;
        NSInteger j = i/column;
        CGFloat x = edgeInsets.left+columnIndex*(itemSize.width+interitemSpacing);
        CGFloat y = edgeInsets.top+j*(itemSize.height+lineSpacing);
        UIControl *itemBtn = [self.dataSource lightGridView:self cellForItemAtIndex:i];
        itemBtn.tag = 2015+i;
        itemBtn.frame = CGRectMake(x, y, itemSize.width, itemSize.height);
        [self addSubview:itemBtn];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [itemBtn addGestureRecognizer:tapGestureRecognizer];
        
        [_items addObject:itemBtn];
    }
}

- (UIControl *)itemAtIndex:(NSInteger)index
{
    UIControl *item = _items[index];
    return item;
}

- (void)tapAction:(UITapGestureRecognizer*)tapGestureRecognizer
{
    if ([self.delegate respondsToSelector:@selector(lightGridView:didSelectItemAtIndex:)]) {
        [self.delegate lightGridView:self didSelectItemAtIndex:tapGestureRecognizer.view.tag-2015];
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
