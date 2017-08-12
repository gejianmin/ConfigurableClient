//
//  HHUserInfo.m
//  HHNetworking
//
//  Created by qiangge on 2016/11/4.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHUserInfo.h"
#import <objc/runtime.h>
#import "HHInterface.h"

@implementation HHUserInfo
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        kFastDecode
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    kFastEncode
}


@end
@implementation HHIDCard



@end
@implementation HHIDCardLegality
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"IDPhoto":@"ID Photo",@"TemporaryIDPhoto":@"Temporary ID Photo"};
}

@end
@implementation HHIDCardBirthday


@end

