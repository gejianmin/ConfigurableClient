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
    self.window = [UIApplication sharedApplication].keyWindow;
    [self.window addSubview:self.tapView];

}
-(void)setupUI{
    _button =[[CustomBtn alloc]initWithFrame:CGRectMake(100, 350, 80, 80) Tag:0 Title:nil backgroundColor:kColorBlue TitleTextColor:nil Font:0 Image:ImageNamed(@"1024")];
    [self.view addSubview:_button];
    [_button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buttonEvent{
    //    if (self.parentViewController) {
//    self.view.frame = CGRectMake(100, 100, 80, 80);
//    [self.view makeRoundedCorner:40.0f];
    self.view.hidden = YES;
    self.tapView.frame = CGRectMake(100, 100, 80, 80);
    [self.window addSubview:self.view];
    //    }
    
}
-(UIView *)tapView{
    if (_tapView == nil) {
        _tapView =[[UIView alloc]init];
        _tapView.backgroundColor = kColorBlue;
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent:)];
        [_tapView addGestureRecognizer:tap];
    }
    return _tapView;
}
-(void)tapEvent:(UITapGestureRecognizer *)tap{
    self.view.hidden = NO;

//        [_tapView removeFromSuperview];
//        self.view.frame = CGRectMake(0, 0, HH_SCREEN_W, HH_SCREEN_H);
//        [self.view makeRoundedCorner:0.0f];
//    SecondViewController * VC =[[SecondViewController alloc]init];
//    [self presentViewController:VC animated:YES completion:nil];
    
    
}
//-(void)viewDidDisappear:(BOOL)animated{
//    [_tapView removeFromSuperview];
//    self.parentViewController.view.frame = CGRectMake(0, 0, HH_SCREEN_W, HH_SCREEN_H);
//    [self.parentViewController.view makeRoundedCorner:0.0f];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
