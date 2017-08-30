//
//  AppDelegate.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/7/5.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "JDNavigationController.h"
#import "RootViewController.h"
#import "UMessage.h"
//#import "UserNotifications.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@property (nonatomic, assign) BOOL  is_show_tip;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //        self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    //        [self.window setRootViewController:[self pickViewController]];
    //        [self.window makeKeyAndVisible];
    [self fecthDataWithOptions:launchOptions];
    [self setupMainInfoSettiong];

    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupMainInfoSettiong{
    
    if(HH_SCREEN_H != 667){
        self.sizeScaleX = HH_SCREEN_W/375;
        self.sizeScaleY = HH_SCREEN_H/667;
    }else{
        self.sizeScaleX = 1.0;
        self.sizeScaleY = 1.0;
    }
    
    
}

- (UIViewController*)pickViewController{
    MainViewController *main=[[MainViewController alloc] init];
    JDNavigationController *navi = [[JDNavigationController alloc]initWithRootViewController:main];
    navi.navigationBar.hidden = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController=navi;
    return  navi;
}
-(void)fecthDataWithOptions:(NSDictionary *)launchOptions{
    
    [[[HHClient sharedInstance] sessionManager] GET:kAppPathId params:nil complete:^(id response, HHError *error) {
        if (error) {
        }else{
            if (response) {
                NSInteger code = [response[@"code"] integerValue];
                if (code == 200) {
                    [UMessage startWithAppkey:kUmengAppKey launchOptions:launchOptions];
                    [UMessage registerForRemoteNotifications];
                    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                    center.delegate=self;
                    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
                    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        if (granted) {
                            //点击允许
                            //这里可以添加一些自己的逻辑
                        } else {
                            //点击不允许
                            //这里可以添加一些自己的逻辑
                        }
                    }];
                    //打开日志，方便调试
//                    [UMessage setLogEnabled:YES];
                
                    self.is_show_tip = [response[@"result"][@"is_show_tip"] boolValue];
                    if (self.is_show_tip) {
                        RootViewController *VC = [[RootViewController alloc]init];
                        VC.pathUrl = response[@"result"][@"url"];
                        [self.window setRootViewController:VC];
                        return ;
                    }
                }else if (code == 400){
                    
                };
            }
        }
//        [UMessage startWithAppkey:kUmengAppKey launchOptions:launchOptions];
//        [UMessage registerForRemoteNotifications];
//        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        center.delegate=self;
//        UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
//        [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
//            if (granted) {
//                //点击允许
//                //这里可以添加一些自己的逻辑
//            } else {
//                //点击不允许
//                //这里可以添加一些自己的逻辑
//            }
//        }];
//        //打开日志，方便调试
//        [UMessage setLogEnabled:YES];
        

        // 否则直接进入应用
        self.window.rootViewController = [self pickViewController];
        
        
    }];
}
//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //    self.userInfo = userInfo;
    //    //定制自定的的弹出框
    //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    //    {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
    //                                                            message:@"Test On ApplicationStateActive"
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"确定"
    //                                                  otherButtonTitles:nil];
    //
    //        [alertView show];
    //
    //    }
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}
@end
