//
//  HHBaseSession.m
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHBaseSession.h"
#import "HHPrivateHeader.h"
NSString *const kTokenExpiredNotification=@"kTokenExpiredNotification";

@interface HHBaseSession()

@property (nonatomic, strong) NSURLSessionDataTask *currentTask;//

@end

@implementation HHBaseSession

- (void)exceptionInfoHandleResponse:(id)response url:(NSString *)url error:(HHError *)error complete:(HHSessionCompleteBlock)complt{
    
    if (error) {
        FMWLog(@"error:%@",error);
        
        complt(nil,error);
        
    }else{
        FMWLog(@"\\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",url,response);
        
        if (![response[@"Success"] boolValue]) {
            NSString *msg=response[@"Message"];
            NSInteger code=[response[@"StatusCode"] integerValue];
            [self expiredInvalidTokenCode:code];
            error=[HHError errorWithCode:[response[@"StatusCode"] integerValue] description:msg];
            complt(nil,error);
        }else{
            complt(response,nil);
        }
    }
}

- (NSURLSessionDataTask *)GET:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt{
    NSURLSessionDataTask *task=[self GET:url params:dict HTTPHeader:nil complete:^(id response, HHError *error) {
        [self exceptionInfoHandleResponse:response url:url error:error complete:complt];
    }];
    [self repeatRequstHandleTask:task];
    return task;
}

- (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt{
    NSURLSessionDataTask *task=[self POST:url params:dict HTTPHeader:nil complete:^(id response, HHError *error) {
        [self exceptionInfoHandleResponse:response url:url error:error complete:complt];
    }];
    [self repeatRequstHandleTask:task];

    return task;
}

- (NSURLSessionDataTask *)JSON:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt{
    NSURLSessionDataTask *task=[self JSON:url params:dict HTTPHeader:nil complete:^(id response, HHError *error) {
        [self exceptionInfoHandleResponse:response url:url error:error complete:complt];
    }];
    [self repeatRequstHandleTask:task];

    return task;

}
- (NSURLSessionDataTask *)FILE:(NSString *)url params:(NSDictionary *)dict files:(NSArray<HHFile *> *)files complete:(HHSessionCompleteBlock)complt{
    NSURLSessionDataTask *task=[self FILE:url params:dict files:files HTTPHeader:nil complete:^(id response, HHError *error) {
        [self exceptionInfoHandleResponse:response url:url error:error complete:complt];
    }];
    [self repeatRequstHandleTask:task];

    return task;

}
- (NSURLSessionDownloadTask *)download:(NSString *)url complete:(HHSessionCompleteBlock)complt progress:(void (^)(float, long long))progress{
    NSURLSessionDownloadTask *task=[self download:url HTTPHeader:nil complete:complt progress:progress];
    return task;

}

- (NSURLSessionDataTask *)DATA:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt{
    
    NSData *endata=[[HHSecurity sharedInstance] dataByEncryptParams:dict];
    
    __block NSURLSessionDataTask *task=[self DATA:url data:endata HTTPHeader:@{@"Content-Type":@"text/plain; charset=utf-8"} complete:^(id response, HHError *error) {
        if (error) {
            FMWLog(@"task:%@error:%@",task,error);

            complt(nil,error);

        }else{

            if (![response[@"Success"] boolValue]) {
                NSString *msg=response[@"Message"];
                error=[HHError errorWithCode:[response[@"StatusCode"] integerValue] description:msg];
                complt(nil,error);
                [self expiredInvalidTokenCode:[response[@"StatusCode"] integerValue]];
                
            }else{
                response=[[HHSecurity sharedInstance] JSONDecryptResponseData:response];
                complt(response,nil);
            }
            FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,url,response);

        }
    }];
    return task;
}

- (BOOL)expiredInvalidTokenCode:(NSInteger)code{
    if (code==HHErrorCodeSessionExpired||code==HHErrorCodeAuthFail||code==HHErrorCodeSignError || code == HHErrorCodeTokenFailure) {
        [[NSNotificationCenter defaultCenter]postNotificationName:kTokenExpiredNotification object:nil];
        return NO;
    }
    return YES;
}
- (void)repeatRequstHandleTask:(NSURLSessionDataTask *)task{
//    if ([task.currentRequest.URL.absoluteString isEqualToString:_currentTask.currentRequest.URL.absoluteString]) {
//        [_currentTask cancel];
//    }
//    _currentTask=task;

}
@end
