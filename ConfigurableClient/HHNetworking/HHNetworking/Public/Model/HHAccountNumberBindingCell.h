//
//  HHAccountNumberBindingCell.h
//  HHAutoBusiness
//
//  Created by 葛建民 on 16/8/5.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSettedManageModel.h"
@interface HHAccountNumberBindingCell : UITableViewCell

@property (nonatomic, strong)UILabel *bankNameLable;
@property (nonatomic, strong)UILabel *bankIdLabel;
@property (nonatomic, strong)UIImageView *bankbgImageView;
@property (nonatomic,strong)HHSettedManageModel *settledManageModel;


@end
