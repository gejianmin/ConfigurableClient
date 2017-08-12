//
//  HHCar.h
//  HHNetworking
//
//  Created by LWJ on 16/9/12.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHCarSeries;
@class HHCarVehicle;

@interface HHCar : NSObject
/*Id (integer, optional),
 CarName (string, optional),
 BrandName (string, optional): 品牌名称 ,
 SeriesName (string, optional): 系列名称 ,
 TrimName (string, optional): 车辆名称 ,
 CityName (string, optional): 城市名称 ,
 Thumbnail (string, optional): 缩略图 ,
 Mileage (number, optional): 行驶里程 ,
 LicenseDate (string, optional): 上牌日期 ,
 SchemeType (integer, optional): 方案类型 ,
 PriceDate (string, optional): 日供 ,
 FirstPay (string, optional): 首付 ,
 EvaluatingPrice (string, optional): 估价 ,
 SchemeId (integer, optional): 获取金融方案 ,
 FinancialId (integer, optional): 金融方案付款方式 ,
 BrandId (integer, optional): 品牌id ,
 Rate (integer, optional): 评级 ,
 Type (integer, optional): 推荐方案类型*/
@property (nonatomic, assign) NSInteger Id;//车辆id
@property (nonatomic, assign) NSInteger SchemeType;//方案类型
@property (nonatomic, assign) NSInteger Type;//推荐方案类型
@property (nonatomic, assign) NSInteger Rate;//评级
@property (nonatomic, assign) NSInteger BrandId;//品牌id
@property (nonatomic, assign) NSInteger FinancialId;//金融方案付款方式
@property (nonatomic, assign) NSInteger SchemeId;//获取金融方案

@property (nonatomic, strong) NSString *CarName;//车名
@property (nonatomic, strong) NSString *BrandName;//品牌名称
@property (nonatomic, strong) NSString *SeriesName;//系列名称
@property (nonatomic, strong) NSString *TrimName;//车辆名称
@property (nonatomic, strong) NSString *CityName;//城市名称
@property (nonatomic, strong) NSString *Thumbnail;//缩略图
@property (nonatomic, strong) NSString *Mileage;//行驶里程
@property (nonatomic, strong) NSString *LicenseDate;//上牌日期
@property (nonatomic, strong) NSString *PriceDate;//日供
@property (nonatomic, strong) NSString *FirstPay;//首付
@property (nonatomic, strong) NSString *EvaluatingPrice;//估价

@end

/*
 BrandId = 154;
 BrandName = "\U4e2d\U987a";
 Initial = Z;
 */
@interface HHCarBrand : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger BrandId;
@property (nonatomic, strong) NSString *BrandName;
@property (nonatomic, strong) NSString *Initial;
@property (nonatomic, strong) NSArray <NSDictionary<NSString *,NSArray <HHCarSeries *> *> *>*series;
@end
/*
 BrandId = 2;
 MakerType = "\U8fdb\U53e3";
 ManufacturerId = 0;
 ManufacturerName = "\U963f\U65af\U987f\U00b7\U9a6c\U4e01";
 SeriesId = 32;
 SeriesName = "\U963f\U65af\U987f\U9a6c\U4e01Rapide";
 UpdateTime = "0001-01-01T00:00:00";
 */
@interface HHCarSeries : NSObject <NSCoding>
@property (nonatomic, assign) NSInteger BrandId;
@property (nonatomic, assign) NSInteger SeriesId;
@property (nonatomic, assign) NSInteger ManufacturerId;

@property (nonatomic, strong) NSString *SeriesName;
@property (nonatomic, strong) NSString *UpdateTime;
@property (nonatomic, strong) NSString *ManufacturerName;
@property (nonatomic, strong) NSString *MakerType;
@property (nonatomic, strong) NSArray <NSDictionary<NSString *,NSArray <HHCarVehicle *> *> *>*vehicles;

@end
/*
 BrandId = 1;
 BrandName = "\U5965\U8fea";
 CarName = "\U5965\U8fea A6L 2016\U6b3e 30 FSI \U6280\U672f\U578b";
 CategoryId = 4;
 CategoryName = "\U4e2d\U578b\U8f66";
 DischargeStandard = "\U56fd5";
 "Gear_type" = "\U81ea\U52a8";
 Liter = "2.5L";
 MSRP = "43.6";
 SeriesId = 3;
 SeriesName = "\U5965\U8feaA6L";
 ShortTrimName = "2016\U6b3e 30 FSI \U6280\U672f\U578b";
 TrimId = 29844;
 TrimName = "2016\U6b3e \U5965\U8feaA6L 30 FSI \U6280\U672f\U578b";
 Year = 2016;
 */
@interface HHCarVehicle : NSObject <NSCoding>
@property (nonatomic, assign) NSInteger BrandId;
@property (nonatomic, assign) NSInteger CategoryId;
@property (nonatomic, assign) NSInteger SeriesId;
@property (nonatomic, assign) NSInteger TrimId;
@property (nonatomic, strong) NSNumber *Year;

@property (nonatomic, strong) NSString *BrandName;
@property (nonatomic, strong) NSString *CarName;
@property (nonatomic, strong) NSString *CategoryName;
@property (nonatomic, strong) NSString *DischargeStandard;
@property (nonatomic, strong) NSString *Gear_type;
@property (nonatomic, strong) NSString *Liter;
@property (nonatomic, strong) NSString *MSRP;
@property (nonatomic, strong) NSString *SeriesName;
@property (nonatomic, strong) NSString *ShortTrimName;
@property (nonatomic, strong) NSString *TrimName;

@end
