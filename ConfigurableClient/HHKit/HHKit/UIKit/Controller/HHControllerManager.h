//
//  HHLoginManager.h
//  HHKit
//
//  Created by LWJ on 16/8/2.
//  Copyright © 2016年 HHAuto. All rights reserved.
//
// 该类负责弹出一个控制器置于屏幕最前，该类不依赖于任何控制器和对象,弹出控制器不受任何试图影响，基于window实现
//  如果需要弹出只需传入一个需要被弹出的控制器参数
//  
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,HHViewControllerTransitionStyle) {
    HHViewControllerTransitionStyleRight,
    HHViewControllerTransitionStyleBottom,
    HHViewControllerTransitionStyleTop,
    HHViewControllerTransitionStyleLeft,
    HHViewControllerTransitionStyleCenter
};
@interface HHControllerManager : NSObject

+ (instancetype)sharedInstance;

- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;

- (void)presentViewController:(UIViewController *)controller animated:(BOOL)flag completion:(void (^)(void))completion;

- (void)popViewControllerAnimated:(BOOL)animated;

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
@end

