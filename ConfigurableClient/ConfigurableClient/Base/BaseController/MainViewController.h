//
//  MainViewController.h
//  CRMSystemClient
//
//  Created by tongda ju on 2017/5/10.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHTabbar.h"

@interface MainViewController : UITabBarController

@property (nonatomic, strong) HHTabbar *hhTabBar;

//@property (nonatomic, assign) HHTabbarSeletedSource seletedSource;

@end


@interface HHTabbarHandle : NSObject




+ (instancetype)defaultHandle;



- (void)skipRootController:(Class)aClass object:(id)object;


@end
