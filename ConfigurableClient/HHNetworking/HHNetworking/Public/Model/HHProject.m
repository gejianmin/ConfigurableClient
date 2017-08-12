//
//  HHProject.m
//  HHNetworking
//
//  Created by LWJ on 2016/11/30.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHProject.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
@implementation HHProject

@end
@implementation HHCustomer

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"lstMetaData":[HHCustomerMetaData class],@"LstImg":[HHCustomerImage class],@"LstGuarantor":[HHCustomerDetail class]};
}


@end
#pragma mark - ***************客户基本信息*****************
@implementation HHCustomerBaseInfo 
@end



@implementation HHCustomerIDCard
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"CardList":[HHCustomerImage class]};
}

@end
@implementation HHCustomerCredit
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"ReportList":[HHCustomerImage class],@"CreditDetailList":[HHCustomerImage class]};
}

@end
@implementation HHCustomerDriver
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"DriverList":[HHCustomerImage class]};
}

@end
@implementation HHCustomerLicense
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"DrivingLicenseList":[HHCustomerImage class]};
}

@end
@implementation HHCustomerEducation

@end
@implementation HHCustomerHousehold
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"UrlList":[HHCustomerImage class],@"HouseholdList":[HHCustomerImage class]};
}


@end
@implementation HHCustomerBankFlow
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"StatementsList":[HHCustomerImage class],@"BankStatementList":[HHCustomerImage class]};
}


@end
@implementation HHCustomerApplyForm
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"ApplicationFormList":[HHCustomerImage class]};
}


@end
@implementation HHCustomerAssess
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"CarAssessReportList":[HHCustomerImage class]};
}


@end
@implementation HHCustomerContact
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"ContactList":[HHCustomerContact class]};
}
@end
@implementation HHCustomerPayAcct
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"CardList":[HHCustomerImage class],@"OtherAccount":[HHCustomerPayAcct class]};
}


@end
@implementation HHCustomerRegCer
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"RegistrationList":[HHCustomerImage class]};
}


@end
@implementation HHCustomerLive
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"ProofList":[HHCustomerImage class]};
}


@end
@implementation HHCustomerOther
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"MaterialList":[HHCustomerImage class]};
}


@end
@implementation HHCustomerWeddig
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"WeddingList":[HHCustomerImage class]};
}


@end

#pragma mark - ***************客户配偶信息*****************
@implementation HHCustomerSpouseInfo

@end
#pragma mark - ***************客户担保人信息*****************
@implementation HHCustomerGuarantorInfo

@end

@implementation HHCustomerImage
-(id)copyWithZone:(NSZone *)zone{
    HHCustomerImage *item=[[HHCustomerImage alloc] init];
    u_int count=0;
    objc_property_t *properties=class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        const char* pname=property_getName(properties[i]);
        NSString *key=[NSString stringWithUTF8String:pname];
        id value=[self valueForKey:key];
        if (value) {
            [item setValue:value forKey:key];
        }
    }
    return item;
}

@end
@implementation HHCustomerMetaDatas
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"List":[HHCustomerMetaData class]};
}


-(void)setList:(NSArray<HHCustomerMetaData *> *)List{
    _List=List;
    [self updateSelectedMetaData];
}
-(void)setSelected:(NSString *)Selected{
    _Selected=Selected;
    [self updateSelectedMetaData];
}
- (void)updateSelectedMetaData{
    for (HHCustomerMetaData *obj in self.List) {
        if ([obj.Value isEqualToString:self.Selected]) {
            obj.isSelected=YES;
            self.selectMetaData=obj;
        }
    }

}
@end
@implementation HHCustomerMetaData

-(id)copyWithZone:(NSZone *)zone{
    HHCustomerMetaData *item=[[HHCustomerMetaData alloc] init];
    u_int count=0;
    objc_property_t *properties=class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        const char* pname=property_getName(properties[i]);
        NSString *key=[NSString stringWithUTF8String:pname];
        id value=[self valueForKey:key];
        if (value) {
            [item setValue:value forKey:key];
        }
    }
    return item;
}
@end
@implementation HHDataTbData
@end
@implementation HHDataHbData
@end
@implementation HHTotalData
@end
@implementation HHRefuseData
@end
@implementation HHTimeOut
@end






@implementation HHDataStatisticsData

@end

@implementation HHCustomerDetail

@end
@implementation HHCustomerGuarantor



@end

