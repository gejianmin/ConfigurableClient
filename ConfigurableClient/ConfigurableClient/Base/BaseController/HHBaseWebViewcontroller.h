//
//  HHBaseWebViewcontroller.h
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/15.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "CRMBaseViewController.h"

@class HeaderModel;
@interface HHBaseWebViewcontroller : CRMBaseViewController

@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) HeaderModel *dataModel;
@property (nonatomic, strong) HeaderModel *dataModelTmp;

@end



