//
//  HHError.m
//  LoginAPI
//
//  Created by LWJ on 16/7/18.
//  Copyright © 2016年 gejianmin. All rights reserved.
//

#import "HHError.h"
#import "AFURLResponseSerialization.h"

@implementation HHError
+(instancetype)errorWithCode:(HHErrorCode)code description:(NSString *)description{
    HHError *error=[[HHError alloc] initWithDomain:@"HHError" code:code userInfo:nil];
    error.errorDescription=description;
    return error;
}
+(instancetype)errorParams{
    HHError *error=[[HHError alloc] initWithDomain:@"HHError" code:HHErrorCodeOther userInfo:nil];
    error.errorDescription=@"参数错误";
    return error;

}
-(NSString *)errorDescription{
    if (_errorDescription.length>0) {
        return _errorDescription;
    }
    if (self.code == HHErrorCodeNotConnectedToInternet) {
        return @"请检查网络";
    }else if (self.code == HHErrorCodeTimeout){
        return @"请求超时,请稍后再试";
    }else if (self.code == HHErrorCodeNetworkConnectionLost){
        return @"连接服务器失败";
    }else if (self.code == HHErrorCodeCannotConnectToHost){
        return @"服务器无响应";
    }else if (self.code == HHErrorCodeSessionExpired){
        return @"登录身份已过期，请重新登录";
    }else if (self.code == HHErrorCodeResultNone){
        return @"数据有误";
    }else if (self.code == HHErrorCodeCancelled){
        return @"请求已取消";
    }
    else{
        if (self.statusCode==HHErrorStatusCode405) {
            return [NSString stringWithFormat:@"服务器异常(状态码:%ld)",(long)self.statusCode];

        }else if (self.statusCode==HHErrorStatusCode404){
            return [NSString stringWithFormat:@"服务器异常(状态码:%ld)",(long)self.statusCode];

        }else if (self.statusCode==HHErrorStatusCode500){
            return [NSString stringWithFormat:@"服务器异常(状态码:%ld)",(long)self.statusCode];

        }else
        return [NSString stringWithFormat:@"服务器异常(错误码:%ld)",(long)self.code];
    }

}
- (NSString *)description{
    NSData *errorData=self.error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    NSString *errorDataInfo=[[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"\ncom.hhaotu.error:%@\ncom.response.error:%@\nerrorDescription:%@",self.error,errorDataInfo,self.errorDescription];
}
@end
