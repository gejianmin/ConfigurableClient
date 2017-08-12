//
//  HHFileSession.h
//  HHNetworking
//
//  Created by LWJ on 2016/12/5.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <HHNetworking/HHNetworking.h>
/**
 收入证明
 征信报告
 其他
 身份证
 行驶证
 常住人口登记卡
 房屋证明
 工作证明
 银行流水
 户口本
 户籍首页
 二手车评估报告
 申请表
 登记证书
 银行卡
 结婚证明
 驾驶证
 婚姻证明
 营业执照
 个人征信
 */

@class HHCustomerImage;
@protocol HHFileSession <NSObject>
@optional
- (NSURL *)downloadSmallPathWithImage:(HHCustomerImage *)image;
- (NSURL *)downloadLargePathWithImage:(HHCustomerImage *)image;

- (void)asyncUploadImage:(UIImage *)image nameWordKey:(NSString *)wordKey projectId:(NSString *)projectId  complete:(HHSessionCompleteBlock)complete;
@end


