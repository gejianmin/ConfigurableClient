//
//  SecondViewController.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/7/27.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "SecondViewController.h"
#import "UIView+RoundCorner.h"

@interface SecondViewController ()
{
}
@property (nonatomic, strong) CustomBtn * button;
@property (nonatomic, strong) UIView * tapView;
@property (nonatomic, strong) UIWindow * window;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kColorBlue];
    [self setupUI];
    
}
-(void)setupUI{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
