//
//  HHBaseSession.m
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHURLSession.h"
#import "AFNetworking.h"
#import "HHError.h"
#import "HHFile.h"
#import "HHSecurity.h"

#if DEBUG

#   define FMWLog(id, ...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else

#   define FMWLog(id, ...)

#endif


HHList HHListMake(int pageIndex,int pageSize){

    return (HHList){pageIndex,pageSize};
}




#pragma mark -class
@interface HHURLSession(){
    NSSet *_acceptableContentTypes;
}
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;//基本普通的会话管理 key-value
@property (nonatomic, strong) AFHTTPSessionManager *afResponseSessionManager;//不解析JSON/XML数据,直接返回NSData原始数据
@property (nonatomic, strong) NSURLSessionDataTask *currentTask;//
@property (nonatomic, strong) AFHTTPSessionManager *jsonSessionManager;//json请求
@property (nonatomic, strong) AFHTTPSessionManager *afResponseJSONSessionManager;//json请求


@end
@implementation HHURLSession
+ (instancetype)sessionWithBaseURL:(NSString *)baseURL{
    return [[HHURLSession alloc] initWithBaseURL:baseURL];
}
- (instancetype)initWithBaseURL:(NSString *)baseURL{
    if (self=[super init]) {
        _baseURL=baseURL;
        _timeoutInterval=60.f;
        _acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html",@"application/xml",nil];//,@"text/JavaScript"

    }
    return self;
}
+(instancetype)new{
    NSAssert(0, @"请使用initWithBaseURL:初始化");
    return nil;
}
- (instancetype)init
{
    NSAssert(0, @"请使用initWithBaseURL:初始化");
    return nil;
}
-(NSString *)urlWithPath:(NSString *)path{
    if (_baseURL==nil || path==nil) {
        NSAssert(0,@"主机域名或路径不能为空");
        return nil;
    }
//    return [NSString stringWithFormat:@"%@%@/%@",_baseURL,[HHSecurity sharedInstance].businessLine,path];
     return [NSString stringWithFormat:@"%@%@",_baseURL,path];
}

- (NSString *)urlWithBase:(NSString *)base path:(NSString *)path{
    NSAssert(base.length,@"主机域名不能为空");
    NSAssert(path.length,@"路径不能为空");
    return [NSString stringWithFormat:@"%@%@",base,path];

}
-(void)setTimeoutInterval:(NSTimeInterval)timeoutInterval{
    _timeoutInterval=timeoutInterval;
    self.sessionManager.requestSerializer.timeoutInterval=timeoutInterval;
}


- (AFHTTPSessionManager *)baseSessionManager{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
    configuration.HTTPShouldSetCookies = YES;
    AFHTTPSessionManager *manager= [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.securityPolicy=securityPolicy;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];/*!< 不加会报500*/
    manager.responseSerializer.acceptableContentTypes = _acceptableContentTypes;
    [manager.requestSerializer setTimeoutInterval:self.timeoutInterval];
    return manager;
}
#pragma mark - *************AFHTTPSessionManager*******
#pragma mark  key-value request
-(AFHTTPSessionManager *)sessionManager{
    if (_sessionManager==nil) {
        _sessionManager=[self baseSessionManager];
        //MARK:获取原始加密数据(不加密，不需要)
//        [_sessionManager setResponseSerializer:[AFJSONResponseSerializer new]];
        
    }
    return _sessionManager;
}

#pragma mark  JSONRequest
-(AFHTTPSessionManager *)jsonSessionManager{
    if (_jsonSessionManager==nil) {
        _jsonSessionManager=[self baseSessionManager];
        //MARK:获取原始加密数据
        [_jsonSessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        _jsonSessionManager.requestSerializer=[AFJSONRequestSerializer serializer];
    }
    return _jsonSessionManager;
}
#pragma mark key-value request Res-NSData
-(AFHTTPSessionManager *)afResponseSessionManager{
    if (_afResponseSessionManager==nil) {
        _afResponseSessionManager=[self baseSessionManager];
        [_afResponseSessionManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    }
    return _afResponseSessionManager;
}
#pragma mark JSONRequest Res-JSON

-(AFHTTPSessionManager *)afResponseJSONSessionManager{
    if (_afResponseJSONSessionManager==nil) {
        _afResponseJSONSessionManager=[self baseSessionManager];
        _afResponseJSONSessionManager.requestSerializer=[AFJSONRequestSerializer serializer];
        _afResponseJSONSessionManager.responseSerializer=[AFHTTPResponseSerializer serializer];
    }
    return _afResponseJSONSessionManager;
}
#pragma mark - ********************请求方法***********************
- (NSURLSessionDataTask *)GET:(NSString *)url params:(NSDictionary *)dict HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt{
    
    if (header.count>0) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    NSURLSessionDataTask *task=[self.sessionManager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
      FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,task.currentRequest.URL,responseObject);
        complt(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FMWLog(@"task:%@error:%@",task,error);
        
        [self handleError:error response:task.response complete:complt];
        
    }];
    return task;
}


- (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)dict HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt{
    if (header.count>0) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    dic[@"version"]=@"V1.0";
//    if (dict != nil) {
//        dic[@"data"] = dict;
//    }else{
//        dic[@"data"] = @{ };
//    }

    NSURLSessionDataTask *task=[self.sessionManager POST:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,task.currentRequest.URL,responseObject);
        
        complt(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FMWLog(@"task:%@error:%@",task,error);
        
        [self handleError:error response:task.response complete:complt];
        
    }];

    return task;

}
- (NSURLSessionDataTask *)JSON:(NSString *)url params:(NSDictionary *)dict HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt{
    if (header.count>0) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.jsonSessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }

    NSURLSessionDataTask *task=[self.jsonSessionManager POST:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,task.currentRequest.URL,responseObject);
        
        complt(responseObject,nil);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FMWLog(@"task:%@error:%@",task,error);
        
        [self handleError:error response:task.response complete:complt];
        
    }];

    return task;

}
- (NSURLSessionDataTask *)FILE:(NSString *)url params:(NSDictionary *)dict files:(NSArray<HHFile *> *)files HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt{
    if (header.count>0) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }

    NSURLSessionDataTask *task=[self.sessionManager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0;i<files.count; i++) {
            HHFile *obj=files[i];
            if (obj.data) {
                [formData appendPartWithFileData:obj.data name:obj.key fileName:obj.name mimeType:obj.mimeType];
            }
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,task.currentRequest.URL,responseObject);
        
        complt(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FMWLog(@"task:%@error:%@",task,error);
        
        [self handleError:error response:task.response complete:complt];

    }];

    return task;

}
- (NSURLSessionDataTask *)FILE:(NSString *)url params:(NSDictionary *)dict  files:(NSArray <HHFile *> *)files HTTPHeader:(NSDictionary <NSString *, NSString *>*)header appendData:(NSData *)appendData complete:(HHSessionCompleteBlock)complt{
    if (header.count>0) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    NSURLSessionDataTask *task=[self.sessionManager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0;i<files.count; i++) {
            HHFile *obj=files[i];
            if (obj.data) {
                [formData appendPartWithFileData:obj.data name:obj.key fileName:obj.name mimeType:obj.mimeType];
            }
        }
        if (appendData) {
            [formData appendPartWithHeaders:@{@"Content-Type":@"application/json; charset=utf-8"} body:appendData];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,task.currentRequest.URL,responseObject);
        
        complt(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FMWLog(@"task:%@error:%@",task,error);
        
        [self handleError:error response:task.response complete:complt];
        
    }];
    
    return task;
    

}
- (NSURLSessionDownloadTask *)download:(NSString *)url HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt progress:(void (^)(float, long long))progress{
    if (header.count>0) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }

    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task=[self.sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return nil;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    return task;

}

- (NSURLSessionDataTask *)request:(NSString *)url method:(HHHTTPMETHOD)method params:(id)param  responseType:(HHHTTPResponseType)resType HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt{
    
    if (method==HHHTTPMETHOD_QUERY_GET) {
        if (header.count>0) {
            [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [self.afResponseSessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }];
        }

        [self.afResponseSessionManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            responseObject=[self responseObject:responseObject resType:resType complete:complt];
            
            FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,task.currentRequest.URL,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            FMWLog(@"task:%@error:%@",task,error);
            
            [self handleError:error response:task.response complete:complt];
            
        }];
    }else if (method==HHHTTPMETHOD_QUERY_POST){
        if (header.count>0) {
            [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [self.afResponseSessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }];
        }

        [self.afResponseSessionManager POST:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            responseObject=[self responseObject:responseObject resType:resType complete:complt];
            
            FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,task.currentRequest.URL,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            FMWLog(@"task:%@error:%@",task,error);
            
            [self handleError:error response:task.response complete:complt];
            
        }];
    }else if (method==HHHTTPMETHOD_JSON_POST){
        if (header.count>0) {
            [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [self.afResponseJSONSessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }];
        }

        [self.afResponseJSONSessionManager POST:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            responseObject=[self responseObject:responseObject resType:resType complete:complt];

            FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,task.currentRequest.URL,responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            FMWLog(@"task:%@error:%@",task,error);
            
            [self handleError:error response:task.response complete:complt];
            
        }];
    }else if (method==HHHTTPMETHOD_FORMDATA_POST){
        if (header.count>0) {
            [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [self.afResponseSessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }];
        }

        [self.afResponseSessionManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithHeaders:nil body:param];

        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            responseObject=[self responseObject:responseObject resType:resType complete:complt];
            FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,task.currentRequest.URL,responseObject);


        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            FMWLog(@"task:%@error:%@",task,error);
            
            [self handleError:error response:task.response complete:complt];
        }];
    }else if (method==HHHTTPMETHOD_STRING_POST){
        if (header.count>0) {
            [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [self.afResponseSessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }];
        }
        NSData *data=[param dataUsingEncoding:NSUTF8StringEncoding];
        if (data.length==0) {
            complt(nil,[HHError errorParams]);
            return nil;
        }
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        request.HTTPMethod=@"POST";
        request.HTTPBody=data;
        request.timeoutInterval=self.timeoutInterval;

    }
    return nil;
}

- (NSURLSessionDataTask *)DATA:(NSString *)url data:(NSData *)data HTTPHeader:(NSDictionary <NSString *, NSString *>*)header complete:(HHSessionCompleteBlock)complt{
    if (data.length==0) {
        complt(nil,[HHError errorParams]);
        return nil;
    }
    if (header.count>0) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod=@"POST";
    request.HTTPBody=data;
    request.timeoutInterval=self.timeoutInterval;

    NSURLSessionDataTask *task=[self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            FMWLog(@"task:%@error:%@",task,error);
            
            [self handleError:error response:response complete:complt];
        }else{
            FMWLog(@"\ntaskIdentifier:%ld\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",task.taskIdentifier,url,responseObject);
            complt(responseObject,nil);
        }
    }];
    [task resume];

    return task;
}

- (id)responseObject:(id)responseObject resType:(HHHTTPResponseType)type complete:(HHSessionCompleteBlock)complt{
    NSError *error;
    id resObject;
    if (type==HHHTTPResponseTypeJSON) {
        resObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
    }else if (type==HHHTTPResponseTypeString){
        resObject = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    }else if (type==HHHTTPResponseTypeData){
        resObject = responseObject;
    }else{
        resObject = responseObject;
    }
    if (error) {
        FMWLog(@"data-JSON序列化失败");
        complt(nil,[HHError errorWithCode:error.code description:@"data-JSON序列化失败"]);
    }else{
        
        complt(resObject,nil);
    }
    return responseObject;
}
- (void)handleError:(NSError *)error response:(NSURLResponse *)aResponse complete:(HHSessionCompleteBlock)complt{
    HHError *derror=[HHError errorWithCode:error.code description:nil];
    derror.error=error;
    NSHTTPURLResponse *response=(NSHTTPURLResponse *)aResponse;
    derror.statusCode=response.statusCode;
    complt(nil,derror);
}

-(void)cancleAllRequest{
    [self.sessionManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
    
    [self.jsonSessionManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
    
    [self.afResponseSessionManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
    [self.afResponseJSONSessionManager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
}
@end
