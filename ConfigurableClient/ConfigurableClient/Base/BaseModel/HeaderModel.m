//
//  HeaderModel.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/15.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "HeaderModel.h"

#import "NSDate+ZD.h"

@implementation HeaderModel

- (NSString *)date {
    NSString * result = [NSDate stringWithOrginFormat:@"yyyymmdd" resultFormat:@"yyyy-mm-dd" content:_date];
    return result;
}

@end
