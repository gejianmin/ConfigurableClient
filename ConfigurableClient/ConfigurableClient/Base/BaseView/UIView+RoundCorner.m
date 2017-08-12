//
//  UIView+RoundCorner.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/7/29.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "UIView+RoundCorner.h"


@implementation UIView (RoundCorner)

-(void)makeRoundedCorner:(CGFloat)cornerRadius
{
    CALayer *roundedlayer = [self layer];
    [roundedlayer setMasksToBounds:YES];
    [roundedlayer setCornerRadius:cornerRadius];
}

@end
