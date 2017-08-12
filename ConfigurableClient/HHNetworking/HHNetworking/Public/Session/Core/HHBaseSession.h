//
//  HHBaseSession.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.

//  基础会话请求

#import <Foundation/Foundation.h>
#import <HHSecurityNetwork/HHSecurityNetwork.h>
@class HHFile;
@class HHError;
@protocol HHSessionManager;

extern  NSString *const  kTokenExpiredNotification;

@interface HHBaseSession : HHURLSession <HHSessionManager>
/*!
 *  @method GET
 *  @params 
            url:请求全路径
            params:参数字典 
            complete:回调
 
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)GET:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt;
/*!
 *  @method POST
 *  @params
            url:请求全路径
            params:参数字典
            complete:回调
 
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt;

/*!
 *  @method JSON
 *  @params
            url:请求全路径
            params:参数字典
            complete:回调
 
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)JSON:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt;
/*!
 *  @method JSON
 *  @params
 *      url:请求全路径
 *      params:参数字典
 *      complete:回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)FILE:(NSString *)url params:(NSDictionary *)dict files:(NSArray <HHFile *> *)files  complete:(HHSessionCompleteBlock)complt;

/*!
 *  @method 文件下载
 *  @params
        url:请求全路径
        complete:回调
        progress:进度
 *  @return NSURLSessionDataTask
 */

- (NSURLSessionDownloadTask *)download:(NSString *)url complete:(HHSessionCompleteBlock)complt progress:(void(^)(float progress,long long totalBytes))progress;

/*!
 *  @method POST data
 *  @params
        url:请求全路径
        params:参数字典
        complete:回调
 
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)DATA:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt;

@end
