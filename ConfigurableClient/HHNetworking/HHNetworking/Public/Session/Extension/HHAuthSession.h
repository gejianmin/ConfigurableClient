//
//  HHAuthSession.h
//  HHNetworking
//
//  Created by liuwenjie on 16/7/28.
//  Copyright © 2016年 HHAuto. All rights reserved.
//
//  登陆,注册,找回密码,修改密码
//  个人资料修改等等有关身份认证信息之类的请求管理


extern  NSString *const   kLoginFinishNotification;


@protocol HHAuthSession <NSObject>

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;

@optional

/*! @method 用户登录
 *  @phone  手机号
 *  @pwd    密码
 *  @reponse HHUser
 */
- (NSURLSessionDataTask *)asyncLoginWithPhone:(NSString *)phone
                                    password:(NSString *)pwd
                                    complete:(HHSessionCompleteBlock)complete;

- (NSURLSessionDataTask *)asyncLogOutcomplete:(HHSessionCompleteBlock)complete;

- (NSURLSessionDataTask *)asyncGetDetailInfocomplete:(HHSessionCompleteBlock)complete;



/*! @method 获取RSA密钥，后台需要提供.der文件形式的公钥或.p12格式的私钥，不能给.pem格式的.pem在iOS平台加密完后台不能解密
 *
 */
- (NSURLSessionDataTask *)asyncFetchRSAPublicKeyComplete:(HHSessionCompleteBlock)complete;

- (NSURLSessionDataTask *)post:(NSString *)path params:(NSDictionary *)pramas  complete:(HHSessionCompleteBlock)complete;

@end

