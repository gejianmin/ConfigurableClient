//
//  YDContactRecordModel.h
//  CRMSystemClient
//
//  Created by 赵东 on 2017/6/5.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDContactRecordModel : NSObject

/** 数据库自增ID */
@property (nonatomic,strong) NSString * ZDID;

/** 来源ID  */
@property (nonatomic,strong) NSString * sourceID;

/** 来源类型  */
@property (nonatomic,strong) NSString * sourceType;

/** 头像 */
@property (nonatomic,strong) NSString * headurl;

/** 名字 */
@property (nonatomic,strong) NSString * name;

/** 手机号码 */
@property (nonatomic,strong) NSString * phonenumber;

/** 记录时间 */
@property (nonatomic,strong) NSString * time;

/** 已被选择 1.已被选择 2.未被选择 */
@property (nonatomic,strong) NSString * isSelected;

@end
