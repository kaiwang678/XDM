//
//  WKSizeUtil.h
//  XDM
//
//  Created by admin on 15/6/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface WKSizeUtil : NSObject

+ (CGFloat)sizeFloat:(CGFloat)f;

+ (CGSize)sizeSize:(CGSize)sz;

+ (CGRect)sizeRect:(CGRect)rt;

@end
