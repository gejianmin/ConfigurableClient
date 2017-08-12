//
//  HHCalculateSession.h
//  HHNetworking
//
//  Created by LWJ on 2016/11/8.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHFinanceProduct.h"
@class  HHBusinessPresentModel;

@protocol HHCalculateSession <NSObject>
@optional
/*!
 *  获取金融产品列表
 */
- (void)asyncFetchFinanceProductsWithPlatform:(HHCalculatePlatform)plat
                                     renttype:(HHCalculateRentType)rent
                                      carType:(HHCalculateCarType)carType
                                     complete:(HHSessionCompleteBlock)complete;
/*!
 *  获取金融方案详情
 */
- (void)asyncFetchFinanceProductDetail:(HHFinanceProduct *)fproduct complete:(HHSessionCompleteBlock)complete;
/*!
 *  测算
 */
- (void)asyncExceCalculate:(HHCalculateParam *)param complete:(HHSessionCompleteBlock)complete;
/*!
 *  提报
 */
- (void)asyncSaveProjectByCal:(HHCalculateParam *)param  customer:(HHBusinessPresentModel *)customer complete:(HHSessionCompleteBlock)complete;

@end
