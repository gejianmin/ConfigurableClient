//
//  CommentsAndFeedbackVC.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/30.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "CommentsAndFeedbackVC.h"
#import "AddRemindersView.h"
@interface CommentsAndFeedbackVC ()<UITableViewDelegate,UITableViewDataSource,AddRemindersViewDelegate>
{
    NSString * _date;
}
@property(nonatomic,strong)UITableView * crm_tableView;
@property(nonatomic,strong)AddRemindersView * addRemindersView;


@end

@implementation CommentsAndFeedbackVC
//-(instancetype)initWithRemindSource:(NSString *)remindSource remindSourceId:(NSString *)remindSourceId remindReceiver:(NSString *)remindReceiver{
//    if (self=[super init]) {
//        _remindSource = remindSource;
//        _remindSourceId = remindSourceId;
//        _remindReceiver = remindReceiver;
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CommentsAndFeedback";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(saveBarButtonAction:)];
    [self.view addSubview:self.crm_tableView];
}
-(UITableView *)crm_tableView{
    if (_crm_tableView==nil) {
        _crm_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
        _crm_tableView.delegate=self;
        _crm_tableView.dataSource=self;
        _crm_tableView.backgroundColor=[UIColor clearColor];
        _crm_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_crm_tableView setTableFooterView:[self tableViewFooterView]];
//        [_crm_tableView registerClass:[WriteFollowUpCell class] forCellReuseIdentifier:NSStringFromClass([WriteFollowUpCell class])];
    }
    return _crm_tableView;
}
-(UIView *)tableViewFooterView{
    self.addRemindersView =[[AddRemindersView alloc]initWithFrame:CGRectMake(0, 0, HH_SCREEN_W, self.view.height)];
    
    self.addRemindersView.delegate = self;
    return self.addRemindersView;
}

-(void)contentTextViewDidchenged{
    [self showToastHUD:@"Word Count exceeds the limit" complete:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    WriteFollowUpCell * cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WriteFollowUpCell class])];
//    cell.nameLbl.text =@"提醒时间";
//    cell.timeLbl.text =_date?_date:@"";
//    return cell;
//}

//- (HHDatePickerController *)datePicker
//{
//    if (!_datePicker) {
//        _datePicker = [[HHDatePickerController alloc]init];
//        _datePicker.datePickerStyle=HHDatePickerStyleNormal;
//        _datePicker.datePickerMode=UIDatePickerModeDate;
//            }
//    return _datePicker;
//
//}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    
//    
//    
//    //    [self.datePicker showInViewController:self];
//    HHDatePickerController *date=[[HHDatePickerController alloc] init];
//    date.datePickerStyle=HHDatePickerStyleNormal;
//    date.datePickerMode=UIDatePickerModeDateAndTime;
//    __weak typeof(self) weakself = self;
//    date.didSelectDateBlock=^(HHDate *date){
//        NSDateFormatter *dfmt=[[NSDateFormatter alloc]init];
//        [dfmt setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//        NSString *dataStr=[dfmt stringFromDate:date.date];//[[[dfmt stringFromDate:date.date] copy] substringToIndex:11];
//        _date=dataStr;
//        [tableView reloadData];
//    };
//    [date showInViewController:weakself];
//}
-(void)saveBarButtonAction:(UIButton *)sender{
//    if (_date.length == 0) {
//        [self showToastHUD:@"请添加提醒时间" complete:nil];
//        return;
//    }
    if (self.addRemindersView.contentView.text.length == 0) {
        [self showToastHUD:@"Please enter your feedback or suggestions" complete:nil];
        return;
    }
    [self showHUDText:nil];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
         [self hideHUD];
        [self showToastHUD:@"Send success!" complete:^{
                            [self.navigationController popViewControllerAnimated:YES];
                        }];


    });
    
       //        [self hideHUD];

//    NSDictionary * dict = @{
//                            @"remindContent": self.addRemindersView.contentView.text,
//                            @"remindReceiver": [[[HHClient sharedInstance] user] mobilePhone],
//                            @"remindSource": _remindSource,
//                            @"remindSourceId": _remindSourceId,
//                            @"receiveRemindTime": _date,
//                            @"enterpriseId":  [HHClient sharedInstance].EnterpriseId,
//                            @"createUser": [HHClient sharedInstance].UserId
//                            };
//    [[HHClient sharedInstance].sessionManager asyncdataDictWorkCommonAddRemindWithPramas:dict complete:^(id response, HHError *error) {
//        [self hideHUD];
//        if (error) {
//            [self showToastHUD:error.errorDescription complete:nil];
//        }else{
//            [self showToastHUD:@"新增提醒成功" complete:^{
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
//        }
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
