//
//  HHDatePickerController.h
//  LoginAPI
//
//  Created by LWJ on 2016/10/19.
//  Copyright © 2016年 gejianmin. All rights reserved.
//
// @dependency  "HHBlurView.h"
//              "UIView+Util.h"

#import <UIKit/UIKit.h>
/*!
 *  时间选择器的样式
 */
typedef NS_ENUM(NSInteger,HHDatePickerStyle) {
    HHDatePickerStyleNormal,//普通的键盘形式弹出
    HHDatePickerStyleActionSheet,//类似actionsheet样式弹出
    HHDatePickerStyleAlert//类似alert形式弹出，暂未实现
};
@class HHDatePickerController;
@class HHDate;

//MARK: delegate
@protocol HHDatePickerDelegate <NSObject>
// 完成选择
- (void)datePicker:(HHDatePickerController *)controller didSelectedDate:(HHDate *)date;

@end

@interface HHDatePickerController : UIViewController

@property (nonatomic, weak) id<HHDatePickerDelegate>delegate;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;//时间样式
@property (nonatomic, assign) HHDatePickerStyle datePickerStyle;//选择器样式
@property (nonatomic, assign) BOOL dateBucket;//是否是选择时间段，如果是，则会创建两个时间选择器来选择时间区段，

@property (nonatomic, copy) void (^didSelectDateBlock)(HHDate *date);//完成选择的block,delegate和block二选一，他们都是调用

- (void)showInViewController:(UIViewController *)viewController;//弹出选择起使用该方法，请传入一个控制器

@end

#pragma mark - ***********时间数据类*********
@interface HHDate : NSObject
@property (nonatomic, strong) NSDate *date;//单选时间时会赋予此值
@property (nonatomic, strong) NSDate *startDate;//选择时间区间时会给该属性赋值
@property (nonatomic, strong) NSDate *endDate;//选择时间区间时会给该属性赋值
@property (nonatomic, assign) BOOL dateBucket;//是否时间区间
@property (nonatomic, readonly, copy) NSString *(^dateFormat)(NSString *fmt,NSDate *aDate);//该属性是通过block来格式化一个时间，并且需要格式化时间格式，返回一个时间字符串

@end
