//
//  UIView+Shadow.h
//  CRMSystemClient
//
//  Created by tongda ju on 2017/8/2.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shadow)
/**
 阴影设置
 
 @param color 阴影颜色
 @param shadowOffsetX 阴影偏移量左右 x向右偏移4，y向下偏移4，默认(0, -3)
 @param shadowOffsetY 阴影偏移量上下 x向右偏移4，y向下偏移4，默认(0, -3)
 @param shadowOpacity 阴影透明度，默认0
 @param shadowRadius 阴影半径，默认3
 */

-(void)makeShadowWithshadowColor:(UIColor *)color shadowOffsetX:(CGFloat )shadowOffsetX shadowOffsetY:(CGFloat )shadowOffsetY shadowOpacity:(float)shadowOpacity shadowRadius:(float)shadowRadius;
/**
 设置圆角
 
 @param cornerRadiusColor 圆角尺寸
 @param borderColor 边缘线颜色
 @param borderWidth 边缘线宽度
 */
- (void)makeCornerWithCornerRadius:(CGFloat )cornerRadiusColor borderWidth:(CGFloat )borderWidth borderColor:(UIColor *)borderColor;
/**
 设置弥散阴影
 
 @param rect CGRectMake(-1, -1, self.frame.size.width, self.frame.size.height)
 */
- (void)makeShadowPathWithCGRectMake:(CGRect)rect;
@end