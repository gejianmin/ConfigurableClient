//
//  HHFinanceProduct.h
//  HHFinancialService
//
//  Created by LWJ on 2016/11/8.
//  Copyright © 2016年 Lxrent. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *HHB_JTHBBL=@"JTHBBL";//阶梯还本比例
static NSString *HHB_QMCLFS=@"QMCLFS";//期满处理方式
static NSString *HHB_SUPPLIER_NAME=@"SUPPLIER_NAME";//经销商
static NSString *HHB_CX=@"CX";//车系
static NSString *HHB_COMPANY_NAME=@"COMPANY_NAME";//品牌
static NSString *HHB_JTHBJE=@"JTHBJE";//阶梯还本金额
static NSString *HHB_GPSAZ=@"GPSAZ";//GPS安装
static NSString *HHB_ZFFS=@"ZFFS";//支付方式
static NSString *HHB_BZJCLFS=@"BZJCLFS";//保证金处理方式
static NSString *HHB_JSQX_DATE=@"JSQX_DATE";//结束期限
static NSString *HHB_RZE=@"RZE";//融资额
static NSString *HHB_PLATFORM=@"PLATFORM";//业务类型
static NSString *HHB_BIG_CUST=@"BIG_CUST";//项目类型
static NSString *HHB_PRODUCT_TYPE=@"PRODUCT_TYPE";//车型
static NSString *HHB_WKBL_PERCENT=@"WKBL_PERCENT";//尾款比例
static NSString *HHB_CSFS=@"CSFS";//测算方式
static NSString *HHB_WEI_KUAN=@"WEI_KUAN";//尾款
static NSString *HHB_CLLX=@"CLLX";//车辆类型
static NSString *HHB_CLBZ=@"CLBZ";//车辆标准
static NSString *HHB_YWLY=@"YWLY";//业务来源
static NSString *HHB_SXF_MONEY=@"SXF_MONEY";//手续费
static NSString *HHB_SXF_TYPE=@"SXF_TYPE";//手续费方式
static NSString *HHB_DQ=@"DQ";//大区
static NSString *HHB_ZLZQ=@"ZLZQ";//租赁周期
static NSString *HHB_FKGZ=@"FKGZ";//放款规则
static NSString *HHB_AREA=@"AREA";//区域
static NSString *HHB_START_PERCENT=@"START_PERCENT";//首期租金比例
static NSString *HHB_BAIL_MONEY=@"BAIL_MONEY";//保证金
static NSString *HHB_SXFBL_PERCENT=@"SXFBL_PERCENT";//手续费比例
static NSString *HHB_SJCJJ=@"SJCJJ";//实际成交价
static NSString *HHB_ZLQS=@"ZLQS";//租赁期数
static NSString *HHB_START_MONEY=@"START_MONEY";//首期租金
static NSString *HHB_BZJBL_PERCENT=@"BZJBL_PERCENT";//保证金比例


static NSString *HHB_OTHER=@"HHB_OTHER";//其他选项
static NSString *HHB_GPS=@"HHB_GPS";//GPS选项



/////////////////////////////
static NSString *HHB_DK_KDK=@"KDK";//可抵扣
static NSString *HHB_DK_BDK=@"BDK";//不抵扣

static NSString *HHB_FYGS_JRSQK=@"JRSQK";//计入首期款
static NSString *HHB_FYGS_JRRZE=@"JRRZE";//计入融资款
static NSString *HHB_FYGS_JRKHXJ=@"JRKHXJ";//计入客户小计

static NSString *HHB_STATUE_READWRITE=@"0";//可读写
static NSString *HHB_STATUE_READONLY=@"1";//只读


typedef NS_ENUM(NSInteger,HHCalculatePlatform){
    HHCalculatePlatformRZZL,//融资租赁
    HHCalculatePlatformQCD//车贷
};
typedef NS_ENUM(NSInteger,HHCalculateRentType){
    HHCalculateRentTypeZZ,//直租
    HHCalculateRentTypeHZ//回租
};
typedef NS_ENUM(NSInteger,HHCalculateCarType){
    HHCalculateCarTypeXC,//新车
    HHCalculateCarTypeESC//二手车
};
typedef NS_ENUM(NSInteger,HHCustomerType){
    HHCustomerTypeZRR,//自然人
    HHCustomerTypeQYKH//企业客户
};
typedef NS_ENUM(NSInteger,HHCarStandard){
    HHCarStandardCYC,//乘用车
    HHCarStandardSYC//商用车
};


@class HHProductItem;
@class HHProductItemsArea;
@class HHGPSItemArea;
@interface HHFinanceProduct : NSObject <NSCoding>
//列表页
@property (nonatomic, strong) NSString *Scheme_Code;
@property (nonatomic, strong) NSString *Scheme_Name;

@property (nonatomic, strong) NSString *platform;//字符串
@property (nonatomic, strong) NSString *rentType;
@property (nonatomic, strong) NSString *carType;
@property (nonatomic, assign) HHCalculatePlatform aPlatform;//枚举
@property (nonatomic, assign) HHCalculateRentType aRentType;
@property (nonatomic, assign) HHCalculateCarType aCarType;

@property (nonatomic, strong) NSString *car_price;





//详情

@property (nonatomic, strong) NSArray <HHProductItem *> *Fee;//其他费用中的GPS 套餐费
@property (nonatomic, strong) NSArray <HHProductItem *> *Scheme;// 金融项目参数列表
@property (nonatomic, strong) NSArray <HHProductItem *> *Rate;//金融方案费率  一般为一个  如果分期 不同，会出现多费率
@property (nonatomic, strong) NSArray <HHProductItem *> *Other_Fee;//金融方案中的其他收费 跟项目中描述一样，但产品说不需要了，你们可以不解析
@property (nonatomic, strong) NSArray <HHGPSItemArea *> *GPSArea;//金融方案中的其他收费 跟项目中描述一样，但产品说不需要了，你们可以不解析

@end

@interface HHProductItem : NSObject <NSCoding>

@property (nonatomic, strong) NSString *KEY;//参数键
@property (nonatomic, strong) NSString *KEY_NAME;//参数名称
@property (nonatomic, strong) NSString *VALUE;//参数默认值
@property (nonatomic, strong) NSString *FYGS;////费用归属 JRSQK 计入首期款   JRRZE计入融资额     JRKHXJ 进入客户小计
@property (nonatomic, strong) NSString *DK;// 是否可抵扣  KDK 可以抵扣  BDK 不能抵扣
@property (nonatomic, strong) NSString *CALCULATE;//计算基数 RZE 融资额  SBK 设备款
@property (nonatomic, strong) NSString *VALUE_STATUS;//状态  0读写 1只读 ；只读时多选功能不执行
@property (nonatomic, strong) NSString *LD;//限制区间段   最小
@property (nonatomic, strong) NSString *LU;//限制区间段   最大
@property (nonatomic, strong) NSString *GPS;//GPS费用

@property (nonatomic, strong) NSString *YEAR_RATE;//年利率
@property (nonatomic, strong) NSString *LEASE_TERM_E;//时间区间结束
@property (nonatomic, strong) NSString *LEASE_TERM_S;//时间区间开始


@property (nonatomic, strong) NSArray <HHProductItemsArea *> *AreaList;//// 如果是列表 ，列表的属性
+ (instancetype)itemWithKey:(NSString *)key value:(NSString *)value;
@end
@interface HHProductItemsArea : NSObject <NSCoding>
@property (nonatomic, strong) NSString *Key;//// 参数建
@property (nonatomic, strong) NSString *Value;//// 可选项目
@end
@interface HHGPSItemArea : NSObject <NSCoding>
@property (nonatomic, strong) NSString *Bili;
@property (nonatomic, strong) NSString *CarLD;
@property (nonatomic, strong) NSString *CarLU;

@end
