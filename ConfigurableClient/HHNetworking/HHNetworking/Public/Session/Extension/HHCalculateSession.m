//
//  HHCalculateSession.m
//  HHNetworking
//
//  Created by LWJ on 2016/11/8.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHInterface.h"
#import "HHCalculateSession.h"
#import "HHProject.h"
@implementation HHCalculateSession
- (void)asyncFetchFinanceProductsWithPlatform:(HHCalculatePlatform)plat
                                     renttype:(HHCalculateRentType)rent
                                      carType:(HHCalculateCarType)carType
                                     complete:(HHSessionCompleteBlock)complete{
    [HHSecurity sharedInstance].businessLine=kSecRZZLBusinessLine;

    NSString *url=[self urlWithPath:kBangCalculationList];
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    NSString *platform,*renttype,*Car_Type;
    if (plat==HHCalculatePlatformRZZL) {
        platform=@"";
    }else{
        platform=@"QCD";
    }
    if (rent==HHCalculateRentTypeZZ) {
        renttype=@"ZZ";
    }else{
        renttype=@"HZ";
    }
    if (carType==HHCalculateCarTypeXC) {
        Car_Type=@"X";
    }else{
        Car_Type=@"E";
    }
    param[@"supplier_id"]=[HHClient sharedInstance].user.FinanceLeaseId;
    param[@"platform"]=platform;
    param[@"renttype"]=renttype;
    param[@"Car_Type"]=Car_Type;

    [self DATA:url params:@{@"PostModel":param} complete:^(id response, HHError *error) {
        if (response) {
            id data=response[@"Data"];
            NSArray *datas=[HHFinanceProduct mj_objectArrayWithKeyValuesArray:data];
            [datas enumerateObjectsUsingBlock:^(HHFinanceProduct  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.platform=platform;
                obj.rentType=renttype;
                obj.carType=Car_Type;

            }];
            complete([datas copy],error);
        }else{
            complete(nil,error);
        }
    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;
}
- (void)asyncFetchFinanceProductDetail:(HHFinanceProduct *)fproduct complete:(HHSessionCompleteBlock)complete{
    [HHSecurity sharedInstance].businessLine=kSecRZZLBusinessLine;

    NSString *url=[self urlWithPath:kBangCalculationDetail];

    [self DATA:url params:@{@"PostModel":@{@"scheme_code":fproduct.Scheme_Code,@"platform":fproduct.platform}} complete:^(id response, HHError *error) {
        if (response) {
            id data=response[@"Data"];
            HHFinanceProduct *product=[HHFinanceProduct mj_objectWithKeyValues:data];
            product.Scheme_Name=fproduct.Scheme_Name;
            product.Scheme_Code=fproduct.Scheme_Code;
            product.platform=fproduct.platform;
            product.rentType=fproduct.rentType;
            product.carType=fproduct.carType;

            complete(product,error);
        }else{
            complete(nil,error);
        }

    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;

}
- (void)asyncExceCalculate:(HHCalculateParam *)param complete:(HHSessionCompleteBlock)complete{
    [HHSecurity sharedInstance].businessLine=kSecRZZLBusinessLine;

    NSString *url=[self urlWithPath:kBangCalculate];
    
    NSDictionary *dict=param.mj_keyValues;
    
    [self DATA:url params:@{@"PostModel":dict} complete:^(id response, HHError *error) {
        if (response) {
            id data=response[@"Data"];
            HHCalculateResult *rs=[HHCalculateResult mj_objectWithKeyValues:data];
            complete(rs,error);
        }else{
            complete(nil,error);
        }
        
    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;

}
- (void)asyncSaveProjectByCal:(HHCalculateParam *)param  customer:(HHBusinessPresentModel *)customer complete:(HHSessionCompleteBlock)complete{
    [HHSecurity sharedInstance].businessLine=kSecRZZLBusinessLine;
    NSString *url=[self urlWithPath:kBangSaveProjectByCal];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"platform"]=param.platform;
    dict[@"Project"]=param.Scheme.mj_keyValues;
    NSMutableArray *temp=[NSMutableArray array];
    for (NSObject *obj in param.OrtherFee) {
        [temp addObject:obj.mj_keyValues];
    }
    dict[@"OrtherFee"]=temp;
    NSMutableDictionary *customerParam=[NSMutableDictionary dictionary];
    if (customer.personType==HHCustomerTypeZRR) {
        customerParam[@"CustomerType"]=@"1";
    }else{
        customerParam[@"CustomerType"]=@"2";
    }
    if (customer.carType==HHCalculateCarTypeXC) {
        customerParam[@"Car_Type"]=@"x";
    }else{
        customerParam[@"Car_Type"]=@"e";
    }
    if (customer.carStandardType==HHCarStandardCYC) {
        customerParam[@"Car_Standard"]=@"C";
    }else{
        customerParam[@"Car_Standard"]=@"S";
    }
    customerParam[@"CustomerName"]=customer.personName;
    customerParam[@"CustomerPhone"]=customer.phoneNumber;
    customerParam[@"Car_Brand"]=customer.carBrand.BrandName;
    customerParam[@"Car_Catena"]=customer.carSeries.SeriesName;
    customerParam[@"Car_Model"]=customer.vehicle.TrimName;
    customerParam[@"Car_Fee_ZD"]=customer.carPrice;

    dict[@"Customer"]=customerParam;

    [self DATA:url params:@{@"PostModel":dict} complete:^(id response, HHError *error) {
        if (response) {
            id data=response[@"Data"];
            if (![data[@"Flag"] boolValue]) {
                complete(nil,[HHError errorWithCode:HHErrorCode200 description:data[@"ResultMsg"]]);
                return ;
            }

            HHProject *project=[[HHProject alloc] init];
            project.ProjectID=data[@"Project_ID"];
            project.ProjectName=data[@"Project_Name"];
            project.ProjectCode=data[@"Project_Code"];
            project.CarType=(customer.carType==HHCalculateCarTypeXC)?@"X":@"E";
            complete(project,error);
        }else{
            complete(nil,error);
        }

    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;

}
@end
