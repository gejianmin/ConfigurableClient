//
//  RootViewController.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/16.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) UIImageView * bg_view;
@property (nonatomic, strong) CustomBtn * button;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    
    self.bg_view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, HH_SCREEN_W, HH_SCREEN_H)];
    self.bg_view.image = ImageNamed(@"common_bg");
    [self.bg_view setUserInteractionEnabled:YES];
    [self.view addSubview:_bg_view];
    self.button = [[CustomBtn alloc]initWithFrame:CGRectZero Tag:0 Title:nil backgroundColor:[UIColor clearColor] TitleTextColor:nil Font:0.0f Image:ImageNamed(@"common_btn")];
    [self.button setBackgroundImage:ImageNamed(@"common_btn") forState:UIControlStateSelected];
    [self.button setBackgroundImage:ImageNamed(@"common_btn") forState:UIControlStateHighlighted];
    [self.button addTarget:self action:@selector(touchEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.bg_view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bg_view.mas_centerY);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@408);
    }];
}
-(void)touchEvent:(UIButton *)sender{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.pathUrl]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
