//
//  HHSegmentControl.m
//  LoginAPI
//
//  Created by LWJ on 16/8/25.
//  Copyright © 2016年 gejianmin. All rights reserved.
//

#import "HHSegmentControl.h"
@interface HHSegmentControl()
{
    UIButton *_curButton;
    
    
}
@property (nonatomic, strong) UIView *horLine;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *verLines;

@end
@implementation HHSegmentControl
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles{
    if (self=[super init]) {
        _titles=titles;
        self.backgroundColor=[UIColor whiteColor];
        _tintColor=kColorMianRed;
        _titleColor=kColorGray1;
        _showVerticalSepLine=YES;
        _showHorizontalScrollLine=YES;
        [self setupButtons];
        
        self.selectedIndex=0;
    }
    return self;
}
- (void)setTitles:(NSArray<NSString *> *)titles{
    _titles=[titles copy];
    
}
-(NSMutableArray *)buttons{
    if (_buttons==nil) {
        _buttons=[NSMutableArray array];
    }
    return  _buttons;
}
-(NSMutableArray *)verLines{
    if (_verLines==nil) {
        _verLines=[NSMutableArray array];
    }
    return _verLines;
}
-(UIView *)horLine{
    if (_horLine==nil) {
        _horLine=[[UIView alloc] init];
        _horLine.backgroundColor=kColorMianRed;
    }
    return _horLine;
}
-(void)setTintColor:(UIColor *)tintColor{
    _tintColor=tintColor;
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitleColor:tintColor forState:UIControlStateSelected];
    }];
    self.horLine.backgroundColor=tintColor;
}
-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor=titleColor;
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitleColor:titleColor forState:UIControlStateNormal];
    }];
}
-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont=titleFont;
    
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex=selectedIndex;
    UIButton *btn=_buttons[selectedIndex];
    if (btn==_curButton) {
        return;
    }
    btn.selected=YES;
    _curButton.selected=NO;
    _curButton=btn;
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.horLine.center=CGPointMake(btn.center.x, self.horLine.center.y);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setupButtons{
    for (int i=0; i<self.titles.count; i++) {
        UIButton *btn=[[UIButton alloc] init];
        
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.tintColor forState:UIControlStateSelected];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];

        btn.tag=i;
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=kFont15;
        [self addSubview:btn];
        [self.buttons addObject:btn];
        
        
        if (i<self.titles.count-1) {
            UIView *line=[[UIView alloc] init];
            line.backgroundColor=HH_LINE_COLOR;
            [self addSubview:line];
            [self.verLines addObject:line];
        }
        
    }
    [self addSubview:self.horLine];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width=self.width/self.buttons.count;
    
    for (int i=0; i<self.buttons.count; i++) {
        UIButton *btn=self.buttons[i];
        btn.frame=CGRectMake(width*i, 0, width-0.5, self.height);
        if (_selectedIndex==i) {
            self.horLine.frame=CGRectMake(btn.minX, self.height-2, btn.width, 2);
            self.horLine.hidden = !self.showHorizontalScrollLine;
        }

        if (i<self.verLines.count) {
            UIView *line=self.verLines[i];
            line.frame=CGRectMake(btn.maxX, 10, 0.5, self.height-20);
            line.hidden = !self.showVerticalSepLine;
        }
    }
    
    
}
- (void)buttonAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(segmentControl:didSelectedAtIndex:)]) {
        [self.delegate segmentControl:self didSelectedAtIndex:sender.tag];
    }
    self.selectedIndex=sender.tag;
}
@end
