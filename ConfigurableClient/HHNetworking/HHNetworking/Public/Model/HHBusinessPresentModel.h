//
//  HHBusinessPresentModel.h
//  HHFinancialService
//
//  Created by 葛建民 on 16/11/8.
//  Copyright © 2016年 Lxrent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHFinanceProduct.h"
#import "HHCar.h"
@interface HHBusinessPresentModel : NSObject <NSCoding>

@property(nonatomic,assign)HHCustomerType personType;/*>客户属性*/
@property(nonatomic,assign)HHCalculateCarType carType;/*车辆类型*/
@property(nonatomic,assign)HHCarStandard carStandardType;/*车辆标准*/
@property(nonatomic,strong)NSString * personName;/*客户姓名*/
@property(nonatomic,strong)NSString * phoneNumber;/*手机号码*/
@property(nonatomic,strong)NSString * carPrice;/*车辆评估价*/
@property(nonatomic,strong)HHCarBrand *carBrand;//品牌
@property(nonatomic,strong)HHCarSeries *carSeries;//车系
@property(nonatomic,strong)HHCarVehicle *vehicle;//车型

- (void)setAllValueFullBlock:(void (^)(BOOL full))block;
@end
