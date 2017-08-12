//
//  HHProjectSession.h
//  HHNetworking
//
//  Created by LWJ on 2016/11/30.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHCustomerCellItem,HHProject;
@protocol HHProjectSession <NSObject>
@optional
/*!
 *  申请管理-项目列表
 */
- (void)asyncFetchProjectList:(HHList)list complete:(HHSessionCompleteBlock)complete;

/*!
 *  申请管理-删除项目
 */
- (void)asyncDeleteProject:(HHProject *)project complete:(HHSessionCompleteBlock)complete;

/*!
 *  项目详情
 */
- (void)asyncFetchProjectInfoById:(NSString *)pid complete:(HHSessionCompleteBlock)complete;

/*!
 *  保存
 */
- (void)asyncSaveCustomerInfo:(HHCustomerCellItem *)item projectId:(NSString *)projectId complete:(HHSessionCompleteBlock)complete;

/*!
 *  提交
 */
- (void)asyncSubmitProject:(HHProject *)project complete:(HHSessionCompleteBlock)complete;
/*!
 *  OCR
 */
- (void)asyncOCRWithIDCardImage:(UIImage *)image complete:(HHSessionCompleteBlock)complete;
@end
