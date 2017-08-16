//
//  ZDLabelScrollView.h
//  XYFrameWork
//
//  Created by 中企互联 on 16/11/19.
//  Copyright © 2016年 yuandong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDLabelScrollView : UIScrollView

@property (nonatomic,strong) UILabel * label;
@property (nonatomic,strong) NSString * text;
- (void)setText:(NSString *)text font:(UIFont*)font;

@end
