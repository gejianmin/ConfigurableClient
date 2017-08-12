//
//  HHUserInfo.h
//  HHNetworking
//
//  Created by qiangge on 2016/11/4.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHUserInfo : NSObject <NSCoding>


@property (nonatomic,copy) NSString *CityName;
@property (nonatomic,copy) NSString *CreateTime;
@property (nonatomic,copy) NSString *EmployeeId;
@property (nonatomic,copy) NSString *EnterpriseDesc;
@property (nonatomic,copy) NSString *FinanceLeaseId;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *Latitude;
@property (nonatomic,copy) NSString *Level;
@property (nonatomic,copy) NSString *LoginName;
@property (nonatomic,copy) NSString *LogoSrc;
@property (nonatomic,copy) NSString *Longitude;
@property (nonatomic,copy) NSString *ModifyTime;
@property (nonatomic,copy) NSString *Parentid;
@property (nonatomic,copy) NSString *Password;
@property (nonatomic,copy) NSString *RealName;
@property (nonatomic,copy) NSString *RegisterMoney;
@property (nonatomic,copy) NSString *Responsibility;
@property (nonatomic,copy) NSString *Status;
@property (nonatomic,copy) NSString *StoreAddress;
@property (nonatomic,copy) NSString *Tel;
@property (nonatomic,copy) NSString *Telephone;
@property (nonatomic,copy) NSString *cityId;


@end
@class HHIDCardLegality,HHIDCardBirthday;

@interface HHIDCard : NSObject
@property (nonatomic, strong) NSString *issued_by;//签发机关
@property (nonatomic, strong) NSString *address;//地址
@property (nonatomic, strong) HHIDCardBirthday *birthday;//生日，下分年月日，都是一个字符串
@property (nonatomic, strong) NSString *gender;//性别（男/女）
@property (nonatomic, strong) NSString *id_card_number;//身份证号
@property (nonatomic, strong) NSString *name;//姓名
@property (nonatomic, strong) NSString *race;//民族（汉字）
@property (nonatomic, strong) NSString *side;//front/back 表示身份证的正面或者反面（illegal）
@property (nonatomic, strong) NSString *valid_date;//有效日期，格式为一个16位长度的字符串，表示内容如下YYYY.MM.DD-YYYY.MM.DD，或是YYYY.MM.DD-长期
@property (nonatomic, strong) HHIDCardLegality *legality;//
@end
@interface HHIDCardLegality : NSObject
@property (nonatomic, strong) NSString *Edited;//用工具合成或者编辑过的身份证图片
@property (nonatomic, strong) NSString *IDPhoto;//（正式身份证照片）
@property (nonatomic, strong) NSString *Photocopy;//（正式身份证的复印件）
@property (nonatomic, strong) NSString *Screen;//手机或电脑屏幕翻拍的照片）
@property (nonatomic, strong) NSString *TemporaryIDPhoto;//临时身份证照片

@end
@interface HHIDCardBirthday : NSObject
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *year;
@end

