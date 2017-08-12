//
//  HHAuthSession.m
//  HHNetworking
//
//  Created by liuwenjie on 16/7/28.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHInterface.h"
NSString *const kLoginFinishNotification=@"kLoginFinishNotification";

@implementation HHAuthSession
{
    NSString *_account;
    NSString *_password;
}
@synthesize account=_account;
@synthesize password=_password;

-(void)setAccount:(NSString *)account{
    
    _account=account;
    [[NSUserDefaults standardUserDefaults]setObject:account forKey:@"QWER_ASDF_ZXCV_PL"];

}
-(NSString *)account{
    if (_account==nil) {
        return     [[NSUserDefaults standardUserDefaults]objectForKey:@"QWER_ASDF_ZXCV_PL"];
    }

    return _account;
}

-(void)setPassword:(NSString *)password{
    _password=password;
    [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"QWER_ASDF_ZXCV"];
}

-(NSString *)password{
    if (_password==nil) {
        return  [[NSUserDefaults standardUserDefaults]objectForKey:@"QWER_ASDF_ZXCV"];
    }
    return _password;
}

#pragma mark - session
-(NSURLSessionDataTask *)asyncLoginWithPhone:(NSString *)phone password:(NSString *)pwd complete:(HHSessionCompleteBlock)complete{
    
    NSString *url=[self urlWithPath:kBangLoginPath];
    
    if (phone==nil || pwd==nil) {
        FMWLog(@"账号或密码为空");
        complete(nil,[HHError errorParams]);
        return nil;
    }
    NSURLSessionDataTask *task=[self DATA:url params:@{@"loginName":phone,@"psw":pwd} complete:^(id response, HHError *error) {
        
        if (response) {
            
            NSString *token=response[@"Data"][@"TokenId"];
            [HHClient sharedInstance].token=token;
                        
            self.account=phone;
            self.password=pwd;
            
            if (complete) {
                complete(response,nil);
            }
        }else{
            if (complete) {
                complete(nil,error);
            }
            
        }
    }];
    return task;
}

- (NSURLSessionDataTask *)asyncLogOutcomplete:(HHSessionCompleteBlock)complete{
    
    
    NSString *url=[self urlWithPath:kBangLogOutPath];
    
    NSURLSessionDataTask *task=[self DATA:url params:nil complete:^(id response, HHError *error) {
        
        if (response) {
            [HHClient sharedInstance].token=nil;
            [HHClient sharedInstance].user=nil;
            self.password=nil;

            complete(response,nil);
        }else{
            complete(nil,error);
        }
    
    }];
    
    return task;
    
}

- (NSURLSessionDataTask *)asyncGetDetailInfocomplete:(HHSessionCompleteBlock)complete{

    NSString *url=[self urlWithPath:kBangDetalisInfoPath];
    
    NSURLSessionDataTask *task=[self DATA:url params:nil complete:^(id response, HHError *error) {
        
        if (response) {
            NSDictionary *dic = response[@"Data"];
            HHUserInfo *info = [HHUserInfo mj_objectWithKeyValues:dic];
            [HHClient sharedInstance].user=info;
            complete(info,nil);
            
        }else{
            complete(nil,error);
        }
        
    }];
    
    return task;

}


/*! @method 获取RSA密钥，后台需要提供.der文件形式的公钥或.p12格式的私钥，不能给.pem格式的.pem在iOS平台加密完后台不能解密
 *
 */
- (NSURLSessionDataTask *)asyncFetchRSAPublicKeyComplete:(HHSessionCompleteBlock)complete{
    NSString *url = [self urlWithBase:kDefaultBaseURLString path:kGetPublicKeyURL];
    NSURLSessionDataTask *task=[self DATA:url params:nil complete:^(id response, HHError *error) {
        if (response) {
            NSString *pubkey=response[@"Data"][@"PubValue"];
            if ([pubkey isEqualToString:@"<null>"]) {
                pubkey=nil;
            }
            [RSACryptor sharedRSACryptor].rsa_pub_key=pubkey;
            if (complete) {
                complete(pubkey,nil);
            }
        }else{
            if (complete) {
                complete(nil,error);
            }
        }
    }];
    return task;

}
- (NSURLSessionDataTask *)post:(NSString *)path params:(NSDictionary *)pramas  complete:(HHSessionCompleteBlock)complete{
    
    
    //[self urlWithPath:path]
    NSURLSessionDataTask *task=[self POST:path params:pramas HTTPHeader:@{@"Content-Type":@"application/json;charset=UTF-8"} complete:^(id response, HHError *error) {
        
        if (response) {
            
//            NSString * code  = response[@"code"];
//            switch ([code integerValue]) {
//                case 20000:
//                {
                    if (complete) {
                        complete(response,nil);
                    }
                    
//                }
//                    break;
//                case 40001:
//                {
//                    NSLog(@"40001 --- 版本号不存在");
//                }
//                    break;
//                case 50000:
//                {
//                    NSLog(@"50000 --- 处理请求时发生异常");
//                }
//                    break;
//                case 50002:
//                {
//                    NSLog(@"50002 --- 参数格式错误");
//                }
//                    break;
//                case 70000:
//                {
//                    NSLog(@"70000 --- 请求参数为空");
//                }
//                    break;
//                    
//                default:
//                {
//                    NSLog(@"unkonwn --- 未知错误");
//                }
//                    break;
//            }
            
        }else{
            if (complete) {
                complete(nil,error);
            }
            
            
        }
    }];
    return task;
    
    
}

@end
