//
//  ZDLabelScrollView.m
//  XYFrameWork
//
//  Created by 中企互联 on 16/11/19.
//  Copyright © 2016年 yuandong. All rights reserved.
//

#import "ZDLabelScrollView.h"

#import "NSString+Size.h"
@interface ZDLabelScrollView ()

@property (nonatomic,assign) BOOL isScrollEnable;
@property (nonatomic,assign) CGFloat width;
@end

@implementation ZDLabelScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.label = [[UILabel alloc]init];
    [self.label setFont:[UIFont systemFontOfSize:12.f]];
    [self.label setTextColor:kColorGray3];
    [self addSubview:self.label];
}

- (void)setText:(NSString *)text {
    [self setText:text font:[UIFont systemFontOfSize:12.f]];
    
}
- (void)setText:(NSString *)text font:(UIFont*)font  {
    _text = text;
    [self.label setFont:font];
    CGFloat width = [text widthWithFont:font constrainedToHeight:CGRectGetHeight(self.bounds)];
    CGFloat width_temp = [[NSString stringWithFormat:@"%@    ",text] widthWithFont:font constrainedToHeight:CGRectGetHeight(self.bounds)];
    self.width = width_temp;
    if (width <= CGRectGetWidth(self.bounds)) {
        [self.label setText:[NSString stringWithFormat:@"%@",text]];
        self.contentSize = self.frame.size;
        [self.label setFrame:self.bounds];
        _isScrollEnable = NO;
    }else{
        [self.label setText:[NSString stringWithFormat:@"%@    %@",text,text]];
        self.contentSize = CGSizeMake(width + width_temp, self.frame.size.height);
        [self.label setFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
        _isScrollEnable = YES;
        [self animation];
    }
}
- (void)animation {
    if (_isScrollEnable) {
#define XYWeakSelf __weak typeof(self) weakSelf = self;

        XYWeakSelf
        [UIView animateWithDuration:8 animations:^{
            weakSelf.contentOffset = CGPointMake(weakSelf.width, 0);
        } completion:^(BOOL finished) {
            weakSelf.contentOffset = CGPointMake(1, 0);
            [weakSelf animation];
        }];
    }
}
@end
