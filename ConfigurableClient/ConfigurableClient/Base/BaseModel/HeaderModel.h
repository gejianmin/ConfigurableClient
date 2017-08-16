//
//  HeaderModel.h
//  ConfigurableClient
//
//  Created by tongda ju on 2017/8/15.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject

@property (nonatomic, strong) NSString * Summary;/*!< 内容*/
@property (nonatomic, strong) NSString * category;/*!< 类别*/
@property (nonatomic, strong) NSString * date;/*!< 时间*/
@property (nonatomic, strong) NSString * newsId;/*!< ID*/
@property (nonatomic, strong) NSString * title;/*!< 标题*/
@property (nonatomic, strong) NSString * image;/*!< 图片*/
@property (nonatomic, strong) NSString * url;/*!< 链接*/
@property (nonatomic, strong) NSArray * images;/*!< 图片数组*/
@property (nonatomic, strong) NSString * caption;/*!< 简言*/
@property (nonatomic, strong) NSString * content;/*!< 内容*/
 



@end
