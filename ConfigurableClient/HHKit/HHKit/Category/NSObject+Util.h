//
//  NSObject+Util.h
//  HuanYouWang
//
//  Created by liuwenjie on 15/5/15.
//  Copyright (c) 2015年 cc.huanyouwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Util)


/**
 延时做一件事

 @param timer 延时几秒
 @param task task
 */
-(void)delay:(NSTimeInterval)timer task:(dispatch_block_t) task;


/**
 快速归档

 @param aCoder aCoder
 */
- (void)fastEncode:(NSCoder *)aCoder;

/**
 快速接档

 @param aDecoder aDecoder
 */
- (void)fastDecode:(NSCoder *)aDecoder;

@end
