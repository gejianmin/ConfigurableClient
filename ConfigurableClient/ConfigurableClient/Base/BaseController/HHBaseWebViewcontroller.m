//
//  HHBaseWebViewcontroller.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/15.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "HHBaseWebViewcontroller.h"

@interface HHBaseWebViewcontroller () {
    
}
@property (nonatomic, strong) UIWebView * webView;



@end
@implementation HHBaseWebViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kColorBlue];
    
}
-(void)setupUI{
    
}
//- (void)setUrl:(NSString *)url
//{
//    _url = url;
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
//    
//}
//
//- (UIWebView *)webView
//{
//    if (!_webView) {
//        _webView = [[UIWebView alloc] init];
//        _webView.scalesPageToFit = YES;
//        [self.view addSubview:_webView];
//        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
//        }];
//    }
//    //清楚cookies
//    [_webView clearCookies];
//    return _webView;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
