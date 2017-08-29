//
//  HHColorConfig.h
//  HHAutoBusiness
//
//  Created by liuwenjie on 16/7/30.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#ifndef HHColorConfig_h
#define HHColorConfig_h
#import <UIKit/UIKit.h>

//alpha通道RGB颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//alpha通道十六进制颜色
#define HEXCOLOR(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:(a)]
//通道十六进制颜色
#define COLORHEX(hex) [UIColor colorWithRed:((float)(((hex) & 0xFF0000) >> 16)) / 255.0 green:((float)(((hex) & 0xFF00) >> 8))/255.0 blue:((float)((hex) & 0xFF)) / 255.0 alpha:1.0]
//主题色
#define HH_MAIN_THEME_COLOR       RGBACOLOR(25, 116, 231,1)
//主背景色
#define HH_MAIN_BG_COLOR          RGBACOLOR(249, 249, 249,1)
//通用线条颜色
#define HH_LINE_COLOR             RGBACOLOR(211, 212, 212,1)
//通用线条颜色 #F2F2F2
#define HH_VIEW_BG_COLOR          RGBACOLOR(242, 242, 242,1)
//通用线条颜色 #E8E8E8
#define HH_VIEW_BG_COLOR_2          RGBACOLOR(232, 232, 232,1)




/////////////////////////////////////////////////////////////////////////////////////////常用颜色
//////////////////////////////////
#define kColorMianBlue              [UIColor colorWithRed:26/255.0 green:120/255.0 blue:227/255.0 alpha:1]//#1a78e3 主题蓝
#define kColorMianRed              [UIColor colorWithRed:237/255.0 green:64/255.0 blue:64/255.0 alpha:1]//#ed4040 主题红


#define kColorBlue              [UIColor colorWithRed:50/255.0 green:168/255.0 blue:240/255.0 alpha:1]
#define kColorLightBlue         [UIColor colorWithRed:50/255.0 green:168/255.0 blue:240/255.0 alpha:0.5]
#define kColorBlueH             [UIColor colorWithRed:9/255.0 green:104/255.0 blue:184/255.0 alpha:1]
#define kColorBlueD             [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1]
#define kColorOrange            [UIColor colorWithRed:255/255.0 green:132/255.0 blue:0/255.0 alpha:1]
#define kColorOrange1            [UIColor colorWithRed:255/255.0 green:133/255.0 blue:14/255.0 alpha:1]
#define kColorOrange2           [UIColor colorWithRed:255/255.0 green:148/255.0 blue:0/255.0 alpha:1]//ff9400
#define kColorGreen             [UIColor colorWithRed:76/255.0 green:217/255.0 blue:100/255.0 alpha:1]
#define kColorLine1             [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1]
#define kColorLine2             [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1]
#define kColorGray              [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1]
#define kColorGray1             [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]//#333333
#define kColorGray7             [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1]//#4a4a4a
#define kColorGray2             [UIColor colorWithRed:141/255.0 green:142/255.0 blue:144/255.0 alpha:1]
#define kColorGray6             [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]//#9b9b9b(#999999)
#define kColorGray3             [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1]
#define kColorGray4             [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]
#define kColorGray5             [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]//f2f2f2
#define kColorRed               [UIColor colorWithRed:255/255.0 green:74/255.0 blue:74/255.0 alpha:1]
#define kColorRedH              [UIColor colorWithRed:210/255.0 green:58/255.0 blue:58/255.0 alpha:1]
#define kColorWhite             [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]


#define WORKPERMISSIONCODEDATA @"workpermissioncode" //权限列表存储key


typedef NS_ENUM(NSUInteger, ZDWorkPermissionType) {
    ZDWorkPermissonTypeClue = 0,//线索
    ZDWorkPermissonTypeCustomer,//客户
    ZDWorkPermissonTypeBusiness,//商机
    ZDWorkPermissonTypeContract,//合同
    ZDWorkPermissonTypeContactPerson,//联系人
    ZDWorkPermissonTypeCustomerPublic,//客户公海
    ZDWorkPermissonType,//跟踪记录
    ZDWorkPermissonTypeAddressBook,//通讯录
    ZDWorkPermissonTypeCardIdentificate,//名片识别
};

//线索
static NSString  * const ZDWorkModulePermissionTypeClueAdd = @"clue:add";//新增线索
static NSString  * const ZDWorkModulePermissionTypeClueView = @"clue:view";//查看线索
static NSString  * const ZDWorkModulePermissionTypeClueEdit = @"clue:edit";//编辑线索
static NSString  * const ZDWorkModulePermissionTypeClueDelete = @"clue:delete";//删除线索
static NSString  * const ZDWorkModulePermissionTypeClueTransfer = @"clue:transfer";//转移他人
static NSString  * const ZDWorkModulePermissionTypeClueBecome = @"clue:become";//转成客户

//客户
static NSString  * const ZDWorkModulePermissionTypeCustomerView = @"customer:view";//查看客户
static NSString  * const ZDWorkModulePermissionTypeCustomerAdd = @"customer:add";//新增客户
static NSString  * const ZDWorkModulePermissionTypeCustomerEdit = @"customer:edit";//编辑客户
static NSString  * const ZDWorkModulePermissionTypeCustomerDelete = @"customer:delete";//删除客户
static NSString  * const ZDWorkModulePermissionTypeCustomerTransfer = @"customer:transfer";//转移他人
//static NSString  * const ZDWorkModulePermissionTypeCustomerTransferOpen = @"customer:transferOpen";//转至公海

//销售机会
static NSString  * const ZDWorkModulePermissionTypeOpportunityView = @"opportunity:view";//查看销售机会
static NSString  * const ZDWorkModulePermissionTypeOpportunityAdd = @"opportunity:add";//新增销售机会
static NSString  * const ZDWorkModulePermissionTypeOpportunityEdit = @"opportunity:edit";//编辑销售机会
static NSString  * const ZDWorkModulePermissionTypeOpportunityDelete = @"opportunity:delete";//删除销售机会
static NSString  * const ZDWorkModulePermissionTypeOpportunityTransfer = @"opportunity:transfer";//转移他人

//合同
static NSString  * const ZDWorkModulePermissionTypeContractView = @"contract:view";//查看合同
static NSString  * const ZDWorkModulePermissionTypeContractAdd = @"contract:add";//新增合同
static NSString  * const ZDWorkModulePermissionTypeContractEdit = @"contract:edit";//编辑合同
static NSString  * const ZDWorkModulePermissionTypeContractDelete = @"contract:delete";//删除合同
static NSString  * const ZDWorkModulePermissionTypeContractTransfer = @"contact:transfer";//转移他人


//联系人
static NSString  * const ZDWorkModulePermissionTypeContactView = @"contacts:view";//查看联系人
static NSString  * const ZDWorkModulePermissionTypeContactAdd = @"contacts:add";//新增联系人
static NSString  * const ZDWorkModulePermissionTypeContactEdit = @"contacts:edit";//编辑联系人
static NSString  * const ZDWorkModulePermissionTypeContactDelete = @"contacts:delete";//删除联系人
static NSString  * const ZDWorkModulePermissionTypeContactTransfer = @"contacts:transfer";//转移他人

//跟进记录
static NSString  * const ZDWorkModulePermissionTypeTraceRecordDelete = @"traceRecord:delete";//删除跟进记录


static NSString  * const ZDWorkTableListTitleMail = @"邮箱";//曾用名：电子邮箱，邮箱
static NSString  * const ZDWorkTableListTitlePhone = @"手机";//曾用名：手机号码，手机
static NSString  * const ZDWorkTableListTitleQQ = @"QQ";//曾用名：个人QQ，QQ
static NSString  * const ZDWorkTableListTitleWechat = @"微信";//
static NSString  * const ZDWorkTableListTitleAddress = @"地址";//所在地区 —> 地址
static NSString  * const ZDWorkTableListTitlePostalcode = @"邮政编码";//邮政编码
static NSString  * const ZDWorkTableListTitleTelPhone = @"电话";//电话

/*!< 新增任务*/
static NSString  * const ZDWorkTableListTitleTimeLimit = @"截止时间";
static NSString  * const ZDWorkTableListTitleRemindAtTime = @"定时提醒";
static NSString  * const ZDWorkTableListTitleExecutiveStaff = @"执行人员";
static NSString  * const ZDWorkTableListTitleParticipants = @"参与人员";
static NSString  * const ZDWorkTableListTitleEmergencyLevel = @"紧急程度";
static NSString  * const ZDWorkTableListTitleRelatedBusiness = @"关联业务";


static NSString  * const ZDPermitResult = @"ZDPermitResult";//权限列表请求通知


static NSString  * const ZDPATHTASKADDTASk = @"/task/addTask";//新增任务
static NSString  * const ZDPATHLISTSMSPACKAGE = @"/teleconference/listSmsPackage";//获取语音套餐
static NSString  * const ZDPATHLAliPaySign = @"/alipay/appPay/unifiedorder";//支付宝签名
static NSString  * const ZDPATHLWXPaySign = @"/wxpay/appPay/unifiedorder";//微信支付签名
static NSString  * const ZDPATHLCUSTOMERLIST= @"/customer/listCustomer";//客户列表
static NSString  * const ZDPATHLCLUELIST= @"/clue/listClue";//线索列表
static NSString  * const ZDPATHLCONTACTSLIST= @"/contacts/listContacts";//联系人列表
static NSString  * const ZDPATHLBUSINESSOPPORTUNITYSLIST = @"/businessOpportunity/listBusinessOpportunity";//商机列表

/**线索搜索 */
static NSString  * const ZDPATHLCLUESEARCH = @"/clue/searchClue";

/**
 *联系人搜索 
 */
static NSString  * const ZDPATHLCONTACTSSEARCH = @"/contacts/searchContacts";

/**
 *组织架构搜索
 */
static NSString  * const ZDPATHLADMINDEPARTMENTSEARCH = @"adminDepartment/searchDepartmentAndUser";




#endif /* HHColorConfig_h */
