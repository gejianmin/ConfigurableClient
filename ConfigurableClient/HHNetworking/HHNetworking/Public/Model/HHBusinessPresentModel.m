//
//  HHBusinessPresentModel.m
//  HHFinancialService
//
//  Created by 葛建民 on 16/11/8.
//  Copyright © 2016年 Lxrent. All rights reserved.
//

#import "HHBusinessPresentModel.h"
#import "HHInterface.h"
typedef void (^AllValueFullBlock)(BOOL full);

@interface HHBusinessPresentModel()
{
    AllValueFullBlock _block;
}
@end
@implementation HHBusinessPresentModel
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        kFastDecode
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    kFastEncode
}
- (BOOL)allValueFull{
    if (self.personName.length>0 && self.phoneNumber.length>0 && self.vehicle ) {
        return YES;
    }
    return NO;
}
-(void)setPersonName:(NSString *)personName{
    _personName=personName;
    if (_block) {
        _block([self allValueFull]);
    }
}
-(void)setPhoneNumber:(NSString *)phoneNumber{
    _phoneNumber=phoneNumber;
    if (_block) {
        _block([self allValueFull]);
    }

}
-(void)setVehicle:(HHCarVehicle *)vehicle{
    _vehicle=vehicle;
    if (_block) {
        _block([self allValueFull]);
    }
}
- (void)setAllValueFullBlock:(AllValueFullBlock)block{
    _block=[block copy];
}
@end
