//
//  HomeViewController.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/7/5.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "HomeViewController.h"
#import "HHBannerView.h"
#import "SecondViewController.h"
static NSString *const kCRMWorkTeleconferenceManage = @"http://f.apiplus.net/gd11x5-10.json";/*!< 会议管理*/

@interface HomeViewController ()<HHBannerViewDelegate>
{
    
}
@property (nonatomic, strong) HHBannerView * bannerView;
@property (nonatomic, strong) NSArray * imgNamesArray;
@property (nonatomic, strong) CustomBtn * button;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bannerView];
    [[[HHClient sharedInstance] sessionManager] post:kCRMWorkTeleconferenceManage params:nil complete:^(id response, HHError *error) {
        if (error) {
            [self showToastHUD:error.localizedDescription complete:nil];
        }else{
            HHLog(@"%@",response);
                   }
    }];
    [self setupUI];
}


-(UIView *)bannerView{
    if (_bannerView == nil) {
        _bannerView = [[HHBannerView alloc]initWithFrame:CGRectMake(0, 64, HH_SCREEN_W, 200) WithBannerSource:NinaBannerStyleOnlyWebSource WithBannerArray:self.imgNamesArray];
        _bannerView.timeInterval = 2;
        _bannerView.showPageControl = YES;
        _bannerView.delegate = self;

    }
    return _bannerView;
}
-(void)setupUI{
    
}

-(NSArray *)imgNamesArray{
    if (_imgNamesArray == nil) {
        NSArray * array = @[@"http://desk.fd.zol-img.com.cn/t_s208x130c5/g5/M00/0B/05/ChMkJlcgdH2IVmv2AAYP2zcB7GQAAQr3gJjQtUABg_z016.jpg",
                            @"http://desk.fd.zol-img.com.cn/t_s208x130c5/g5/M00/0A/05/ChMkJ1cfEcmIZ2VvAAZMqeez-6YAAQn7wAeXgoABkzB552.jpg",
                            @"http://desk.fd.zol-img.com.cn/t_s208x130c5/g5/M00/00/01/ChMkJlZKi8eIRSR6ABB3m9XoGWcAAE_tgNqq6oAEHez310.jpg",
                            @"http://desk.fd.zol-img.com.cn/t_s208x130c5/g5/M00/01/00/ChMkJ1XNTGqISyLMAAJSFa0tK8sAAAEJACsrcwAAlIt345.jpg"];
        
        _imgNamesArray =[NSArray arrayWithArray:array];
    }
    return _imgNamesArray;
}
#pragma mark - HHBannerViewDelegate
- (void)hhBannerView:(HHBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击的图片下标___%ld",(long)index);
    NSLog(@"  %ld",(long)index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
