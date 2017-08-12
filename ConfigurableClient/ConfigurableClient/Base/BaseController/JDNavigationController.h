//
//  GFNavigationController.h
//  qudiaoyu
//
//  Created by abel on 14/10/14.
//  Copyright (c) 2014年 qudiaoyu.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDNavigationController : UINavigationController





@end
@interface UINavigationController (bar)
@property (nonatomic, assign) BOOL barHiden;
- (void)setHiddenNavigationBar:(BOOL)hiden;

@end
