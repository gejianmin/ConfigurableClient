//
//  AppDelegate.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/7/5.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MainViewController.h"
#import "JDNavigationController.h"
@interface AppDelegate ()

{}
@property (nonatomic, assign) BOOL  is_show_tip;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.is_show_tip = YES;
    if (self.is_show_tip) {
    }else{
        [self.window setRootViewController:[self pickViewController]];
    
    }
    
    
    
    
    
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
- (UIViewController*)pickViewController{
    
    MainViewController *main=[[MainViewController alloc] init];
    JDNavigationController *navi = [[JDNavigationController alloc]initWithRootViewController:main];
    navi.navigationBar.hidden = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController=navi;
    return  navi;
    
}

@end
