//
//  HHVehicleSession.h
//  HHNetworking
//
//  Created by 葛建民 on 16/11/8.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

typedef NS_ENUM(NSInteger,HHCarRecommandType){
    HHCarRecommandTypeDefault,//个人中心车辆推荐
    HHCarRecommandTypeLXR,//置换乐享融
    HHCarRecommandTypeSXR//置换省心融
    
};

@protocol HHVehicleSession <NSObject>

@optional
/*! @method 获取车辆推荐列表
 *  @param type:推荐类型
 *  @response HHCar对象数组
 */
- (void)asyncFetchRecommandCarSourceWithType:(HHCarRecommandType)type complete:(HHSessionCompleteBlock)complete;

/*! @method 获取车辆品牌
 *  @reponse HHCarBrand 对象数组
 */
- (void)asyncFetchCarBrandsComplete:(HHSessionCompleteBlock)complete;
/*! @method 获取车系
 *  @param  bid:品牌id
 *  @reponse HHCarSeries 对象数组
 */
- (void)asyncFetchCarSeriesByBid:(NSInteger)bid complete:(HHSessionCompleteBlock)complete;

/*! @method 获取车型
 *  @param  sid:车系id
 *  @reponse HHCarVehicle 对象数组
 */
- (void)asyncFetchCarVehicleBySid:(NSInteger)sid complete:(HHSessionCompleteBlock)complete;



- (void)clearMemoryCache;
- (void)clearDiskCache;
- (void)clearAllCache;


@end
