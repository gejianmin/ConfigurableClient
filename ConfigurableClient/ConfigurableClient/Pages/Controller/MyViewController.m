//
//  ThirdViewController.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/7/27.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "MyViewController.h"

#import "MPMineCell.h"
#import "MPMineHeaderView.h"
#import "CommentsAndFeedbackVC.h"
#import "AboutViewController.h"
//#import "MPCollectionViewController.h"
//#import "MPSettingViewController.h"
//#import "MPHtmlViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property (nonatomic, strong) MPMineHeaderView * headerView;
@property (nonatomic, strong) NSArray <NSArray <MPUserItem *>*> *dataSourceArray;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self addRightBarItemWithTitle:@"切换身份" tintColor:kColorWhite target:self action:@selector(addContactsEvent:)];
    [self initUI];
}
-(void)initUI{
    
    self.tableView.backgroundColor=[UIColor clearColor];
    [self.tableView registerClass:[MPMineCell class] forCellReuseIdentifier:NSStringFromClass([MPMineCell class])];
    [self.tableView setTableHeaderView:[self tableViewHeaderView]];
    [self.view addSubview:self.tableView];
    
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGPoint offset = scrollView.contentOffset;
//    if (offset.y <= 0) {
//        CGRect rect =self.headerView.frame;
//        rect.origin.y = offset.y;
//        rect.size.height =CGRectGetHeight(rect)-offset.y;
//        self.headerView.bgImageView.frame = rect;
//        self.headerView.clipsToBounds=NO;
//    }
//}
-(NSArray<NSArray <MPUserItem *>*> *)dataSourceArray{
    if (_dataSourceArray == nil) {
        MPUserItem *save=[[MPUserItem alloc] init];
        //        save.imageName=mp_mine_save;
        save.title=@"Comments and feedback";
        save.pushControllerClass=[CommentsAndFeedbackVC class];
        
        MPUserItem * kefu = [[MPUserItem alloc] init];
        //        kefu.imageName=mp_mine_kefu;
        kefu.title=@"The version number";
        
        MPUserItem * setting = [[MPUserItem alloc] init];
        //        setting.imageName=mp_mine_setting;
        setting.title=@"About";
        setting.pushControllerClass=[AboutViewController class];
        
        MPUserItem * clear = [[MPUserItem alloc] init];
        //        setting.imageName=mp_mine_setting;
        clear.title=@"Clearing the cache";
        //        setting.pushControllerClass=[MPHtmlViewController class];
        MPUserItem * select = [[MPUserItem alloc] init];
        //        setting.imageName=mp_mine_setting;
        select.title=@"";
        //        setting.pushControllerClass=[MPHtmlViewController class];
        
        
        
        _dataSourceArray=@[@[save,kefu,setting,clear]];//,@[setting]
        
    }
    return _dataSourceArray;
}
-(UIView *)tableViewHeaderView{
    self.headerView = [[MPMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, HH_SCREEN_W, 260)];
    [self.headerView.companyChenged addTarget:self action:@selector(addContactsEvent:) forControlEvents:UIControlEventTouchUpInside];
    return self.headerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //    if (section == 0) {
    //
    //        return 0.00001;
    //    }
    //    return 10;
    return 0.00001;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSourceArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 56;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MPMineCell * cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MPMineCell class])];
    MPUserItem *item=self.dataSourceArray[indexPath.section][indexPath.row];
    cell.iconBtnImage=item.imageName;
    if (indexPath.row == 1) {
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.rightLbl.hidden = NO;
        cell.rightLbl.text = @"V1.0";
    }
    cell.title=item.title;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 3) {
        [self showAlertWithTitle:@"Clearing the cache" sureTitle:@"Determine" cancelTitle:@"Cancel" content:nil];
    }else{
        MPUserItem *item=self.dataSourceArray[indexPath.section][indexPath.row];
        UIViewController *vc=[[item.pushControllerClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
- (void)showAlertWithTitle:(NSString *)title sureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle content:(NSString *)content {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    __weak typeof(self) weakSelf = self;
    UIAlertAction * action_sure = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf showHUDText:@"Cache clearing..."];
        
        dispatch_async(dispatch_queue_create(0, 0), ^{
            // 子线程执行任务（比如获取较大数据）
            [[SDImageCache sharedImageCache] clearDisk];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 通知主线程刷新 神马的
                [weakSelf hideHUD];
                [weakSelf showToastHUD:@"Erase completed" complete:nil];
                //                [weakSelf reloadDataWithContent:urlStr indexPath:indexPath];
                //                [weakSelf.crm_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
            });
        });
    }];
    [alert addAction:action_sure];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma  mark -- 切换身份
-(void)addContactsEvent:(UIButton *)sender{
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    //   [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
@implementation MPUserItem

@end

