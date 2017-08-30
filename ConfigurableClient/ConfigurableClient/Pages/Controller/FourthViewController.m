//
//  FourthViewController.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/16.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "FourthViewController.h"

#import "HeaderModel.h"
#import "HHBaseWebViewcontroller.h"
#import "HomeCell.h"
#import "YDFMDB.h"

@interface FourthViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * dataSourceArray;

@end

@implementation FourthViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataSourceArray = [[YDFMDB manager] getAllRecords];
    [self.tableView reloadData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self configDataSource];
 
    [self initUI];
    [self.tableView reloadData];

 }

-(void)initUI{
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.frame = CGRectMake(0, 63, HH_SCREEN_W, HH_SCREEN_H-64-10);
    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:NSStringFromClass([HomeCell class])];
//    [self.tableView setTableHeaderView:[self tableViewHeaderView]];
//    self.tableView.mj_header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(configDataSource)];
    [self.view addSubview:self.tableView];
}
 
- (NSMutableArray *)dataSourceArray{
    if (_dataSourceArray == nil) {
        _dataSourceArray =[[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}
#pragma mark - tableViewDelegate
-(CGFloat ) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSourceArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return [HomeCell cellHeight];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell * cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeCell class])];
    HeaderModel * model = self.dataSourceArray[indexPath.row];
    cell.headerModel= model;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HeaderModel *model=self.dataSourceArray[indexPath.row];
    NSString * newsId = [NSString stringWithFormat:@"%@%@",kNews_HeadlineNewsId,model.newsId];
    [[[HHClient sharedInstance] sessionManager] post:newsId params:nil complete:^(id response, HHError *error) {
        if (error) {
            [self showToastHUD:error.localizedDescription complete:nil];
        }else{
            NSArray * list =[HeaderModel mj_objectArrayWithKeyValuesArray:response[@"newslist"]];
            HeaderModel * modelTemp = [list firstObject];
            HHBaseWebViewcontroller * VC =[[HHBaseWebViewcontroller alloc]init];
            VC.url = modelTemp.url;
            VC.dataModel = modelTemp;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }];
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    HeaderModel * model = self.dataSourceArray[indexPath.row];
    if ([[YDFMDB manager] removeDataWithModel:model]) {
        [self showToastHUD:@"取消成功" complete:nil];
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.dataSourceArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tableView reloadData];
        });
    });

}
@end
