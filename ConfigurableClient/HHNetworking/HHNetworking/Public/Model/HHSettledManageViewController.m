//
//  HHSettledManageViewController.m
//  HHAutoBusiness
//
//  Created by 葛建民 on 16/8/4.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHSettledManageViewController.h"
#import "HHAccountNumberBindingViewController.h"
#import "HHBookingManageViewController.h"
@interface HHSettledManageViewController ()<JumpToAddbankControllerVCDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * settledScrollView;
@end

@implementation HHSettledManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    self.settledScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, HH_SCREEN_W, HH_SCREEN_H)];
    self.settledScrollView.delegate = self;
    [self.view addSubview:self.settledScrollView];
    self.settledScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新
        [self requestData];
        
        
    }];
    //[self setupUI];
}
-(void)setupUI{
    HHSettledManageView * settleManageView = [[HHSettledManageView alloc]initWithFrame:CGRectMake(0, 0, HH_SCREEN_W, HH_SCREEN_H)];

    self.settedManageView = settleManageView;
    settleManageView.settedManageModel = self.settedManageModel;
    HHLog(@"%@",settleManageView.settedManageModel.TotalMoney);

    self.settedManageView.bankDelegate = self;
    [self.settledScrollView addSubview:settleManageView];
    //

 }
#pragma mark 未结算
-(void)JumpToNotSetlledControllerVCDelegate{
    HHBookingManageViewController * VC = [[HHBookingManageViewController alloc]init];
    VC.title = @"未结算明细";
    VC.isNotSettledOrder = YES;
    [self.navigationController pushViewController:VC animated:YES];

}
#pragma mark 已结算
-(void)JumpToSettledControllerVCDelegate{
    
    HHBookingManageViewController * VC = [[HHBookingManageViewController alloc]init];
    VC.title = @"已结算明细";
    VC.isSettledOrder = YES;
    [self.navigationController pushViewController:VC animated:YES];


}
#pragma mark 添加银行卡
-(void)JumpToAddbankControllerVCDelegate{
    HHAccountNumberBindingViewController * VC = [[HHAccountNumberBindingViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];

}
-(void)requestData{
    [self showHUDText:nil];
    [[HHClient sharedInstance].orderSession asyncSettledManageHomeComplete:^(id response, HHError *error) {
        [self hideHUD];
        if (error) {
            [self showToastHUD:error.errorDescription complete:nil];
        }else{
            HHSettedManageModel * orderModel = [HHSettedManageModel mj_objectWithKeyValues:response];
            self.settedManageModel = orderModel;
            HHLog(@"%@",self.settedManageModel.TotalMoney);
            [self setupUI];

                    }
        [self.settledScrollView.mj_header endRefreshing];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
