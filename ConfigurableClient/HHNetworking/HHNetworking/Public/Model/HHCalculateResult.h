//
//  HHCalculateResult.h
//  HHFinancialService
//
//  Created by LWJ on 2016/11/4.
//  Copyright © 2016年 Lxrent. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHCalculateResultOther;
@class HHCalculateResultRent;
@class HHCalculateScheme;
@class HHCalculateOrtherFee;
@class HHFinanceProduct;
@class HHBusinessPresentModel;










@interface HHCalculateResult : NSObject <NSCoding>
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) HHFinanceProduct *productModel;



@property (nonatomic, strong) NSString *resultId;

@property (nonatomic, strong) NSString *businessType;
@property (nonatomic, strong) NSString *carPrice;
@property (nonatomic, strong) NSString *product;


@property (nonatomic, strong) NSArray <HHCalculateResultOther *>*OrtherFees;//其他费用
@property (nonatomic, strong) NSString *EveryMonth;//每期租金
@property (nonatomic, strong) NSString *TotleFirst;//首付款合计
@property (nonatomic, strong) NSString *TotleMonth;//租金合计
@property (nonatomic, strong) NSString *TotleOther;//其他费用合计
@property (nonatomic, strong) NSArray <HHCalculateResultRent *>*CountDetails;//租金明细

@property (nonatomic, assign) BOOL open;
@end
@interface HHCalculateResultOther : NSObject <NSCoding>
@property (nonatomic, strong) NSString *FeeName;//费用名称
@property (nonatomic, strong) NSString *FeeMoney;//费用额度
@property (nonatomic, strong) NSString *FYGS;//计入方式

@end

@interface HHCalculateResultRent : NSObject <NSCoding>
@property (nonatomic, strong) NSString *PERIOD;//期数
@property (nonatomic, strong) NSString *OWN_PRICE;//本金
@property (nonatomic, strong) NSString *REN_PRICE;//利息
@property (nonatomic, strong) NSString *OTHER_PRICE;//其他费用
@property (nonatomic, strong) NSString *LAST_PRICE;//剩余
@property (nonatomic, strong) NSString *TOTAL_PRICE;//合计


@property (nonatomic, strong) NSString *MONTH_PRICE;//月供租金
@property (nonatomic, strong) NSString *MGMT;//管理费

@end







#pragma mark - ***************
@interface HHCalculateParam : NSObject
@property (nonatomic, strong) NSString *platform;//平台
@property (nonatomic, strong) HHCalculateScheme *Scheme;//金融方案测算 主要实体
@property (nonatomic, copy) NSArray <HHCalculateOrtherFee *> *OrtherFee;//// 其他费用列表，请假GPS 也放在该列表中传递
+ (instancetype)calculateParam;
@end
@interface HHCalculateScheme : NSObject
@property (nonatomic, strong) NSString *renttype;//租赁方式直租 ZZ回租 HZ
@property (nonatomic, strong) NSString *Car_Type;//汽车类型 X 为新车 E 为二手车
@property (nonatomic, strong) NSString *supplier_id;//经销商id
@property (nonatomic, strong) NSString *Supplier_Employee_Id;//账号关系映射ID
@property (nonatomic, strong) NSString *Car_Fee;//车辆价格
@property (nonatomic, strong) NSString *scheme_code;//贴息额度 若无 可传O
@property (nonatomic, strong) NSString *START_PERCENT;//首付比例
@property (nonatomic, strong) NSString *SXFBL_PERCENT;//手续费比例
@property (nonatomic, strong) NSString *BZJBL_PERCENT;//保证金比例
@property (nonatomic, strong) NSString *WKBL_PERCENT;//尾款比例
@property (nonatomic, strong) NSString *BAIL_PERCENT;//利率比例
@property (nonatomic, strong) NSString *ZLQS;//租赁期数
@property (nonatomic, strong) NSString *ZLZQ;////租赁周期
@property (nonatomic, strong) NSString *ZFFS;//支付方式
@property (nonatomic, strong) NSString *SXF_TYPE;//手续费方式
@property (nonatomic, strong) NSString *CSFS;//测算方式
@property (nonatomic, strong) NSString *BZJCLFS;//保证金处理方式
@property (nonatomic, strong) NSString *TX;//贴息额度 若无 可传O
@property (nonatomic, strong) NSString *FKFS;//放款方式【放款规则】  XFKHDY 先放款后抵押  XDYHFK 先抵押后放款
@property (nonatomic, strong) NSString *QMCLFS;//期满处理方式 留购 1退还 2续租 3

@end

@interface HHCalculateOrtherFee : NSObject
@property (nonatomic, strong) NSString *FeeName;//其他费用名称
@property (nonatomic, strong) NSString *FeeMoney;//金额
@property (nonatomic, strong) NSString *DK;//抵扣
@property (nonatomic, strong) NSString *FYGS;//费用归属
@end

