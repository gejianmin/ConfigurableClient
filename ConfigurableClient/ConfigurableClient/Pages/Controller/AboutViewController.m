//
//  AboutViewController.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/30.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController (){
    
}
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) CustomLab * titleLbl;
@property (nonatomic, strong) CustomLab * comLbl;



@end

@implementation AboutViewController

- (void)viewDidLoad {
    self.title = @"About";
    [super viewDidLoad];
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.titleLbl];
    [self.view addSubview:self.comLbl];

    [self setupUI];
}
-(void)setupUI{
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(150.0*MPHeightScale);
        make.width.equalTo(@(120*MPWidthScale));
        make.height.equalTo(@(120*MPWidthScale));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.iconView.mas_bottom).offset(40.0*MPHeightScale);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.comLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).offset(-20.0*MPHeightScale);
        make.centerX.equalTo(self.view.mas_centerX);
    }];



}
-(UIImageView *)iconView {
        if (_iconView == nil) {
            _iconView =[[UIImageView alloc]initWithImage:ImageNamed(@"about_icon")];
        }
    return _iconView;
}
-(CustomLab *)titleLbl{
    if (_titleLbl == nil) {
        _titleLbl = [[CustomLab alloc]initWithFrame:CGRectZero font:16.f aligment:NSTextAlignmentRight text:@"Jiangsu The last 3" textcolor:kColorGray1];
    }
    return _titleLbl;
    
}
-(CustomLab *)comLbl{
    if (_comLbl == nil) {
        _comLbl = [[CustomLab alloc]initWithFrame:CGRectZero font:16.f aligment:NSTextAlignmentRight text:@"Copyright(c) 2017 Hu Gou" textcolor:kColorGray1];
    }
    return _comLbl;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
