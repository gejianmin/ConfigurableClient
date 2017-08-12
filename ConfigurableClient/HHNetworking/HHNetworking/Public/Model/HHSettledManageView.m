//
//  HHSettledManageView.m
//  HHAutoBusiness
//
//  Created by 葛建民 on 16/8/4.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHSettledManageView.h"
#import "ScreenAdaptation.h"
@interface HHSettledManageView ()

@property(nonatomic,strong)UILabel * totalLable;
@property(nonatomic,strong)UIImageView * MoneyView;
@property(nonatomic,strong)UILabel * totalMoneyLable;
@property(nonatomic,strong)UIView * bgview1;
@property(nonatomic,strong)UILabel * lable1;


@property(nonatomic,strong)UIView * bgview2;
@property(nonatomic,strong)UILabel * notSettledLable;
@property(nonatomic,strong)UILabel * notSettledMoneyLable;
@property(nonatomic,strong)UIButton * notSettledButton;
@property(nonatomic,strong)UIImageView * notSettledView;
@property(nonatomic,strong)UIImageView * settledView;

@property(nonatomic,strong)UILabel * settledLable;
@property(nonatomic,strong)UILabel * settledMoneyLable;
@property(nonatomic,strong)UIButton * settledButton;
@property(nonatomic,strong)UILabel * lable2;
@property(nonatomic,strong)UILabel * lable3;


@property(nonatomic,strong)UIView * bgview3;
@property(nonatomic,strong)UIImageView * cardView;
@property(nonatomic,strong)UILabel * cardLable;
@property(nonatomic,strong)UIButton * card_Right_narrow_Button;
@property(nonatomic,strong)UIButton * card_Button;


@end

@implementation HHSettledManageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self creatView];
        
    }
    return self;
}
-(void)creatView{
    
    self.backgroundColor = RGBACOLOR(238.0,238.0,238.0,1);
    self.bgview1 = [[UIView alloc]init];
    [self.bgview1 setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.bgview1];
    
    self.totalLable = [[UILabel alloc]init];
    self.totalLable.text = @"总金额";
    self.totalLable.textColor = RGBACOLOR(51.0,128.0,209.0,1);
    self.totalLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20*[ScreenAdaptation adapterMultipleByWidth]];
    [self.bgview1 addSubview:self.totalLable];
    
    self.MoneyView = [[UIImageView alloc]init];
    self.MoneyView.image = [UIImage imageNamed:@"金额"];
    [self.bgview1 addSubview:self.MoneyView];
    
    self.totalMoneyLable = [[UILabel alloc]init];
    self.totalMoneyLable.text = @"2880";
    //self.totalMoneyLable.backgroundColor =[UIColor redColor];
    self.totalMoneyLable.textColor = RGBACOLOR(51.0,128.0,209.0,1);
    self.totalMoneyLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:32*[ScreenAdaptation adapterMultipleByWidth]];
    [self.bgview1 addSubview:self.totalMoneyLable];
    self.lable1 = [[UILabel alloc]init];
    self.lable1.text = @"元";
    //self.lable1.backgroundColor =[UIColor blueColor];
    self.lable1.textColor = RGBACOLOR(51.0,128.0,209.0,1);
    self.lable1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.bgview1 addSubview:self.lable1];
    
    self.bgview2 = [[UIView alloc]init];
    [self.bgview2 setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.bgview2];
    
    self.notSettledView = [[UIImageView alloc]init];
    self.notSettledView.image = [UIImage imageNamed:@"结算"];
    [self.bgview2 addSubview:self.notSettledView];
    
    
    self.notSettledLable = [[UILabel alloc]init];
    self.notSettledLable.text = @"未结算金额";
    self.notSettledLable.textColor = RGBACOLOR(87.0,217.0,177.0,1);
    self.notSettledLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13*[ScreenAdaptation adapterMultipleByWidth]];
    [self.notSettledView addSubview:self.notSettledLable];
    self.notSettledMoneyLable = [[UILabel alloc]init];
    //self.totalMoneyLable.backgroundColor =[UIColor redColor];
    self.notSettledMoneyLable.textColor = RGBACOLOR(87.0,217.0,177.0,1);
    self.notSettledMoneyLable.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:20*[ScreenAdaptation adapterMultipleByWidth]];
    [self.notSettledView addSubview:self.notSettledMoneyLable];
    
    self.lable2 = [[UILabel alloc]init];
    self.lable2.text = @"元";
    //self.lable1.backgroundColor =[UIColor blueColor];
    self.lable2.textColor = RGBACOLOR(87.0,217.0,177.0,1);
    self.lable2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.notSettledView addSubview:self.lable2];
    //未结算按钮
    self.notSettledButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.notSettledButton setBackgroundImage:[UIImage imageNamed:@"已查看"] forState:UIControlStateNormal];
    [self.notSettledButton setBackgroundImage:[UIImage imageNamed:@"点击已查看"] forState:UIControlStateHighlighted];
    [self.notSettledButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.notSettledButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.notSettledButton setTitle:@"查看明细" forState:UIControlStateNormal];
    
    [self.notSettledButton addTarget:self action:@selector(notSettledButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgview2 addSubview:self.notSettledButton];
    
    
    self.settledView = [[UIImageView alloc]init];
    self.settledView.image = [UIImage imageNamed:@"结算"];
    [self.bgview2 addSubview:self.settledView];
    self.settledLable = [[UILabel alloc]init];
    self.settledLable.text = @"已结算金额";
    self.settledLable.textColor = RGBACOLOR(51.0,128.0,209.0,1);
    self.settledLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13*[ScreenAdaptation adapterMultipleByWidth]];
    [self.settledView addSubview:self.settledLable];
    self.settledMoneyLable = [[UILabel alloc]init];
    
    //self.totalMoneyLable.backgroundColor =[UIColor redColor];
    self.settledMoneyLable.textColor = RGBACOLOR(51.0,128.0,209.0,1);
    self.settledMoneyLable.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:20*[ScreenAdaptation adapterMultipleByWidth]];
    [self.settledView addSubview:self.settledMoneyLable];
    self.lable3 = [[UILabel alloc]init];
    self.lable3.text = @"元";
    //self.lable1.backgroundColor =[UIColor blueColor];
    self.lable3.textColor = RGBACOLOR(51.0,128.0,209.0,1);
    self.lable3.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.settledView addSubview:self.lable3];
    //结算按钮
    self.settledButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.settledButton setTitle:@"查看明细" forState:UIControlStateNormal];
    [self.settledButton setBackgroundImage:[UIImage imageNamed:@"未查看"] forState:UIControlStateNormal];
    [self.settledButton setBackgroundImage:[UIImage imageNamed:@"点击未查看"] forState:UIControlStateHighlighted];
    self.settledButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.settledButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.settledButton addTarget:self action:@selector(settledButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgview2 addSubview:self.settledButton];
    
    self.bgview3 = [[UIView alloc]init];
    [self.bgview3 setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.bgview3];
    self.cardView = [[UIImageView alloc]init];
    self.cardView.image = [UIImage imageNamed:@"添加账号"];
    [self.bgview3 addSubview:self.cardView];
    
    self.cardLable = [[UILabel alloc]init];
    self.cardLable.text = @"账号绑定";
    self.cardLable.textColor = [UIColor blackColor];
    self.cardLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.bgview3 addSubview:self.cardLable];
    
    self.card_Button =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.card_Button addTarget:self action:@selector(addBankCardClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgview3 addSubview:self.card_Button];
    self.card_Right_narrow_Button =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.card_Right_narrow_Button setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
    [self.card_Right_narrow_Button addTarget:self action:@selector(addBankCardClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgview3 addSubview:self.card_Right_narrow_Button];
    
}
-(void)layoutSubviews{
    self.totalMoneyLable.text = self.settedManageModel.TotalMoney;
    self.settledMoneyLable.text = self.settedManageModel.StatementedMoney;
    self.notSettledMoneyLable.text = self.settedManageModel.UnstatementMoney;
    [self.bgview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.equalTo(@(135*[ScreenAdaptation adapterMultipleByWidth]));
        
        
    }];
    [self.totalLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgview1.mas_left).offset(15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.bgview1.mas_top).offset(15*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(28*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(120*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.MoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgview1.mas_left).offset(((375-24)/2)*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.bgview1.mas_top).offset((99/2)*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(24*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(24*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.totalMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.bgview1.mas_centerX).offset(0);
        make.top.equalTo(self.MoneyView.mas_bottom).offset(0);
        make.height.equalTo(@(45*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.totalMoneyLable.mas_right).offset(0);
        make.top.equalTo(self.totalMoneyLable.mas_bottom).offset(-28*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(21*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(15*[ScreenAdaptation adapterMultipleByWidth]));
        
        
    }];
    
    [self.notSettledView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgview2.mas_left).offset(7*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.bgview2.mas_top).offset(10*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(80*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@((354/2)*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.notSettledButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgview2.mas_left).offset(7*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.notSettledView.mas_bottom).offset(4.5*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(44*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@((354/2)*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    
    
    [self.settledView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.notSettledView.mas_right).offset(7*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.bgview2.mas_top).offset(10*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(80*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@((354/2)*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.settledButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.notSettledButton.mas_right).offset(7);
        make.top.equalTo(self.settledView.mas_bottom).offset(9/2);
        make.height.equalTo(@(44*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(177*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.notSettledLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.notSettledView.mas_left).offset(15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.notSettledView.mas_top).offset(10*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(18.5*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(70*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.settledLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.settledView.mas_left).offset(15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.settledView.mas_top).offset(10*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(18.5*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(65*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.notSettledMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.notSettledView.mas_centerX).offset(0);
        make.top.equalTo(self.notSettledLable.mas_bottom).offset(8.5*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(28*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.settledMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.settledView.mas_centerX).offset(0);
        make.top.equalTo(self.settledLable.mas_bottom).offset(8.5*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(28*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.notSettledMoneyLable.mas_right).offset(0);
        make.top.equalTo(self.notSettledMoneyLable.mas_bottom).offset(-23*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(21*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(15*[ScreenAdaptation adapterMultipleByWidth]));
        
        
    }];
    [self.lable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.settledMoneyLable.mas_right).offset(0);
        make.top.equalTo(self.settledMoneyLable.mas_bottom).offset(-23*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(21*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(15*[ScreenAdaptation adapterMultipleByWidth]));
        
        
    }];
    
    
    [self.bgview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.bgview1.mas_bottom).offset(9.5*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(148.5*[ScreenAdaptation adapterMultipleByWidth]));
        
        
    }];
    [self.bgview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.bgview2.mas_bottom).offset(9.5*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(44*[ScreenAdaptation adapterMultipleByWidth]));
        
        
    }];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bgview3.mas_left).offset(15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.bgview3.mas_top).offset(12*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(20*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(20*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.cardLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.cardView.mas_right).offset(5*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.bgview3.mas_top).offset(11*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(21*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(60*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.card_Right_narrow_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.bgview3.mas_right).offset(-15*[ScreenAdaptation adapterMultipleByWidth]);
        make.centerY.equalTo(self.bgview3.mas_centerY).offset(0);
        make.height.equalTo(@(18.5*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(10.5*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.card_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.bgview3.mas_right).offset(0);
        make.left.equalTo(self.bgview3.mas_left).offset(0);
        make.centerY.equalTo(self.bgview3.mas_centerY).offset(0);
        make.height.equalTo(@(44*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];

}
#pragma mark 未结算
-(void)notSettledButtonClicked:(UIButton *)btn{
    
    [self.bankDelegate JumpToNotSetlledControllerVCDelegate];
    
}
#pragma mark 已结算
-(void)settledButtonClicked:(UIButton *)btn{
    
    [self.bankDelegate JumpToSettledControllerVCDelegate];
    
}
#pragma mark 添加银行卡
-(void)addBankCardClicked:(UIButton *)btn{
    
    [self.bankDelegate JumpToAddbankControllerVCDelegate];
    
}

@end
