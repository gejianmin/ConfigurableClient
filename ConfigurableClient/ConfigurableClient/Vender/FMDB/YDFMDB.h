//
//  YDFMDB.h
//  XYFrameWork
//
//  Created by xxxx on 17/2/28.
//  Copyright © 2017年 yuandong. All rights reserved.
//  拨打电话记录 --> 常用联系人

#import <Foundation/Foundation.h>

#import "YDContactRecordModel.h"
#import "HeaderModel.h"

typedef NS_ENUM(NSUInteger, YDFMDBSourceType) {
    YDFMDBSourceTypeClue = 1 ,
    YDFMDBSourceTypeCustomer = 2 ,
    YDFMDBSourceTypeContacts = 3 ,
    YDFMDBSourceTypeCompany = 5 ,
    YDFMDBSourceTypeLocalTelphone = 6,
};

@interface YDFMDB : NSObject


/**
 初始化单例

 @return <#return value description#>
 */
+ (instancetype)manager;


/**
 录入数据
 
 @param headurl 头像
 @param name 昵称
 @param phonenumber 电话号码
 */
- (void)addDataWithHeadurl:(NSString *)headurl name:(NSString *)name phonenumber:(NSString *)phonenumber;




/**
 录入数据

 @param ID 就是各个模块的ID
 @param headurl 头像
 @param name 昵称
 @param phonenumber 电话号码
 @param sourceType 来源类型标注
 */
- (void)addDataWithID:(NSString *)ID headurl:(NSString *)headurl name:(NSString *)name phonenumber:(NSString *)phonenumber sourceType:(YDFMDBSourceType)sourceType;

- (BOOL)addDataWithModel:(HeaderModel*)model;

- (BOOL)isExistWithNewsID:(NSString *)newsID;

- (BOOL)removeDataWithModel:(HeaderModel*)model;

/**
 删除记录
 */
- (void)deleteAllRecords;

/**
 获取所有数据

 @return 模型数组
 */
- (NSMutableArray <YDContactRecordModel *> *)getAllRecords;

/**
 <#Description#>

 @param isContain 是否包含本地通话记录
 @return <#return value description#>
 */
- (NSMutableArray *)getAllRecordContainLocalPhone:(BOOL)isContain;

@end
