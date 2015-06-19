//
//  LeftViewCell.h
//  XDM
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLeftViewCellHeight 60

@class LeftCellModel;

@interface LeftViewCell : UIControl

@property(nonatomic,copy)NSString *countStr;

- (void)setCellWithModel:(LeftCellModel *)model;

@end
