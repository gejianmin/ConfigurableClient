//
//  MainViewController.m
//  CRMSystemClient
//
//  Created by tongda ju on 2017/5/10.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "MyViewController.h"
#import "JDNavigationController.h"
@interface MainViewController ()<HHTabBarDelegate,UINavigationControllerDelegate>{
    
    UIViewController *_currentModalController;
    BOOL _isPresent;
}

@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBar.hidden=YES;
    _currentModalController=nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.tabBar.tintColor=HEXCOLOR(0x1a78e3, 1);
    [self setupControllers];
}
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    _hhTabBar.selectedItem=self.childViewControllers[selectedIndex].tabBarItem;
}
-(void)setSelectedViewController:(__kindof UIViewController *)selectedViewController{
    [super setSelectedViewController:selectedViewController];
    
    if (![self.childViewControllers containsObject:selectedViewController]) {
        return;
    }
    if (selectedViewController == self.childViewControllers[_hhTabBar.selectedIndex]) {
        return;
    }
    _hhTabBar.selectedItem=selectedViewController.tabBarItem;
    
    
}
#pragma mark -setup
- (void)setupControllers{
    
    HomeViewController *home=[[HomeViewController alloc] init];
    home.title=@"Headline";
    home.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"Headline" image:nil tag:0];
    home.tabBarItem.image=[UIImage imageNamed:@"tabbar_headline_n"];
    home.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_headline_s"];
    
    SecondViewController *service=[[SecondViewController alloc] init];
    service.title=@"Business";
    service.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"Business" image:nil tag:1];
    service.tabBarItem.image=[UIImage imageNamed:@"tabbar_business_n"];
    service.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_business_s"];
    
    ThirdViewController *vc3=[[ThirdViewController alloc] init];
    vc3.title=@"World";
    vc3.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"World" image:nil tag:2];
    vc3.tabBarItem.image=[UIImage imageNamed:@"tabbar_world_n"];
    vc3.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_world_s"];
    
    FourthViewController * vc4 = [[FourthViewController alloc] init];
    vc4.title=@"Feature";
    vc4.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"Feature" image:nil tag:3];
    vc4.tabBarItem.image=[UIImage imageNamed:@"tabbar_feature_n"];
    vc4.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_feature_s"];

    
    MyViewController *exchange=[[MyViewController alloc] init];
    exchange.title=@"Setting";
    exchange.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"Setting" image:nil tag:4];
    exchange.tabBarItem.image=[UIImage imageNamed:@"tabbar_sport_n"];
    exchange.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_sport_s"];
    
    [self addChildViewController:home];
    [self addChildViewController:service];
    [self addChildViewController:vc3];
    [self addChildViewController:vc4];
    [self addChildViewController:exchange];
    self.tabBar.hidden=YES;
    
    _hhTabBar=[[HHTabbar alloc] init];
    _hhTabBar.delegate=self;
    _hhTabBar.frame=CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50);
    _hhTabBar.tintColor=kColorMianRed;
    _hhTabBar.items=@[home.tabBarItem,service.tabBarItem,vc3.tabBarItem,vc4.tabBarItem,exchange.tabBarItem];
    _hhTabBar.selectedItem=home.tabBarItem;
    
    [self.view addSubview:_hhTabBar];
    
}
-(void)addChildViewController:(UIViewController *)childController{
    JDNavigationController *navigation1=[[JDNavigationController alloc] initWithRootViewController:childController];
    navigation1.delegate=self;
    [super addChildViewController:navigation1];
}

-(BOOL)hhTabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    JDNavigationController *vc=self.childViewControllers[item.tag];
    self.tabBar.hidden = YES;
    self.selectedViewController =vc;
    return  YES;
}
#pragma  mark - navigation delegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController==navigationController.viewControllers[0]) {
        self.tabBar.hidden=YES;
        
        viewController.hidesBottomBarWhenPushed=YES;
    }else if(viewController==navigationController.viewControllers[1]){
        
        UIViewController *root=navigationController.viewControllers[0];
        [_hhTabBar removeFromSuperview];
        
        [root.view addSubview:_hhTabBar];
        _hhTabBar.frame=CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50);
    }
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.tabBar.hidden=YES;
    viewController.hidesBottomBarWhenPushed=YES;
    
    if (viewController==navigationController.viewControllers[0]) {
        [_hhTabBar removeFromSuperview];
        [self.view addSubview:_hhTabBar];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

@implementation HHTabbarHandle

+(instancetype)defaultHandle{
    static HHTabbarHandle *handle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle=[[HHTabbarHandle alloc] init];
    });
    return handle;
}
- (void)skipRootController:(Class)aClass object:(id)object{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"skipControllerNotification" object:aClass userInfo:@{@"object":object}];
}
@end
