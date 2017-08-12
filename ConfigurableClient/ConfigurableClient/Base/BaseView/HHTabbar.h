//
//  HHTabbar.h
//  CRMSystemClient
//
//  Created by tongda ju on 2017/5/10.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHTabbar;
@protocol HHTabBarDelegate <NSObject>

- (BOOL)hhTabBar:(HHTabbar *)tabBar didSelectItem:(UITabBarItem *)item;

@end
@interface HHTabbar : UIView
@property (nonatomic, strong) NSArray <UITabBarItem *> *items;
@property (nonatomic, strong) UITabBarItem *selectedItem;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, weak) id <HHTabBarDelegate>delegate;

@end
@interface HHTabbarButton : UIButton
@property (nonatomic, assign) BOOL onlyImage;

@end
