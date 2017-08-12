//
//  HHBaseSession.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.

//  基础会话请求

#import <Foundation/Foundation.h>
@class HHFile;
@class HHError;

/**
 完成请求回调block
 */
typedef void (^HHSessionCompleteBlock)(id response,HHError *error);
/*! @分页列表属性结构体
 *  @可通过函数创建
 */
struct HHList {
    int pageIndex;
    int pageSize;
};
typedef struct HHList HHList;
HHList HHListMake(int pageIndex,int pageSize);

/*! 
 *  @http请求方法
 */
typedef NS_ENUM(NSInteger,HHHTTPMETHOD){
    HHHTTPMETHOD_QUERY_GET,//普通GET,参数通过 ? & 拼接在URL后面
    HHHTTPMETHOD_QUERY_POST,//普通POST，参数通过 & 拼接转换为流 在body里面面
    HHHTTPMETHOD_JSON_POST,//POST,参数通过JSON字符拼接在Body里面
    HHHTTPMETHOD_FORMDATA_POST,//POST,参数通过表单拼接方式在body里面
    HHHTTPMETHOD_STRING_POST//POST,参数通过string普通字符串拼接在body里面

};
/*！
 *  @http响应类型
 */
typedef NS_ENUM(NSInteger,HHHTTPResponseType){
    HHHTTPResponseTypeJSON,//回调参数是JSON
    HHHTTPResponseTypeString,//回调参数是string字符串
    HHHTTPResponseTypeData,//回调参数是NSData二进制流
};
#pragma mark - class
@interface HHURLSession : NSObject

@property (nonatomic, assign) NSTimeInterval  timeoutInterval;//超时时间

@property (nonatomic, copy) NSString *baseURL;//域名，根路径

/*! @method 初始化方法，且只能通过此方法类初始化
 *  @baseURL 域名，根路径
 */
+ (instancetype)sessionWithBaseURL:(NSString *)baseURL;

/*! @method 初始化方法，且只能通过此方法类初始化
 *  @baseURL 域名，根路径
 */
- (instancetype)initWithBaseURL:(NSString *)baseURL;


- (NSString *)urlWithPath:(NSString *)path;//通过此方法来转换最终URL


- (NSString *)urlWithBase:(NSString *)base path:(NSString *)path;

/*!
 *  @method GET
 *  @params 
            url:请求全路径
            params:参数字典 
            complete:回调
 
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)GET:(NSString *)url params:(NSDictionary *)dict HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt;
/*!
 *  @method POST
 *  @params
            url:请求全路径
            params:参数字典
            complete:回调
 
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)dict HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt;

/*!
 *  @method JSON
 *  @params
            url:请求全路径
            params:参数字典
            complete:回调
 
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)JSON:(NSString *)url params:(NSDictionary *)dict HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt;
/*!
 *  @method FILE 
 *  @params
 *      url:请求全路径
 *      params:参数字典
 *      complete:回调
 *
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)FILE:(NSString *)url params:(NSDictionary *)dict  files:(NSArray <HHFile *> *)files HTTPHeader:(NSDictionary <NSString *, NSString *>*)header  complete:(HHSessionCompleteBlock)complt;
- (NSURLSessionDataTask *)FILE:(NSString *)url params:(NSDictionary *)dict  files:(NSArray <HHFile *> *)files HTTPHeader:(NSDictionary <NSString *, NSString *>*)header appendData:(NSData *)appendData complete:(HHSessionCompleteBlock)complt;

/*!
 *  @method 文件下载
 *  @params
        url:请求全路径
        complete:回调
        progress:进度
 *  @return NSURLSessionDataTask
 */
- (NSURLSessionDownloadTask *)download:(NSString *)url HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt progress:(void(^)(float progress,long long totalBytes))progress;

/*! @method 自定义请求
 *  @params:
 *      url:    请求全路径
 *      method: 请求方法
 *      param:  参数
 *      resType:接受数据类型
 *      header: 扩展http请求头
 *      complt: 回调
 */
- (NSURLSessionDataTask *)request:(NSString *)url method:(HHHTTPMETHOD)method params:(id)param responseType:(HHHTTPResponseType)resType HTTPHeader:(NSDictionary *)header complete:(HHSessionCompleteBlock)complt;

/*! @method POST body拼接请求
 *      url:    请求全路径
 *      data:   二进制流
 *      header: 扩展http请求头
 *      complt: 回调
 */
- (NSURLSessionDataTask *)DATA:(NSString *)url data:(NSData *)data HTTPHeader:(NSDictionary <NSString *, NSString *> *)header complete:(HHSessionCompleteBlock)complt;

/*!
 取消所有请求
 */
-(void)cancleAllRequest;

@end
