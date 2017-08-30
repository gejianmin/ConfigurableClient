//
//  MPMineHeaderView.m
//  MPSystemClient
//
//  Created by tongda ju on 2017/8/10.
//  Copyright © 2017年 JianMin Ge. All rights reserved.
//

#import "MPMineHeaderView.h"
#import "UIView+Shadow.h"
@interface MPMineHeaderView (){
    
}

@end

@implementation MPMineHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorWhite;
        [self addSubview:self.bgImageView];
        [self addSubview:self.headerView];
        [self addSubview:self.titleLbl];
//        [self addSubview:self.companyChenged];
        [self addSubview:self.iconView];
        [self.headerView addSubview:self.nameLbl];
        [self.headerView addSubview:self.companyLbl];

        
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(20);
            make.centerX.equalTo(self.mas_centerX);
        }];
//        [self.companyChenged mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(-15);
//            make.centerY.equalTo(self.titleLbl.mas_centerY);
//
//        }];

        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(65*MPWidthScale));
            make.height.equalTo(@(65*MPWidthScale));
            make.top.equalTo(self.titleLbl.mas_bottom).offset(24.0*MPHeightScale);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_top).offset(20.5*MPHeightScale);
            make.width.equalTo(@(324*MPWidthScale));
            make.height.equalTo(@(165*MPWidthScale));
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_bottom).offset(15);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.companyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLbl.mas_bottom).offset(15);

            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@(218.5*MPHeightScale));
        }];
    }
    return  self;
}
-(UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"Mine_view_bg")];
    }
    return _bgImageView;
}
-(UIImageView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIImageView alloc]initWithImage:ImageNamed(@"Mine_headerView_bg")];
    }
    return _headerView;
}
-(UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc]initWithImage:ImageNamed(@"Mine_icon")];
        [_iconView makeCornerWithCornerRadius:32.5*MPWidthScale borderWidth:0 borderColor:nil];
    }
    return _iconView;
}
-(CustomLab *)titleLbl{
    if (_titleLbl == nil) {
        _titleLbl =[[CustomLab alloc]initWithFrame:CGRectZero font:18.0 aligment:NSTextAlignmentCenter text:@"Setting" textcolor:kColorWhite];
        _titleLbl.font = kFont18_b;
    }
    return _titleLbl;
}
-(CustomBtn *)companyChenged{
    if (_companyChenged == nil) {
        _companyChenged = [[CustomBtn alloc]initWithFrame:CGRectZero Tag:0 Title:@"切换身份" backgroundColor:[UIColor clearColor] TitleTextColor:kColorWhite Font:16.0 Image:nil];
    }
    return _companyChenged;
}
-(CustomLab *)nameLbl{
    if (_nameLbl == nil) {
        _nameLbl =[[CustomLab alloc]initWithFrame:CGRectZero font:18.0 aligment:NSTextAlignmentCenter text:@"" textcolor:kColorGray1];
    }
    return _nameLbl;
}

-(CustomLab *)companyLbl{
    if (_companyLbl == nil) {
        _companyLbl =[[CustomLab alloc]initWithFrame:CGRectZero font:15.0 aligment:NSTextAlignmentCenter text:@"Jiangsu The last 3 - V1.0" textcolor:kColorGray1];
    }
    return _companyLbl;
}
@end
