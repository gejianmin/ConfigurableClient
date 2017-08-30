//
//  AddRemindersView.h
//  CRMSystemClient
//
//  Created by tongda ju on 2017/6/6.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddRemindersViewDelegate <NSObject>
@optional

- (void)contentTextViewDidchenged;


@end
@interface AddRemindersView : UIView

@property (nonatomic, strong) UITextView *contentView;
@property(nonatomic,strong)UIView * borderView;

@property(nonatomic,weak)id <AddRemindersViewDelegate> delegate;

@end
