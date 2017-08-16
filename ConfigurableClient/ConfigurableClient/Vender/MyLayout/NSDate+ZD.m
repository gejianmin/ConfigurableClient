//
//  NSDate+ZD.m
//  ConfigurableClient
//
//  Created by 赵东 on 2017/8/16.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "NSDate+ZD.h"

@implementation NSDate (ZD)

+ (NSString *)stringWithOrginFormat:(NSString *)orginStr resultFormat:(NSString *)resultFormat content:(NSString *)content {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:orginStr];
    NSDate* inputDate = [inputFormatter dateFromString:content];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:resultFormat];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
    
}
@end
