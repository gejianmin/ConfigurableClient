//
//  HHCar.m
//  HHNetworking
//
//  Created by LWJ on 16/9/12.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHCar.h"
#import <objc/runtime.h>
#import "HHInterface.h"
@implementation HHCar

@end
@implementation HHCarBrand
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
@implementation HHCarSeries
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
@implementation HHCarVehicle
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
