//
//  HomeCell.m
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/15.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLbl];
        [self.contentView addSubview:self.dateLbl];
        [self.contentView addSubview:self.contentLbl];
        [self.contentView addSubview:self.iconIma];
        [self.iconIma mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.equalTo(@15);
            make.height.equalTo(@70);
            make.width.equalTo(@105);

            
        }];
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@15);
            make.left.equalTo(self.iconIma.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.titleLbl.mas_bottom).offset(7);
            make.left.equalTo(self.iconIma.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        [self.dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentLbl.mas_bottom).offset(7);
//            make.left.equalTo(self.imageView.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];


    }
    return self;

}
-(void)setHeaderModel:(HeaderModel *)headerModel{
    _headerModel = headerModel;
    [self.iconIma sd_setImageWithURL:[NSURL URLWithString:_headerModel.image] placeholderImage:ImageNamed(@"")];
    self.titleLbl.text = _headerModel.title;
    self.contentLbl.text = _headerModel.Summary;
    self.dateLbl.text = _headerModel.date;

}
-(CustomLab *)titleLbl{
    if (_titleLbl == nil) {
        _titleLbl =[[CustomLab alloc]initWithFrame:CGRectZero font:16.0 aligment:NSTextAlignmentLeft text:@"" textcolor:[UIColor blackColor]];
        _titleLbl.numberOfLines = 1;
    }
    return _titleLbl;
}
-(CustomLab *)contentLbl{
    if (_contentLbl == nil) {
        _contentLbl =[[CustomLab alloc]initWithFrame:CGRectZero font:15.0 aligment:NSTextAlignmentLeft text:@"" textcolor:kColorGray6];
        _contentLbl.numberOfLines = 2;

    }
    return _contentLbl;
}
-(CustomLab *)dateLbl{
    if (_dateLbl == nil) {
        _dateLbl =[[CustomLab alloc]initWithFrame:CGRectZero font:15.0 aligment:NSTextAlignmentLeft text:@"" textcolor:kColorGray6];
    }
    return _dateLbl;
}
-(UIImageView *)iconIma{
    if (_iconIma == nil) {
        _iconIma =[[UIImageView alloc]initWithImage:ImageNamed(@"clue_rightarrow")];
    }
    return _iconIma;
}
+(CGFloat)cellHeight{
    
    return 105.f;

}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
