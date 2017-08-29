//
//  GuidePagesViewController.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/19.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "GuidePagesViewController.h"
#import "MainViewController.h"
#import "RootViewController.h"
#import "JDNavigationController.h"
#define WIDTH (NSInteger)self.view.bounds.size.width
#define HEIGHT (NSInteger)self.view.bounds.size.height

@interface GuidePagesViewController ()<UIScrollViewDelegate>
{
    // 创建页码控制器
    UIPageControl *pageControl;
    // 判断是否是第一次进入应用
    BOOL flag;
}
@end

@implementation GuidePagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    for (int i=0; i<2; i++) {
        NSString * imaString;
        if (self.is_show_tip) {
            imaString = [NSString stringWithFormat:@"Guide_%d",i+1];
        }else {
            imaString = [NSString stringWithFormat:@"Guide_e%d",i+1];
        }
        UIImage *image = ImageNamed(imaString);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT)];
        // 在最后一页创建按钮
        if (i == 1) {
            // 必须设置用户交互 否则按键无法操作
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(0,0, WIDTH, HEIGHT);
//            [button setTitle:@"点击进入" forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
//            button.layer.borderWidth = 2;
//            button.layer.cornerRadius = 5;
//            button.clipsToBounds = YES;
//            button.layer.borderColor = [UIColor whiteColor].CGColor;
            [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(WIDTH * 2, HEIGHT);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH / 2, HEIGHT * 15 / 16, WIDTH / 2, HEIGHT / 16)];
    // 设置页数
    pageControl.numberOfPages = 2;
    // 设置页码的点的颜色
    pageControl.pageIndicatorTintColor = [UIColor clearColor];
    // 设置当前页码的点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
    
    [self.view addSubview:pageControl];
    
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算当前在第几页
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}

// 点击按钮保存数据并切换根视图控制器
- (void) go:(UIButton *)sender{
    flag = YES;
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 保存用户数据
    [useDef setBool:flag forKey:@"notFirst"];
    [useDef synchronize];
    // 切换根视图控制器
    if (self.is_show_tip) {
        RootViewController *VC = [[RootViewController alloc]init];
        VC.pathUrl = self.pathUrl;
        [self.view.window setRootViewController:VC];
    }else{
        MainViewController *main=[[MainViewController alloc] init];
        JDNavigationController *navi = [[JDNavigationController alloc]initWithRootViewController:main];
        navi.navigationBar.hidden = YES;
        [UIApplication sharedApplication].keyWindow.rootViewController=navi;

    }
//    CRMLoginViewController *login = [[CRMLoginViewController alloc]init];
//    JDNavigationController *navi = [[JDNavigationController alloc]initWithRootViewController:login];
//    navi.navigationBar.hidden = YES;
//    self.view.window.rootViewController = navi;
}

@end
