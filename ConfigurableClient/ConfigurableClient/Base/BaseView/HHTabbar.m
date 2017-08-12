//
//  HHTabbar.m
//  CRMSystemClient
//
//  Created by tongda ju on 2017/5/10.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "HHTabbar.h"
#define kTabbarH 50
@interface HHTabbar()
{
    HHButton *_curButton;
}
@end
@implementation HHTabbar
- (instancetype)init{
    if (self = [super init]){
//        self.backgroundColor=HEXCOLOR(0xF9F9F9, 1);
        self.backgroundColor=kColorWhite;

    }
    return self;
}
-(void)setItems:(NSArray<UITabBarItem *> *)items{
    _items=items;
    [self setupTabbarAttribute];
}
- (void)setupTabbarAttribute{
    //    while (self.subviews.count) {
    //        UIView* child = self.subviews.lastObject;
    //        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
    //            [child removeFromSuperview];
    //        }
    //    }
    
    for (int i=0; i<self.items.count; i++) {
        HHTabbarButton *drbtn=[[HHTabbarButton alloc]init];
//        if (i==2) {
//            drbtn.onlyImage=YES;
//        }
        [drbtn setImage:self.items[i].image forState:UIControlStateNormal];
        [drbtn setImage:self.items[i].selectedImage forState:UIControlStateSelected];
        [drbtn setImage:self.items[i].selectedImage forState:UIControlStateHighlighted];
        
        [drbtn setTitle:self.items[i].title forState:UIControlStateNormal];
        
        [drbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [drbtn setTitleColor:HEXCOLOR(0x1a78e3, 1) forState:UIControlStateSelected];
        [drbtn setTitleColor:HEXCOLOR(0x1a78e3, 1) forState:UIControlStateHighlighted];
        
        drbtn.titleLabel.font=[UIFont systemFontOfSize:11];
        drbtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        //        [drbtn setFrame:CGRectMake(i*self.width/self.items.count, 5, self.width/self.items.count, kTabbarH-5)];
        //        drbtn.titleRect=CGRectMake(0, drbtn.height-20, drbtn.width, 20);
        drbtn.tag=i+100;
        [drbtn addTarget:self action:@selector(tabbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:drbtn];
        
    }
    
}
-(void)setSelectedItem:(UITabBarItem *)selectedItem{
    NSInteger idx=[self.items indexOfObject:selectedItem];
    _selectedIndex=idx;
    if (self.subviews.count>idx) {
        [self tabbarButtonAction:self.subviews[idx]];
        
    }
}
-(void)tabbarButtonAction:(HHButton *)btn{
    if (_curButton==btn) {// && btn.tag != 102
        return;
    }
    _selectedItem=self.items[btn.tag-100];
    _selectedIndex=btn.tag-100;
    //    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
    BOOL isChange=[self.delegate hhTabBar:self didSelectItem:self.items[btn.tag-100]];
    //        if (isChange==NO) {
    btn.selected=isChange;
    _curButton.selected= !isChange;
    //        }
    //    }
    //    btn.selected=YES;
    //    _curButton.selected=NO;
    if (isChange==YES) {
        _curButton=btn;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    for (int i=0 , k=0; i<self.subviews.count; i++) {
        HHButton *drbtn=self.subviews[i];
        if ([drbtn isKindOfClass:NSClassFromString(@"UIButton")]) {
            
            [drbtn setFrame:CGRectMake(k*self.frame.size.width/self.items.count, k==2?2:5, self.frame.size.width/self.items.count, kTabbarH-5)];
            //            drbtn.titleRect=CGRectMake(0, drbtn.height-20, drbtn.width, 20);
            
            k++;
        }
        
        
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
@implementation HHTabbarButton

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height-20, contentRect.size.width, 20);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect superRect=[super imageRectForContentRect:contentRect];
    if (_onlyImage) {
        return superRect;
    }
    
    return CGRectMake(contentRect.size.width/2-superRect.size.width/2, (contentRect.size.height-22)/2-superRect.size.height/2, superRect.size.width, superRect.size.height);
}



@end
