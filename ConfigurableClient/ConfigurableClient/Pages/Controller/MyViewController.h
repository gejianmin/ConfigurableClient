//
//  MyViewController.h
//  ConfigurableClient
//
//  Created by tongda ju on 2017/7/27.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

 
#import "CRMBaseViewController.h"

@interface MyViewController : CRMBaseViewController

@end

@interface MPUserItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, assign) NSInteger badgeValue;
@property (nonatomic, assign) BOOL isNeedIDAuth;
@property (nonatomic, assign) Class pushControllerClass;


@end
