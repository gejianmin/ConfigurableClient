//
//  HHAccountNumberBindingCell.m
//  HHAutoBusiness
//
//  Created by 葛建民 on 16/8/5.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHAccountNumberBindingCell.h"

@implementation HHAccountNumberBindingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUI];
    }
    return self;
}
-(void)setUI{

    UIView * view = [[UIView alloc]init];
    view.backgroundColor =  RGBACOLOR(238.0,238.0,238.0,1);
    [self.contentView addSubview:view];
    
[view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(7*[ScreenAdaptation adapterMultipleByWidth]);
        make.right.equalTo(self.contentView.mas_right).offset(-7*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.height.equalTo(@(100*[ScreenAdaptation adapterMultipleByWidth]));

        
    }];
    self.bankbgImageView = [[UIImageView alloc]init];
    self.bankbgImageView.layer.cornerRadius = 5;//设置那个圆角的有多圆
//    self.bankbgImageView.layer.borderWidth = 0;//设置边框的宽度，当然可以不要
//    self.bankbgImageView.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
    self.bankbgImageView.layer.masksToBounds = YES;
    //self.bankbgImageView.image = [UIImage imageNamed:@"银行"];
    [view addSubview:self.bankbgImageView];
    [self.bankbgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(7*[ScreenAdaptation adapterMultipleByWidth]);
        make.right.equalTo(self.contentView.mas_right).offset(-7*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.height.equalTo(@(100*[ScreenAdaptation adapterMultipleByWidth]));
        
    }];
   
    self.bankNameLable = [[UILabel alloc]init];
    self.bankNameLable.text = @"中国农业银行";
    self.bankNameLable.textAlignment = NSTextAlignmentLeft;
    self.bankNameLable.textColor = [UIColor whiteColor];
    self.bankNameLable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.bankbgImageView addSubview:self.bankNameLable];
    [self.bankNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bankbgImageView.mas_left).offset(13*[ScreenAdaptation adapterMultipleByWidth]);
        make.right.equalTo(self.bankbgImageView.mas_right).offset(-15*[ScreenAdaptation adapterMultipleByWidth]);
        make.top.equalTo(self.bankbgImageView.mas_top).offset(17*[ScreenAdaptation adapterMultipleByWidth]);

        
    }];
    self.bankIdLabel = [[UILabel alloc]init];
    self.bankIdLabel.text = @"****************4563";
    self.bankIdLabel.textAlignment = NSTextAlignmentRight;
    self.bankIdLabel.textColor = [UIColor whiteColor];
    self.bankIdLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15*[ScreenAdaptation adapterMultipleByWidth]];
    [self.bankbgImageView addSubview:self.bankIdLabel];
    [self.bankIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //make.left.equalTo(self.bankbgImageView.mas_left).offset(13);
        make.right.equalTo(self.bankbgImageView.mas_right).offset(-13*[ScreenAdaptation adapterMultipleByWidth]);
        make.bottom.equalTo(self.bankbgImageView.mas_bottom).offset(-12.5*[ScreenAdaptation adapterMultipleByWidth]);
        make.height.equalTo(@(24*[ScreenAdaptation adapterMultipleByWidth]));
        
        
    }];



}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
