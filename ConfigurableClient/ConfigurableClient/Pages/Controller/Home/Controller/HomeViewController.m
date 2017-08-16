//
//  HomeViewController.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/7/5.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "HomeViewController.h"
#import "HHBannerView.h"
#import "HeaderModel.h"
#import "HHBaseWebViewcontroller.h"
#import "HomeCell.h"
@interface HomeViewController ()<HHBannerViewDelegate>
{
    int _pageSize;
    int _coupunPageIndex;
  
}
@property (nonatomic, strong) HHBannerView * bannerView;
@property (nonatomic, strong) NSMutableArray * dataSourceArray;
@property (nonatomic, strong) CustomBtn * button;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configDataSource];
    [self initUI];
    self.newsCategoryType = kNewsCategoryTypeHeadline;
}
-(void)initUI{
    _pageSize=10;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.frame = CGRectMake(0, 63, HH_SCREEN_W, HH_SCREEN_H-64-10);
    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:NSStringFromClass([HomeCell class])];
    [self.tableView setTableHeaderView:[self tableViewHeaderView]];
    self.tableView.mj_header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(configDataSource)];
    [self.view addSubview:self.tableView];
}
-(UIView *)tableViewHeaderView {
     self.bannerView = [[HHBannerView alloc]initWithFrame:CGRectMake(0, 64, HH_SCREEN_W, 260) WithBannerSource:NinaBannerStyleOnlyWebSource WithBannerArray:nil titleArray:nil];
    _bannerView.timeInterval = 2;
    _bannerView.showPageControl = YES;
    _bannerView.showTransition = YES;
    _bannerView.delegate = self;
    return self.bannerView;
}
-(void)setupUIWithimageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray {
    [_bannerView reloadDataWithBannerArray:imageArray titleArray:titleArray];
}
-(NSMutableArray *)dataSourceArray{
    if (_dataSourceArray == nil) {
        _dataSourceArray =[[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
}
#pragma mark - tableViewDelegate
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
            [self.navigationController pushViewController:VC animated:YES];
        }
    }];
    
}
#pragma mark - HHBannerViewDelegate
- (void)hhBannerView:(HHBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    HeaderModel *model=self.dataSourceArray[index];
    NSString * newsId = [NSString stringWithFormat:@"%@%@",kNews_HeadlineNewsId,model.newsId];
    [[[HHClient sharedInstance] sessionManager] post:newsId params:nil complete:^(id response, HHError *error) {
        if (error) {
            [self showToastHUD:error.localizedDescription complete:nil];
        }else{
            NSArray * list =[HeaderModel mj_objectArrayWithKeyValuesArray:response[@"newslist"]];
            HeaderModel * modelTemp = [list firstObject];
            HHBaseWebViewcontroller * VC =[[HHBaseWebViewcontroller alloc]init];
            VC.url = modelTemp.url;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }];
    
}
-(void)configDataSource{
    [self showHUDText:nil];
    NSString * newsApi = [NSString stringWithFormat:@"%@%lu",kNews_HeadlineApi,(unsigned long)self.newsCategoryType];

    [[[HHClient sharedInstance] sessionManager] post:newsApi params:nil complete:^(id response, HHError *error) {
        [self hideHUD];
        [self.tableView.mj_header endRefreshing];

        if (error) {
            [self showToastHUD:error.localizedDescription complete:nil];
        }else{
            NSArray * list =[HeaderModel mj_objectArrayWithKeyValuesArray:response[@"newslist"]];
//                            if (list.count<_pageSize) {
//                                self.tableView.mj_footer=nil;
//                            }else{
//                                self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataSource)];
//                            }
            [self.dataSourceArray removeAllObjects];
            [self.dataSourceArray addObjectsFromArray:list];
            [self.tableView reloadData];
            NSMutableArray * array = [NSMutableArray array];
            NSMutableArray * titleArray = [NSMutableArray array];
            for (int i = 0; i < 4; i++) {
                HeaderModel *model=self.dataSourceArray[i];
                if (![model.image isEqualToString:@""]) {
                    [array addObject:model.image];
                    [titleArray addObject:model.title];
                }
            };
            [self setupUIWithimageArray:array titleArray:titleArray];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
