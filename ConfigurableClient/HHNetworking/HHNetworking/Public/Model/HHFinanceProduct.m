//
//  HHFinanceProduct.m
//  HHFinancialService
//
//  Created by LWJ on 2016/11/8.
//  Copyright © 2016年 Lxrent. All rights reserved.
//

#import "HHFinanceProduct.h"
#import "HHInterface.h"
@implementation HHFinanceProduct
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"Fee":[HHProductItem class],@"Scheme":[HHProductItem class],@"Rate":[HHProductItem class],@"Other_Fee":[HHProductItem class],@"GPSArea":[HHGPSItemArea class]};
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
@implementation HHProductItem
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"AreaList":[HHProductItemsArea class]};
}
+ (instancetype)itemWithKey:(NSString *)key value:(NSString *)value{
    HHProductItem *item=[[HHProductItem alloc] init];
    item.KEY=key;
    item.VALUE=value;
    return item;
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
@implementation HHProductItemsArea
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
@implementation HHGPSItemArea


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
