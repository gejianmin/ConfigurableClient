//
//  HHGloabConfig.h
//  HHAutoBusiness
//
//  Created by liuwenjie on 16/7/30.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#ifndef HHGloabConfig_h
#define HHGloabConfig_h

#define App ((AppDelegate*)[UIApplication sharedApplication].delegate)

#define HH_REGISTER_VALID //验证开关，注释掉就是不验证

#define kTabbarH 50

//log日志打印,包含该函数名,行数
#if DEBUG
#define HHLog(id, ...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define HHLog(id, ...)
#endif

//定义UIImage对象
#define ImageNamed(s) [UIImage imageNamed:s]


//屏幕的高度
#define HH_SCREEN_H [UIScreen mainScreen].bounds.size.height
//屏幕的宽带
#define HH_SCREEN_W [UIScreen mainScreen].bounds.size.width

//3.5英寸屏幕
#define HH_SCREEN_3_5 ([UIScreen mainScreen].bounds.size.height==480.f)

//4.0英寸屏幕
#define HH_SCREEN_4_0 ([UIScreen mainScreen].bounds.size.height==568.f)

//4.7英寸屏幕
#define HH_SCREEN_4_7 ([UIScreen mainScreen].bounds.size.height==667.f)

//5.5英寸屏幕
#define HH_SCREEN_5_5 ([UIScreen mainScreen].bounds.size.height==736.f)
//数组删除
static NSString  * const WORKCHANGE_ROW=@"CHANGE_ROW";//我的，全部，我的下属筛选数组
static NSString  * const WORKCHANGECREATTIME_ROW=@"CHANGECREATTIME_ROW";//时间排序数组
static NSString *  const WORKCHANGED_SELECTEDARR = @"CHANGED_SELECTEDARR";//筛选后数组
static NSString *  const WORKCHANGED_LEFTROW = @"CHANGED_LEFTROW";//左边筛选项
static NSString  * const WORKCHANGED_RIGHTROW=@"CHANGED_RIGHTROW";//右边筛选项
// 阿里云图片上传网址
static NSString * const ALiYunPath = @"http://file.yunpaas.cn/";
#define IMAGERURL(imageUrlPath) [imageUrlPath hasPrefix:@"http"] ? imageUrlPath : [NSString stringWithFormat:@"%@%@",ALiYunPath,imageUrlPath]
// 阿里云图片模块地址
static NSString * const CRMCluePath = @"clue";/*!< 线索*/
static NSString * const CRMCustomerPath = @"customer";/*!< 客户*/
static NSString * const CRMBusinessPath = @"business_opportunity";/*!< 商机*/
static NSString * const CRMContractPath = @"contract";/*!< 合同*/
static NSString * const CRMContactsPath = @"contacts";/*!< 联系人**/
static NSString * const CRMTraceRecordPath = @"traceRecord";/*!< 跟进记录*/
static NSString * const CRMProductPath = @"product";/*!< 产品*/
static NSString * const CRMPersonPath = @"person";/*!< 个人中心*/

#define MPWidthScale (((AppDelegate *)[UIApplication sharedApplication].delegate).sizeScaleX)

#define MPHeightScale (((AppDelegate *)[UIApplication sharedApplication].delegate).sizeScaleY)


#endif /* HHGloabConfig_h */
