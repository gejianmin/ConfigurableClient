//
//  HHCalculateResult.m
//  HHFinancialService
//
//  Created by LWJ on 2016/11/4.
//  Copyright © 2016年 Lxrent. All rights reserved.
//

#import "HHCalculateResult.h"
#import <objc/runtime.h>
#import "HHFinanceProduct.h"
#import "HHInterface.h"

@implementation HHCalculateResult
+ (NSDictionary *)mj_objectClassInArray{

    return @{@"OrtherFees":[HHCalculateResultOther class],@"CountDetails":[HHCalculateResultRent class]};
}

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
@implementation HHCalculateResultOther

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
@implementation HHCalculateResultRent

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

#pragma mark - ***********************************
@implementation HHCalculateParam
+ (instancetype)calculateParam{
    HHCalculateParam *param=[[HHCalculateParam alloc] init];
    
    HHCalculateScheme *scheme=[[HHCalculateScheme alloc] init];
    
    
    param.Scheme=scheme;
    
    return param;
}

@end

@implementation HHCalculateScheme


@end
@implementation HHCalculateOrtherFee

@end
