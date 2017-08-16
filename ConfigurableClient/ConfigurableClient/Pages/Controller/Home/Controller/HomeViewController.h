//
//  HomeViewController.h
//  ConfigurableClient
//
//  Created by tongda ju on 2017/7/5.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "CRMBaseViewController.h"

typedef NS_ENUM(NSUInteger, NewsCategoryType) {
    kNewsCategoryTypeHeadline = 0,
    kNewsCategoryTypeBusiness = 2,
    kNewsCategoryTypeWorld = 3,
    kNewsCategoryTypeSport = 6,
    kNewsCategoryTypeFeature = 7,
};
@interface HomeViewController : CRMBaseViewController

@property (nonatomic, assign) NewsCategoryType  newsCategoryType;

@end
