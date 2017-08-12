//
//  HHAddBankCardViewController.m
//  HHAutoBusiness
//
//  Created by 葛建民 on 16/8/5.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHAddBankCardViewController.h"

@interface HHAddBankCardViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSString * bankName;
@property(nonatomic,strong)UILabel * bankNameLabel;
@property(nonatomic,strong)UIButton * sub_btn;
@property(nonatomic,strong)UITextField * bankName_tf;
@property(nonatomic,strong)UITextField * bank_Name_tf;
@property(nonatomic,strong)NSMutableArray * bankCardsArray;
@property(nonatomic,strong)NSString * bankCode;
@property(nonatomic,strong)NSString * bankIdString;



@property(nonatomic,strong)UITextField * bankId_tf;
@property (nonatomic, strong) UITapGestureRecognizer *singleRecognizer;



@end

@implementation HHAddBankCardViewController
-(void)viewWillAppear:(BOOL)animated{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行";
    [self setupUI];
    self.singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
    self.singleRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleRecognizer];
}
-(void)setupUI{
    UIView * view1 = [[UIView alloc]init];
    //view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(64*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(80*[ScreenAdaptation adapterMultipleByWidth]));

    }];
    UIImageView * cardView1 = [[UIImageView alloc]init];
    cardView1.image = [UIImage imageNamed:@"开户行"];
    [view1 addSubview:cardView1];
    [cardView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view1.mas_left).offset(15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view1.mas_top).offset(50*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(18*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(19*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UILabel *cardLable1 = [[UILabel alloc]init];
    cardLable1.text = @"开户行名称";
    cardLable1.textColor = kColorGray6;
    cardLable1.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12*[ScreenAdaptation adapterMultipleByWidth]];
    [view1 addSubview:cardLable1];
    
    [cardLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view1.mas_left).offset(50*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view1.mas_top).offset(25*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(33*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(120*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UITextField * bank_Name_tf = [[UITextField alloc]init];
    self.bank_Name_tf = bank_Name_tf;
    self.bank_Name_tf.delegate = self;
    bank_Name_tf.placeholder = @"请选择开户银行";
    bank_Name_tf.enabled = NO;
    bank_Name_tf.textColor = kColorGray1;
    bank_Name_tf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.bank_Name_tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [view1 addSubview:bank_Name_tf];
    [bank_Name_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cardLable1.mas_left).offset(0);
        make.top.equalTo(cardView1.mas_top).offset(0);
        make.height.equalTo(@(21*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(180*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
   
    UILabel * bankName_lb = [[UILabel alloc]init];
    self.bankNameLabel = bankName_lb;
    // bankName_lb.text = @"请选择开户银行";
    bankName_lb.textColor = kColorGray6;
    bankName_lb.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [bank_Name_tf addSubview:bankName_lb];
    [bankName_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cardLable1.mas_left).offset(0);
        make.top.equalTo(cardView1.mas_top).offset(0);
        make.height.equalTo(@(21*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(180*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UIButton * selectedBtn_bg =[UIButton buttonWithType:UIButtonTypeCustom];
    [selectedBtn_bg addTarget:self action:@selector(selectedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:selectedBtn_bg];
    [selectedBtn_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(view1.mas_right).offset(0*[ScreenAdaptation adapterMultipleByWidth]);
        make.left.equalTo(bank_Name_tf.mas_left).offset(0*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(bank_Name_tf.mas_top).offset(0*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(25*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UIButton * selectedBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [selectedBtn setBackgroundImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    [selectedBtn setBackgroundImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateHighlighted];
    [selectedBtn addTarget:self action:@selector(selectedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:selectedBtn];
    [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(view1.mas_right).offset(-15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view1.mas_top).offset(54.5*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(7*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(12*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];

    UILabel *cardLable_line1 = [[UILabel alloc]init];
    cardLable_line1.backgroundColor = RGBACOLOR(224,224,224,1);
    [view1 addSubview:cardLable_line1];
    [cardLable_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view1.mas_left).offset(50*[ScreenAdaptation adapterMultipleByWidth]);
        make.right.equalTo(view1.mas_right).offset(-15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view1.mas_bottom).offset(-1*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(1*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    
    
    
    UIView * view2 = [[UIView alloc]init];
    //view2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(view1.mas_bottom).offset(0);
        make.height.equalTo(@(82.5*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UIImageView * cardView2 = [[UIImageView alloc]init];
    cardView2.image = [UIImage imageNamed:@"卡号"];
    [view2 addSubview:cardView2];
    [cardView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view2.mas_left).offset(15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view2.mas_top).offset(56*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(18*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(19*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UILabel *cardLable2 = [[UILabel alloc]init];
    cardLable2.text = @"储蓄卡卡号";
    cardLable2.textColor = kColorGray6;
    cardLable2.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12*[ScreenAdaptation adapterMultipleByWidth]];
    [view2 addSubview:cardLable2];
    
    [cardLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view2.mas_left).offset(50*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view2.mas_top).offset(23*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(33*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(120*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UITextField * bankId_tf = [[UITextField alloc]init];
    self.bankId_tf = bankId_tf;
    self.bankId_tf.delegate = self;
    bankId_tf.placeholder = @"请输入储蓄卡卡号";
    bankId_tf.clearButtonMode = UITextFieldViewModeAlways;
    bankId_tf.keyboardType = UIKeyboardTypeNumberPad;
    bankId_tf.textColor = kColorGray1;
    bankId_tf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.bankId_tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [view2 addSubview:bankId_tf];
    [bankId_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cardLable2.mas_left).offset(-5*[ScreenAdaptation adapterMultipleByWidth]);
        make.right.equalTo(view2.mas_right).offset(-15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(cardView2.mas_top).offset(-3*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(21*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    
    UILabel *cardLable_line2 = [[UILabel alloc]init];
    cardLable_line2.backgroundColor = RGBACOLOR(224,224,224,1);
    [view2 addSubview:cardLable_line2];
    [cardLable_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view2.mas_left).offset(50*[ScreenAdaptation adapterMultipleByWidth]);
        make.right.equalTo(view2.mas_right).offset(-15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view2.mas_bottom).offset(-1*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(1*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];

    
    UIView * view3 = [[UIView alloc]init];
    //view3.backgroundColor = [UIColor redColor];
    [self.view addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(view2.mas_bottom).offset(0);
        make.height.equalTo(@(82.5*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UIImageView * cardView3 = [[UIImageView alloc]init];
    cardView3.image = [UIImage imageNamed:@"开户人姓名"];
    [view3 addSubview:cardView3];
    [cardView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view3.mas_left).offset(15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view3.mas_top).offset(56*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(18*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(19*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UILabel *cardLable3 = [[UILabel alloc]init];
    cardLable3.text = @"开户人姓名";
    cardLable3.textColor = kColorGray6;
    cardLable3.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12*[ScreenAdaptation adapterMultipleByWidth]];
    [view3 addSubview:cardLable3];
    
    [cardLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view3.mas_left).offset(50*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view2.mas_bottom).offset(23*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(33*[ScreenAdaptation adapterMultipleByWidth]));
        make.width.equalTo(@(120*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UITextField * bankName_tf = [[UITextField alloc]init];
    self.bankName_tf = bankName_tf;
    self.bankName_tf.delegate = self;
    bankName_tf.placeholder = @"请输入持卡人姓名";
    bankName_tf.clearButtonMode = UITextFieldViewModeAlways;
    bankName_tf.textColor = kColorGray1;
    [self.bankName_tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    bankName_tf.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [view3 addSubview:bankName_tf];
    [bankName_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cardLable3.mas_left).offset(0);
        make.right.equalTo(view3.mas_right).offset(-15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(cardView3.mas_top).offset(-3*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(21*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UILabel *cardLable_line3 = [[UILabel alloc]init];
    cardLable_line3.backgroundColor = RGBACOLOR(224,224,224,1);
    [view3 addSubview:cardLable_line3];
    [cardLable_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view3.mas_left).offset(50*[ScreenAdaptation adapterMultipleByWidth]);
        make.right.equalTo(view3.mas_right).offset(-15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view3.mas_bottom).offset(-1*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(1*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
    UIButton * subBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    self.sub_btn = subBtn;
    [subBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.sub_btn setBackgroundImage:[UIImage imageNamed:@"点击保存"] forState:UIControlStateNormal];

    subBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [subBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [subBtn addTarget:self action:@selector(subButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    subBtn.enabled = NO;
    [self.view addSubview:subBtn];
    [subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(view3.mas_left).offset(15*[ScreenAdaptation adapterMultipleByWidth]);
        make.right.equalTo(view3.mas_right).offset(-15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(view3.mas_bottom).offset(60*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(44*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.bankName_tf) {
        
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
                    }
    }
    if (self.bankName_tf.text.length > 0 && self.bankId_tf.text.length > 0&& self.bank_Name_tf.text.length > 0) {
        
        self.sub_btn.enabled = YES;
        [self.sub_btn setBackgroundImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
        [self.sub_btn setBackgroundImage:[UIImage imageNamed:@"点击保存1"] forState:UIControlStateHighlighted];

    }else{
        [self.sub_btn setBackgroundImage:[UIImage imageNamed:@"点击保存"] forState:UIControlStateNormal];
        self.sub_btn.enabled = NO;
    }
    //[self creatbank];
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.bankId_tf) {
//        // 四位加一个空格
//        if ([string isEqualToString:@""]) { // 删除字符
//            if ((textField.text.length - 2) % 5 == 0) {
//                textField.text = [textField.text substringToIndex:textField.text.length - 1];
//            }
//            return YES;
//        } else {
//            if (textField.text.length % 5 == 0) {
//                textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
//            }
//        }
        if (range.location>24)
        {
            return  NO;
        }
        else
        {
            // 四位加一个空格
            if ([string isEqualToString:@""]) { // 删除字符
                if ((textField.text.length - 2) % 5 == 0) {
                    textField.text = [textField.text substringToIndex:textField.text.length - 1];
                }
                return YES;
            } else {
                if (textField.text.length % 5 == 0) {
                    textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
                }
            }

            return YES;
        }
        return YES;
    }

    return YES;
}

#pragma mark 选择银行卡
-(void)selectedButtonClicked:(UIButton *)btn{
    [self.bankName_tf resignFirstResponder];
    [self.bankId_tf resignFirstResponder];
    [self requestDataForBanktype];
    //NSArray * arr =@[@"招商银行",@"中国农业银行",@"中国建设银行",@"中国工商银行"];
    
}

#pragma mark 保存
-(void)subButtonClicked:(UIButton *)btn{
    [self.bankName_tf resignFirstResponder];
    [self.bankId_tf resignFirstResponder];
    if ([self.bankNameLabel.text isEqualToString:@"请选择开户银行"] ) {
        [self showToastHUD:@"请选择您的开户银行卡" complete:nil];
        return;
    }
    if (self.bankId_tf.text.length == 0 ) {
        [self showToastHUD:@"请选择您的储蓄卡卡号" complete:nil];
        return;
    }
    if (self.bankId_tf.text.length <= 19 ) {
        [self showToastHUD:@"请您输入正确的储蓄卡卡号" complete:nil];
        return;
    }
    if (self.bankName_tf.text.length == 0 ) {
        [self showToastHUD:@"请输入开户人姓名" complete:nil];
        return;
    }
    if (![self.bankName_tf.text isContainsChinese] ) {
        [self showToastHUD:@"请输入您的中文姓名" complete:nil];
        return;
    }
    
    [self requestData];
}
-(void)requestData{
    [self showHUDText:nil];
    self.bankIdString = self.bankId_tf.text;
   
    [[HHClient sharedInstance].orderSession asyncSettledManageBankCardTypeWithBankCode:self.bankCode CardId:self.bankId_tf.text UserName:self.bankName_tf.text complete:^(id response, HHError *error) {
        [self hideHUD];
        if (error) {
            [self showToastHUD:error.errorDescription complete:nil];
        }else{
            [self showToastHUD:@"添加成功" complete:nil];
            [self performSelector:@selector(turnBack) withObject:nil afterDelay:2];
            
        }
    }];
    
}
-(void)requestDataForBanktype{
    [self showHUDText:nil];
    [[HHClient sharedInstance].orderSession asyncSettledManageBankCardTypeComplete:^(id response, HHError *error) {
        [self hideHUD];
        if (error) {
            [self showToastHUD:error.errorDescription complete:nil];
        }else{
            self.bankCardsArray = response;
            HHLog(@"%@",self.bankCardsArray[0][@"Name"]);

            [self creatBanksList];
            
        }
    }];
}
-(void)creatBanksList{

    UIAlertController * alerView = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < _bankCardsArray.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:_bankCardsArray[i][@"Name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.bankName = _bankCardsArray[i][@"Name"];
            self.bankCode = _bankCardsArray[i][@"Code"];
            self.bank_Name_tf.text = self.bankName;
            [self textFieldDidChange:self.bank_Name_tf];
            
        }];
        
        [alerView addAction:action];

    }
    UIAlertAction *action_cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alerView addAction:action_cancel];
    
    [self presentViewController:alerView animated:YES completion:nil];
    

}
-(void)turnBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)singleTap {
    [self.bankName_tf resignFirstResponder];
    [self.bankId_tf resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
