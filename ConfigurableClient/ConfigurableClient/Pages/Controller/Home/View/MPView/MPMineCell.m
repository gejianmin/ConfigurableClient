//
//  MPMineCell.m
//  MPSystemClient
//
//  Created by tongda ju on 2017/8/10.
//  Copyright © 2017年 JianMin Ge. All rights reserved.
//

#import "MPMineCell.h"

#define titleFont  HH_SCREEN_W > 375?17:15
#define descriptionFont  HH_SCREEN_W > 375?14:12

@interface MPMineCell ()

@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation MPMineCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:kColorWhite];
        [self setContentView];

    }
    return self;
}

- (void)setContentView {
    
    UIButton *iconBtn = [[UIButton alloc]init];
    iconBtn.userInteractionEnabled = NO;
    self.iconBtn = iconBtn;
    [self.contentView addSubview:iconBtn];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:titleFont];
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.height.equalTo(@22);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(iconBtn.mas_right).offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];

}
- (void)setIconBtnImage:(NSString *)iconBtnImage {
    
    _iconBtnImage = iconBtnImage;
    [self.iconBtn setBackgroundImage:[UIImage imageNamed:iconBtnImage] forState:UIControlStateNormal];
}
- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
