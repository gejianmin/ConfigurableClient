//
//  HHSettledManageView.h
//  HHAutoBusiness
//
//  Created by 葛建民 on 16/8/4.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSettedManageModel.h"
@protocol JumpToAddbankControllerVCDelegate <NSObject>

- (void)JumpToAddbankControllerVCDelegate;
- (void)JumpToNotSetlledControllerVCDelegate;
- (void)JumpToSettledControllerVCDelegate;

@end

@interface HHSettledManageView : UIView

- (instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,weak)id<JumpToAddbankControllerVCDelegate>bankDelegate;
@property(nonatomic,strong)HHSettedManageModel * settedManageModel;


@end
