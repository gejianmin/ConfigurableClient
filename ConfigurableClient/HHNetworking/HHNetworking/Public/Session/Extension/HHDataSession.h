//
//  HHDataSession.h
//  HHNetworking
//
//  Created by LWJ on 2016/12/17.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef NS_ENUM(NSUInteger, HHDataTypeKinds) {
//    HHDataApplyDayType,
//    HHDataApplyWeekType,
//    HHDataApplyMonthType,
//    HHDataApplyQuterType,
//    HHDataApplyYearType,
//    HHDataLoanDayType,
//    HHDataLoanWeekType,
//    HHDataLoanMonthType,
//    HHDataLoanQuterType,
//    HHDataLoanYearType,
//    HHDataRefuseOrOverbueType
//};
@protocol HHDataSession <NSObject>
//@property (assign, assign) HHDataTypeKinds dataTypeKinds;
@optional

/*!
 *  数据展示
 */
- (void)asyncFetchProjectInfoBySupplierIDWithType:(NSInteger )DataType complete:(HHSessionCompleteBlock)complete;

@end
