//
//  HHButton.h
//  HHButton
//
//  Created by liuwenjie on 15/11/25.
//  Copyright © 2015年 LWJ. All rights reserved.
//
//  自定义按钮
//
//  自定义按钮imageView 和titleLabel布局
//
//  四种布局:
//
//  水平:imageView在前,titleLabel在后
//      titleLabel在前,imageView在后
//
//  垂直:imageView在上,titleLabel在下
//      titleLabel在上,imageView在下
//
#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, HHButtonSubviewLayoutStyle) {
    /**
        水平布局,和原生UIButton一样,图片在前,标题在后
     */
    HHButtonSubviewLayoutStyleHorizontal    =   0,//default
    /**
        水平反向布局,标题在前,图片在后
     */
    HHButtonSubviewLayoutStyleHorizontalReverse,
    /**
        垂直布局,图片在上,标题在下
     */
    HHButtonSubviewLayoutStyleVertical,
    
    /**
        垂直反向布局,标题在上,图片中在下
     */
    HHButtonSubviewLayoutStyleVerticalReverse,
    
    /**
        自定义
     */
    HHButtonSubviewLayoutStyleCustom,
};

typedef NS_ENUM(NSInteger,HHButtonContentAlignment) {
    HHButtonContentAlignmentLeft,
    HHButtonContentAlignmentRight,
    HHButtonContentAlignmentCenter = 0
}NS_UNAVAILABLE;


@class HHButtonItem;

@interface HHButton : UIButton
{
    CGSize titleSize;
}
/**
    按钮内部imageView和titleLabel的布局样式
 */
@property (nonatomic,assign) HHButtonSubviewLayoutStyle subviewLayoutStyle;
/**
    imageView和titleLabel间距
 */
@property (nonatomic, assign) CGFloat imageTitleMargin;
/**
    imageView 和titleLabel 整体布局方向
 */
@property (nonatomic, assign) HHButtonContentAlignment contentAlignment NS_UNAVAILABLE;

/**
    如果自定义需要设置这两个值
 */
@property (nonatomic) CGRect titleRect;

@property (nonatomic) CGRect imageRect;


@property (nonatomic, strong) HHButtonItem *item;

/**
    便利初始化,可选择其他初始化方式
 */
- (instancetype)initWithStyle:(HHButtonSubviewLayoutStyle)style;


@end

@interface HHButtonItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) UIImage *highlightImage;

@property (nonatomic, strong) NSString *className;

- (instancetype)initWithTitle:(NSString *)title normalImage:(UIImage *)image;

- (instancetype)initWithTitle:(NSString *)title normalImage:(UIImage *)image className:(NSString *)aClass;
@end
