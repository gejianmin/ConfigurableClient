//
//  AddRemindersView.m
//  CRMSystemClient
//
//  Created by tongda ju on 2017/6/6.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "AddRemindersView.h"
@interface AddRemindersView()<UITextViewDelegate>
@property(nonatomic,strong)UILabel * placeholderLabel;

@end
@implementation AddRemindersView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        
    }

    return self;

}
-(void)setupUI{
    [self addSubview:self.borderView];
    [self.borderView addSubview:self.contentView];
    [self.contentView addSubview:self.placeholderLabel];
    [self.borderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.equalTo(@210.5);
    }];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@210.5);
    }];
    [self.placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@5);
        make.left.equalTo(self.contentView.mas_left).offset(5);
    }];


}
-(UILabel *)placeholderLabel{
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.font = kFont13;
        _placeholderLabel.numberOfLines = 1;
        _placeholderLabel.textColor = kColorGray6;
        _placeholderLabel.text = @"Please enter your feedback or suggestions";
        [_placeholderLabel setEnabled:NO];
    }
    return _placeholderLabel;
}
-(UITextView *)contentView{
    if (_contentView ==nil) {
        _contentView = [[UITextView alloc]init];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.delegate = self;
        
    }
    return _contentView;
}

-(UIView *)borderView{
    if (_borderView == nil) {
        _borderView =[[UIView alloc]init];
        _borderView.layer.borderColor =COLORHEX(0xE8E8E8).CGColor;
        _borderView.layer.borderWidth = 0.5f;
        _borderView.layer.masksToBounds = YES;
    }
    return _borderView;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{    if (![text isEqualToString:@""])
{
    _placeholderLabel.hidden = YES;
}
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length >= 250) {
        
        textView.text = [textView.text substringToIndex:250];
        if ([self.delegate respondsToSelector:@selector(contentTextViewDidchenged)]) {
            [self.delegate contentTextViewDidchenged];
        }
    }
}
@end
