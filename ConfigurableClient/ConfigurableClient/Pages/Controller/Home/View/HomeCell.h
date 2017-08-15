//
//  HomeCell.h
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/15.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderModel.h"
@interface HomeCell : UITableViewCell

@property (nonatomic, strong) CustomLab * titleLbl;
@property (nonatomic, strong) CustomLab * contentLbl;
@property (nonatomic, strong) CustomLab * dateLbl;
@property (nonatomic, strong) UIImageView * iconIma;
@property (nonatomic, strong) HeaderModel * headerModel;

+(CGFloat)cellHeight;


@end
