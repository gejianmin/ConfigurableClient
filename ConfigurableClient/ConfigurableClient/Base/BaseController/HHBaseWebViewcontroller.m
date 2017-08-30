//
//  HHBaseWebViewcontroller.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/15.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "HHBaseWebViewcontroller.h"

#import "UIWebView+load.h"
#import "HeaderModel.h"
#import "NSDate+ZD.h"

#import "ZDLabelScrollView.h"
#import "YDFMDB.h"

@interface HHBaseWebViewcontroller () {
    
}

@property (nonatomic, strong) UIWebView * webView;



@end

@implementation HHBaseWebViewcontroller


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kColorBlue];
    
}

- (void)right {
    if ([[YDFMDB manager] addDataWithModel:self.dataModel]) {
        
        [self showToastHUD:@"Collection success" complete:nil];
    }
}
-(void)setupUI{
    
}
- (void)reloadDataTitle:(NSString *)name {
    ZDLabelScrollView *autoScrollLabel = [[ZDLabelScrollView alloc]initWithFrame:CGRectMake(HH_SCREEN_W * 0.5 /3.0f , 0, HH_SCREEN_W * 2 /3.0f, 44.f)];
    autoScrollLabel.label.textAlignment  = NSTextAlignmentCenter;
    [autoScrollLabel.label setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView = autoScrollLabel;
 
    [autoScrollLabel setText:name font:kFont16];
}
- (void)setUrl:(NSString *)url
{
    _url = url;
//    if (url.length == 0) {
//        return;
//    }
//    if ([url hasPrefix:@"http"]) {
//        [self.webView loadURL:url];
//    } else {
//        @try {
//            [self.webView loadLocalWord:url];
//        } @catch (NSException *exception) {
//            NSLog(@"加载本地web异常");
//        } @finally {
//            
//        }
//        
//    }
    
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, HH_SCREEN_W, HH_SCREEN_H-64)];
        _webView.scalesPageToFit = YES;
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    //清楚cookies
    [_webView clearCookies];
    return _webView;
}

- (void)setDataModel:(HeaderModel *)dataModel {
    _dataModel = dataModel;
    [self reloadDataTitle:dataModel.title];
    [self createScrollView:dataModel.images title:dataModel.title time:dataModel.date content:dataModel.content caption:dataModel.caption];

}

- (void)setDataModelTmp:(HeaderModel *)dataModelTmp {
    _dataModelTmp = dataModelTmp;
    if ([[YDFMDB manager] isExistWithNewsID:dataModelTmp.newsId]) {
        
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"collected" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.rightBarButtonItem = item;
    }else {
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"collect" style:UIBarButtonItemStylePlain target:self action:@selector(right)];
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)createScrollView:(NSArray *)arr title:(NSString *)title time:(NSString *)time content:(NSString *)content caption:(NSString *)caption{
 
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = CGRectMake(0, 64, HH_SCREEN_W, HH_SCREEN_H - 64);
    
    scrollView.userInteractionEnabled=YES;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:scrollView];
    
    MyLinearLayout *ll_all = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    ll_all.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    ll_all.myLeftMargin = 0;
    ll_all.myRightMargin = 0; //这里设置线性布局的左右边距都是0表示线性布局的宽度和scrollView保持一致
    
    [scrollView  addSubview:ll_all];
    
    
    MyLinearLayout * productInfoLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    
    productInfoLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    productInfoLayout.myLeftMargin = 0;
    productInfoLayout.myRightMargin = 0;
    productInfoLayout.wrapContentHeight = YES;
//    productInfoLayout.backgroundColor = UICOLOR(0xe7e7e7);
    [ll_all addSubview:productInfoLayout];
//    productInfoLayout.userInteractionEnabled = YES;
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleLatestAnnouceDetail:)];
////    [productInfoLayout addGestureRecognizer:tap];
    
    UILabel *goodsName = [UILabel new];
    goodsName.text = title;
    [goodsName sizeToFit];
    goodsName.myLeftMargin = goodsName.myRightMargin = 0;
    [goodsName setFont:[UIFont systemFontOfSize:20.f]];
//    [goodsName setTextColor:UICOLOR(0x666666)];
    [productInfoLayout addSubview:goodsName];
    //    goodsName.attributedText=[richTextShowAlerStr attributeFirsttStr:@"商品名称：" colorchooseStr:self.sunSingDetailModel.goods_name thirdStr:nil titleColor:QBDBRGBCORLOR(75, 145, 253)];
    goodsName.numberOfLines = 0;
    goodsName.flexedHeight  = YES;
    
    UILabel *buy_count = [UILabel new]; 
    
    buy_count.text  = [NSString stringWithFormat:@"updated:%@",time];
    [buy_count sizeToFit];
    buy_count.myTopMargin = 5;
    [buy_count setFont:[UIFont systemFontOfSize:13.f]];
//    [buy_count setTextColor:UICOLOR(0x666666)];
    [productInfoLayout addSubview:buy_count];
//    buy_count.attributedText=[richTextShowAlerStr attributeFirsttStr:@"本期参与：" colorchooseStr:self.sunSingDetailModel.buy_count thirdStr:@"人次" titleColor:QHDBGLOBALREDCORLOR];
    
    
    MyLinearLayout *ll = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    ll.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    ll.myLeftMargin = 0;
    ll.myRightMargin = 0; //这里设置线性布局的左右边距都是0表示线性布局的宽度和scrollView保持一致
    
    NSArray *imageArr = arr;
    for (NSInteger i = 0; i < imageArr.count; i++) {
        
        NSString * url = imageArr[i];
        
        UIImage *normalImage = [UIImage imageNamed:@"nullData_image"];
        float bl = normalImage.size.width/normalImage.size.height;
        float normalHeight = (HH_SCREEN_W-20)/bl;
        UIImageView *imgView = [[UIImageView alloc] init];
        [imgView setImage:normalImage];
        imgView.myTopMargin = 10;
        imgView.myLeftMargin = 0;
        imgView.myRightMargin = 0;
        imgView.height = normalHeight;
        [ll addSubview:imgView];
        
        NSString * urlStr = nil;
        if ([url hasPrefix:@"http:"]) {
            urlStr = url;
        }else{
//            urlStr = [NSString stringWithFormat:@"%@%@",imagePre,url];
        }
        
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        __weak typeof(imgView) weakImgView = imgView;
        
        [imgView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"nullData_image"] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            
            [weakImgView setImage:image];
            CGSize size = image.size;
            CGFloat radio = size.height/size.width;
            weakImgView.height = (HH_SCREEN_W -20) * radio;
            
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
        
    }
    
    [ll_all  addSubview:ll];
    
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.text = caption;
    [contentLabel sizeToFit];
    contentLabel.myLeftMargin = contentLabel.myRightMargin = 10;
    [contentLabel setFont:[UIFont systemFontOfSize:13.f]];
    //    [goodsName setTextColor:UICOLOR(0x666666)];
    [ll_all addSubview:contentLabel];
    contentLabel.numberOfLines = 0;
    contentLabel.flexedHeight  = YES;

    
    UILabel *contentLabel1 = [UILabel new];
    contentLabel1.text = content;
    [contentLabel1 sizeToFit];
    contentLabel1.numberOfLines = 0;
    contentLabel1.flexedHeight  = YES;

    contentLabel1.myLeftMargin = contentLabel1.myRightMargin = 10;
    [contentLabel setFont:[UIFont systemFontOfSize:13.f]];
    //    [goodsName setTextColor:UICOLOR(0x666666)];
    [ll_all addSubview:contentLabel1];
    
}

@end
