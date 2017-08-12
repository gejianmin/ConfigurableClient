//
//  HHAccountNumberBindingViewController.m
//  HHAutoBusiness
//
//  Created by 葛建民 on 16/8/5.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHAccountNumberBindingViewController.h"
#import "HHAccountNumberBindingTableView.h"
#import "HHAddBankCardViewController.h"
@interface HHAccountNumberBindingViewController ()<JumpToAddbankCardControllerVCDelegate>
@property(nonatomic,strong)HHAccountNumberBindingTableView * BindingBankTableView;
@end

@implementation HHAccountNumberBindingViewController
-(void)viewWillAppear:(BOOL)animated{
    [self requestData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号绑定";
    [self requestData];
    
    [self setupUI];
}
-(void)setupUI{
    
    HHAccountNumberBindingTableView * BindingBankTableView = [[HHAccountNumberBindingTableView alloc]initWithFrame:CGRectMake(0, 64, HH_SCREEN_W, HH_SCREEN_H-64) style:UITableViewStyleGrouped];
    self.BindingBankTableView = BindingBankTableView;
    self.BindingBankTableView.bankCardDelegate = self;
    self.BindingBankTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.BindingBankTableView.backgroundColor = RGBACOLOR(238.0,238.0,238.0,1);
    [self.view addSubview:BindingBankTableView];
    
    self.BindingBankTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新
        [self requestData];
        
        
    }];
    
    
}
-(void)requestData{
    [self showHUDText:nil];
    [[HHClient sharedInstance].orderSession asyncSettledManageBankCardListComplete:^(id response, HHError *error) {
        [self hideHUD];
        if (error) {
            [self showToastHUD:error.errorDescription complete:nil];
        }else{
            self.BindingBankTableView.dataSoucreArray = [NSMutableArray arrayWithArray:response];
            HHLog(@"%@",self.BindingBankTableView.dataSoucreArray);
            [self.BindingBankTableView reloadData];
            
        }
        [self.BindingBankTableView.mj_header endRefreshing];
    }];
}
-(void)JumpToAddbankCardControllerVCDelegate{
    HHAddBankCardViewController * VC = [[HHAddBankCardViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];

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
