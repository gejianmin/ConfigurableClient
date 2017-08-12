//
//  HHClient.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HHUserInfo;
@protocol HHSessionManager;

@interface HHClient : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSString *baseURL;//根域名
@property (nonatomic, copy) NSString *token;//token
@property (nonatomic, copy) NSString *UserId;//token


@property (nonatomic, strong) HHUserInfo *user;//当前登录用户

@property (nonatomic, strong, readonly) id<HHSessionManager> sessionManager;


@end
