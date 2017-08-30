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
        save.title=@"收藏";
//        save.pushControllerClass=[MPCollectionViewController class];
        
        MPUserItem * kefu = [[MPUserItem alloc] init];
//        kefu.imageName=mp_mine_kefu;
        kefu.title=@"客服";
        
        MPUserItem * setting = [[MPUserItem alloc] init];
//        setting.imageName=mp_mine_setting;
        setting.title=@"设置";
//        setting.pushControllerClass=[MPHtmlViewController class];
        
        
        _dataSourceArray=@[@[save,kefu],@[setting]];
        
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
    if (section == 0) {
        
        return 0.00001;
    }
    return 10;
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
    cell.title=item.title;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MPUserItem *item=self.dataSourceArray[indexPath.section][indexPath.row];
    
    UIViewController *vc=[[item.pushControllerClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
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

