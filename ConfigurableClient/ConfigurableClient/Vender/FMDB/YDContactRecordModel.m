//
//  YDContactRecordModel.m
//  CRMSystemClient
//
//  Created by 赵东 on 2017/6/5.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "YDContactRecordModel.h"

@implementation YDContactRecordModel

- (instancetype)init {
    if (self = [super init]) {
        /** 设置选中状态的默认值 未选中 */
        self.isSelected = @"2";
    }
    return self;
}

@end
