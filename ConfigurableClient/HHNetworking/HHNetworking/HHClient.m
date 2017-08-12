//
//  HHClient.m
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHClient.h"
#import "HHInterface.h"

static NSString *const HHUserCacheKey = @"HHUserCacheKey";

@implementation HHClient

@synthesize sessionManager=_sessionManager;
@synthesize token=_token;
@synthesize user=_user;
@synthesize UserId=_UserId;

+ (instancetype)sharedInstance{
    static HHClient *instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[HHClient alloc] init];
        
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginFinish:) name:kLoginFinishNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginFinish:) name:kTokenExpiredNotification object:nil];
        
        _baseURL=kDefaultBaseURLString;
        [[HHSecurity sharedInstance] setCommonParam:self.token forKey:@"Token"];
        [HHSecurity sharedInstance].businessLine=kSecBusinessLine;

    }
    return self;
}

- (void)setToken:(NSString *)token{
    _token=token;
    [[HHSecurity sharedInstance] setCommonParam:token forKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:HH_AUTH_TOKEN];
}

- (void)setUserId:(NSString *)UserId {

     [[NSUserDefaults standardUserDefaults] setObject:UserId forKey:@"UserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loginFinish:(NSNotification *)notification{
    
    HHUserInfo *user=notification.object;
    self.user=user;
}
- (NSString *)token{
    if (_token==nil) {
        _token=[[NSUserDefaults standardUserDefaults]objectForKey:HH_AUTH_TOKEN];
    }
    return _token;
}
- (NSString *)UserId {
    if (_UserId==nil) {
        _UserId=[[NSUserDefaults standardUserDefaults]objectForKey:@"UserId"];
    }
    return _UserId;

}
-(void)setUser:(HHUserInfo *)user{
    _user=user;
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:HHUserCacheKey];

}
- (HHUserInfo *)user{
    if (_user==nil) {
        NSData *data=[[NSUserDefaults standardUserDefaults]objectForKey:HHUserCacheKey];
        _user=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return _user;
}

- (id<HHSessionManager>)sessionManager{
    if (_sessionManager==nil) {
        _sessionManager=[[HHSessionManager alloc] init];
    }
    return _sessionManager;
}
@end
