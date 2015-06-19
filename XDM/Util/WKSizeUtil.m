//
//  WKSizeUtil.m
//  XDM
//
//  Created by admin on 15/6/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "WKSizeUtil.h"
#import "Macro.h"
#import <UIKit/UIKit.h>

CGFloat scale()
{
    static CGFloat scale = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = kScreenWidth/375.0f;
    });
    return scale;
}

@implementation WKSizeUtil

+ (CGFloat)sizeFloat:(CGFloat)f
{
    return f * scale();
}

+ (CGSize)sizeSize:(CGSize)sz
{
    return CGSizeMake(sz.width * scale(), sz.height * scale());
}

+ (CGRect)sizeRect:(CGRect)rt
{
    return CGRectMake(rt.origin.x * scale(), rt.origin.y * scale(), rt.size.width * scale(), rt.size.height * scale());
}

@end
