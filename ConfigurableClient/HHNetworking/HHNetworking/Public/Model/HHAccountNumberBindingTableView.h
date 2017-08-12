//
//  HHAccountNumberBindingTableView.h
//  HHAutoBusiness
//
//  Created by 葛建民 on 16/8/5.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSettedManageModel.h"
@protocol JumpToAddbankCardControllerVCDelegate <NSObject>

- (void)JumpToAddbankCardControllerVCDelegate;

@end
@interface HHAccountNumberBindingTableView : UITableView


@property (nonatomic,strong)NSMutableArray *dataSoucreArray;
@property (nonatomic,strong)HHSettedManageModel *settledManageModel;

@property (nonatomic,weak)id<JumpToAddbankCardControllerVCDelegate>bankCardDelegate;


@end
