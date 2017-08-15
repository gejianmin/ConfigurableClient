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

@interface HomeViewController ()<HHBannerViewDelegate>
{
    
}
@property (nonatomic, strong) HHBannerView * bannerView;
@property (nonatomic, strong) NSMutableArray * dataSourceArray;
@property (nonatomic, strong) CustomBtn * button;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[[HHClient sharedInstance] sessionManager] post:kNews_Headline params:nil complete:^(id response, HHError *error) {
        if (error) {
            [self showToastHUD:error.localizedDescription complete:nil];
        }else{
            NSArray * list =[HeaderModel mj_objectArrayWithKeyValuesArray:response[@"newslist"]];
            //            if (list.count == 0) {
            //                [self reloadDataWithStatus:NO];
            //            }else{
            //                [self reloadDataWithStatus:YES];
            //                if (list.count<_pageSize) {
            //                    self.crm_tableView.mj_footer=nil;
            //                }else{
            //                    self.crm_tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataSource)];
            //                }
            //            }
            [self.dataSourceArray removeAllObjects];
            [self.dataSourceArray addObjectsFromArray:list];
            //            [self.crm_tableView reloadData];
            
            NSMutableArray * array = [NSMutableArray array];
            for (int i = 0; i < 4; i++) {
                HeaderModel *model=self.dataSourceArray[i];
                if (![model.image isEqualToString:@""]) {
                    [array addObject:model.image];
                }
            };
            [self setupUIWithimageArray:array];
        }
    }];
    
}
-(void)setupUIWithimageArray:(NSArray *)imageArray {
    _bannerView = [[HHBannerView alloc]initWithFrame:CGRectMake(0, 64, HH_SCREEN_W, 200) WithBannerSource:NinaBannerStyleOnlyWebSource WithBannerArray:imageArray];
    _bannerView.timeInterval = 2;
    _bannerView.showPageControl = YES;
    _bannerView.showTransition = YES;
    _bannerView.delegate = self;
    [self.view addSubview:self.bannerView];
}
-(NSMutableArray *)dataSourceArray{
    if (_dataSourceArray == nil) {
        _dataSourceArray =[[NSMutableArray alloc]init];
    }
    return _dataSourceArray;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
