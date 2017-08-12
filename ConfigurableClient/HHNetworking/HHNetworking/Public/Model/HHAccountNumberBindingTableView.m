//
//  HHAccountNumberBindingTableView.m
//  HHAutoBusiness
//
//  Created by 葛建民 on 16/8/5.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHAccountNumberBindingTableView.h"
#import "HHAccountNumberBindingCell.h"
@interface HHAccountNumberBindingTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)UIView *footerView;
@property(nonatomic,strong)UIImageView * cardView;
@property(nonatomic,strong)UILabel * cardLable;
@property(nonatomic,strong)UIButton * card_Right_narrow_Button;
@property(nonatomic,strong)UIButton * card_Button;


@end
@implementation HHAccountNumberBindingTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[HHAccountNumberBindingCell class] forCellReuseIdentifier:@"HHAccountNumberBindingCell"];
        self.dataSoucreArray = [[NSMutableArray alloc]init];
        
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoucreArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 115*[ScreenAdaptation adapterMultipleByWidth];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15*[ScreenAdaptation adapterMultipleByWidth];
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    self.footerView = [[UIView alloc]init];
    self.footerView.backgroundColor =[UIColor whiteColor];
    [self creatView];
    return self.footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44*[ScreenAdaptation adapterMultipleByWidth];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"HHAccountNumberBindingCell";
    HHAccountNumberBindingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HHAccountNumberBindingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:RGBACOLOR(238.0,238.0,238.0,1)];

    self.settledManageModel  = [[HHSettedManageModel alloc]init];
    self.settledManageModel = [HHSettedManageModel mj_objectWithKeyValues:self.dataSoucreArray[indexPath.row]];
    cell.settledManageModel = self.settledManageModel;
    cell.bankNameLable.text = self.settledManageModel.BankName;
    cell.bankIdLabel.text = self.settledManageModel.CardId;
    cell.bankbgImageView.backgroundColor =[UIColor colorFromHexString:self.settledManageModel.Color];
    return cell;
    
}
-(void)creatView{
    self.cardView = [[UIImageView alloc]init];
    self.cardView.image = [UIImage imageNamed:@"账号"];
    [self.footerView addSubview:self.cardView];
    
    self.cardLable = [[UILabel alloc]init];
    self.cardLable.text = @"添加银行卡";
    self.cardLable.textColor = [UIColor blackColor];
    self.cardLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.footerView addSubview:self.cardLable];
    self.card_Button =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.card_Button addTarget:self action:@selector(addBankCardClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.card_Button];
    self.card_Right_narrow_Button =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.card_Right_narrow_Button setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
    [self.card_Right_narrow_Button addTarget:self action:@selector(addBankCardClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.card_Right_narrow_Button];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.footerView.mas_left).offset(15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.footerView.mas_top).offset(13*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(20*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(20*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.cardLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.cardView.mas_right).offset(5*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.footerView.mas_top).offset(12*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(21*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(100*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.card_Right_narrow_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.footerView.mas_right).offset(-15*[ScreenAdaptation adapterMultipleByWidth]);
        make.centerY.equalTo(self.footerView.mas_centerY).offset(0);
        make.height.equalTo(@(18.5*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(10.5*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    [self.card_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.footerView.mas_right).offset(0);
        make.left.equalTo(self.footerView.mas_left).offset(0);
        make.centerY.equalTo(self.footerView.mas_centerY).offset(0);
        make.height.equalTo(@(44*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
}

-(void)addBankCardClicked:(UIButton *)btn{

    [self.bankCardDelegate JumpToAddbankCardControllerVCDelegate];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
