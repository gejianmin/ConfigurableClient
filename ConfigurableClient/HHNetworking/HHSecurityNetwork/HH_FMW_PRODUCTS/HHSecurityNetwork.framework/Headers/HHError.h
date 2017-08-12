//
//  HHError.h
//  LoginAPI
//
//  Created by LWJ on 16/7/18.
//  Copyright © 2016年 gejianmin. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 请求错误code
 */
typedef NS_ENUM(NSInteger, HHErrorCode) {
    
    HHErrorCodeNotConnectedToInternet   = NSURLErrorNotConnectedToInternet,/*网络连接失败*/
    HHErrorCodeTimeout                  = NSURLErrorTimedOut,/*请求超时*/
    HHErrorCodeNetworkConnectionLost    = NSURLErrorNetworkConnectionLost,/*网络连接丢失*/
    HHErrorCodeCannotConnectToHost      = NSURLErrorCannotConnectToHost,/*不能连接到服务器*/
    HHErrorCodeCancelled                = NSURLErrorCancelled,/*取消请求*/

    HHErrorCode200    =200,/*请求正确*/

    HHErrorCodeSessionExpired = 991,/*token失效 会话过期*/
    HHErrorCodeAuthFail = 990,/*认证失败*/
    HHErrorCodeSignError = 428,/*签名失败*/
    HHErrorCodeTokenFailure = 401,
    HHErrorCodeResultNone = 499,/*result=0*/
    HHErrorCodeOther          = 500,/*其他参数错误/数据异常/操作不当等等 服务器提供的错误*/
    HHErrorStatusCode405    =405,/*HTTP请求方法不对*/
    HHErrorStatusCode404    =404,/*not found*/
    HHErrorStatusCode500    =500/*错误的请求*/
    
};

@interface HHError : NSError
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSString *errorDescription;
@property (nonatomic, assign) NSInteger statusCode;//NSError:NSHTTPURLResponse->statusCode


+(instancetype)errorWithCode:(HHErrorCode)code description:(NSString *)description;
+ (instancetype)errorParams;//便利初始化一个参数错误的error
@end
