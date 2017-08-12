//
//  UIResponder+Router.m
//  HHAutoBusiness
//
//  Created by LWJ on 16/8/16.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
