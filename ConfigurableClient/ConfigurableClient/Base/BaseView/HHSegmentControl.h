//
//  HHSegmentControl.h
//  LoginAPI
//
//  Created by LWJ on 16/8/25.
//  Copyright © 2016年 gejianmin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHSegmentControl;
@protocol HHSegmentControlDelegate <NSObject>

- (void)segmentControl:(HHSegmentControl *)control didSelectedAtIndex:(NSInteger)index;


@end

@interface HHSegmentControl : UIView

@property (nonatomic, assign) NSInteger selectedIndex;//选中index
@property (nonatomic, copy) NSArray <NSString *> *titles;//标题
@property (nonatomic, strong) UIColor *tintColor;//文字按钮颜色选中,滚动线
@property (nonatomic, strong) UIColor *titleColor;//文字按钮颜色正常

@property (nonatomic, strong) UIFont *titleFont;//字体
@property (nonatomic, strong) NSArray <NSNumber *>*enableIndex;
@property (nonatomic, assign) BOOL showVerticalSepLine;//显示垂直分割线
@property (nonatomic, assign) BOOL showHorizontalScrollLine;//显示水平滚动线

@property (nonatomic, weak) id<HHSegmentControlDelegate>delegate;

- (instancetype)initWithTitles:(NSArray <NSString *>*)titles;

@end
