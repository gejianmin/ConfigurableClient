//
//  UIView+Util.h
//  UsedCar
//
//  Created by Alan on 13-10-25.
//  Copyright (c) 2013年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const kMaxTextLengthEventName ;



@interface UIView (Util)

/* frame.origin.x */
@property (nonatomic) CGFloat minX;
@property (nonatomic) CGFloat x;

/* frame.origin.y */
@property (nonatomic) CGFloat minY;
@property (nonatomic) CGFloat y;

/* frame.origin.x + frame.size.width */
@property (nonatomic) CGFloat maxX;

/* frame.origin.y + frame.size.height */
@property (nonatomic) CGFloat maxY;

/* frame.size.width */
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat w;

/* frame.size.height */
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat h;


/**
 获取view向对于屏幕的x坐标,对scrollView上的子控件也有效
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
    获取view向对于屏幕的y坐标,对scrollView上的子控件也有效
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
    获取view向对于屏幕的frame,对scrollView上的子控件也有效
 */
@property (nonatomic, readonly) CGRect screenFrame;

/* frame.origin */
@property (nonatomic) CGPoint origin;

/* frame.size */
@property (nonatomic) CGSize size;

/**
    圆角(自动裁剪)
 */
@property (nonatomic) CGFloat cornerRadius;//全角

@property (nonatomic) CGFloat cornerRadiusOfTop;//上
@property (nonatomic) CGFloat cornerRadiusOfTopRight;//左上
@property (nonatomic) CGFloat cornerRadiusOfTopLeft;//右上

@property (nonatomic) CGFloat cornerRadiusOfBottom;//下
@property (nonatomic) CGFloat cornerRadiusOfBottomRight;//左下
@property (nonatomic) CGFloat cornerRadiusOfBottomLeft;//右下

/**
    为view设置一个宽度为(kLinePixel)的边框的颜色
 */
@property (nonatomic,strong) UIColor *borderColor;

/**
    获取子视图或者子视图的子视图....一直类推到最后一个view,中的第一响应者
 */
- (UIView*)subviewWithFirstResponder;
/**
 获取 子视图或者子视图的子视图....一直类推到最最后一个view,的指定类的view
 */

- (UIView*)subviewWithClass:(Class)cls;
/**
    获取 父视图或者父视图的父视图....一直类推到最window,的指定类的view
 */
- (UIView*)superviewWithClass:(Class)cls;

/**
 给view顶边界添加一个灰色细线,宽度自定
 */

-(void)addTopLine:(CGFloat)h;
/**
 给view底边界添加一个灰色细线,宽度自定
 */

-(void)addBottomLine:(CGFloat)h;
/**
 给view左边界添加一个灰色细线,宽度自定
 */

-(void)addLeftLine:(CGFloat)w;
/**
    给view右边界添加一个灰色细线,宽度自定
 */
-(void)addRightLine:(CGFloat)w;

/**
    移除全部子控件
 */
- (void)removeAllSubviews;

/**
    初始化view,并且设置frame和背景颜色
 */

-(instancetype)initWithFrame:(CGRect)frame color:(UIColor *)bgColor;
/**
    屏幕全屏截图
 */
- (UIImage *)screenshot;




@end

@interface UITextField (Util)

/**
 限定textField最大输入长度，超过这个长度后将限制不在输入
 */
@property (nonatomic, assign) NSInteger maxTextLength;

-(void)showToolBar;
@end
@interface UITextView (Util)
/**
 限定UITextView最大输入长度，超过这个长度后将限制不在输入
 */
@property (nonatomic, assign) NSInteger maxTextLength;

-(void)showToolBar;
@end
