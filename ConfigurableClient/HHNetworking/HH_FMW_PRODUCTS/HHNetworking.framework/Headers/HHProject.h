//
//  HHProject.h
//  HHNetworking
//
//  Created by LWJ on 2016/11/30.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHProject : NSObject
@property (nonatomic, strong) NSString *CreateTime;
@property (nonatomic, strong) NSString *CustomName;
@property (nonatomic, strong) NSString *ProjectCode;
@property (nonatomic, strong) NSString *ProjectID;
@property (nonatomic, strong) NSString *ProjectName;
@property (nonatomic, strong) NSString *UserName;
@property (nonatomic, strong) NSString *CarType;


@end
@class UIColor,HHCustomerDetail,HHCustomerImage,HHCustomerMetaData,HHCustomerGuarantor,HHCustomerBaseInfo,HHCustomerSpouseInfo,HHCustomerGuarantorInfo,HHCustomerIDCard,HHCustomerCredit,HHCustomerDriver,HHCustomerLicense,HHCustomerEducation,HHCustomerHousehold,HHCustomerBankFlow,HHCustomerApplyForm,HHCustomerAssess,HHCustomerContact,HHCustomerPayAcct,HHCustomerRegCer,HHCustomerLive,HHCustomerOther,HHCustomerWeddig,HHCustomerMetaDatas,HHDataStatisticsData,HHDataTbData,HHDataHbData,HHTotalData,HHRefuseData,HHTimeOut;
#pragma mark - ***************客户属性******************
@interface HHCustomer : NSObject
//@property (nonatomic, strong) HHCustomerDetail *CustomerDetail;
//@property (nonatomic, strong) NSArray <HHCustomerMetaData *> *lstMetaData;
//@property (nonatomic, strong) NSArray <HHCustomerImage *> *LstImg;
//@property (nonatomic, strong) NSArray <HHCustomerGuarantor *> *LstGuarantor;


@property (nonatomic, strong) HHCustomerBaseInfo *BasicInfo;
@property (nonatomic, strong) HHCustomerSpouseInfo *SpouseInfo;
@property (nonatomic, strong) HHCustomerGuarantorInfo *GuarantorInfo;
@property (nonatomic, strong) HHProject *Project;

@end

#pragma mark - ***************客户基本信息*****************
@interface HHCustomerBaseInfo : NSObject
@property (nonatomic, strong) HHCustomerIDCard *IDCard;//身份证
@property (nonatomic, strong) HHCustomerCredit *CreditReport;//征信
@property (nonatomic, strong) HHCustomerDriver *Driver;//驾驶证
@property (nonatomic, strong) HHCustomerLicense *DrivingLicense;//行驶证
@property (nonatomic, strong) HHCustomerEducation *Education;//学历
@property (nonatomic, strong) HHCustomerHousehold *Household;//户籍
@property (nonatomic, strong) HHCustomerOther *OtherMaterial;//其他补充
@property (nonatomic, strong) HHCustomerLive *ProofOfResidence;//居住
@property (nonatomic, strong) HHCustomerRegCer *Registration;//登记证
@property (nonatomic, strong) HHCustomerPayAcct *RepaymentAccount;//还款账户
@property (nonatomic, strong) HHCustomerWeddig *Wedding;//婚姻证明
@property (nonatomic, strong) HHCustomerContact *CrashContactPerson;//紧急联系人
@property (nonatomic, strong) HHCustomerAssess *CarAssessReport;//评估报告
@property (nonatomic, strong) HHCustomerApplyForm *ApplicationForm;//申请表单
@property (nonatomic, strong) HHCustomerBankFlow *BankStatements;//银行卡流水
@end
//身份证
@interface HHCustomerIDCard : NSObject
@property (nonatomic, strong) NSString *Name;//
@property (nonatomic, strong) NSString *BirthDate;//
@property (nonatomic, strong) NSString *IDCardAddress;//
@property (nonatomic, strong) NSString *IDNumber;//
@property (nonatomic, strong) HHCustomerMetaDatas *Sex;//
@property (nonatomic, strong) NSArray <HHCustomerImage *> *CardList;//
@end
//征信
@interface HHCustomerCredit : NSObject
@property (nonatomic, strong) NSString *Aftertaxincome;//
@property (nonatomic, strong) NSString *ServiceYear;//
@property (nonatomic, strong) NSString *WorkName;//
@property (nonatomic, strong) NSString *WorkPhone;//
@property (nonatomic, strong) HHCustomerMetaDatas *Industry;//
@property (nonatomic, strong) HHCustomerMetaDatas *Position;//
@property (nonatomic, strong) NSString *Property;//

@property (nonatomic, strong) NSArray <HHCustomerImage *> *ReportList;//

//////////////担保人征信信息、、、、
@property (nonatomic, strong) NSString *GuarantorLiveYear;//
@property (nonatomic, strong) NSString *GuarantorMaillingAddress;//
@property (nonatomic, strong) NSString *GuarantorWorkAddress;//
@property (nonatomic, strong) NSString *GuarantorWorkunits;//
@property (nonatomic, strong) NSString *Guarantormobile;//
@property (nonatomic, strong) HHCustomerMetaDatas *Guarantorrelation;//
@property (nonatomic, strong) NSString *Guarantorworkincome;//
@property (nonatomic, strong) NSArray <HHCustomerImage *> *CreditDetailList;//

@end
//驾驶证
@interface HHCustomerDriver : NSObject
@property (nonatomic, strong) NSString *DriverIDCard;//
@property (nonatomic, strong) NSString *DriverName;//
@property (nonatomic, strong) NSArray <HHCustomerImage *> *DriverList;//

@end
//行驶证
@interface HHCustomerLicense : NSObject
@property (nonatomic, strong) NSArray <HHCustomerImage *> *DrivingLicenseList;//

@end
//学历
@interface HHCustomerEducation : NSObject
@property (nonatomic, strong) HHCustomerMetaDatas *EducateGrade;//

@end
//户籍
@interface HHCustomerHousehold : NSObject
@property (nonatomic, strong) NSString *DomicilePlace;//
@property (nonatomic, strong) NSString *Name;//
@property (nonatomic, strong) NSString *UsedName;//
@property (nonatomic, strong) NSArray <HHCustomerImage *> *UrlList;//客户户籍



@property (nonatomic, strong) NSArray <HHCustomerImage *> *HouseholdList;//配偶，担保人户籍证明

@end
//银行卡流水
@interface HHCustomerBankFlow : NSObject
@property (nonatomic, strong) NSArray <HHCustomerImage *> *StatementsList;//

@property (nonatomic, strong) NSArray <HHCustomerImage *> *BankStatementList;//担保人银行卡流水

@end
//申请表单
@interface HHCustomerApplyForm : NSObject
@property (nonatomic, strong) NSArray <HHCustomerImage *> *ApplicationFormList;//

@end
//评估报告
@interface HHCustomerAssess : NSObject
@property (nonatomic, strong) NSArray <HHCustomerImage *> *CarAssessReportList;//

@end

//紧急联系人
@interface HHCustomerContact : NSObject
@property (nonatomic, strong) HHCustomerContact *MainAccount;//
@property (nonatomic, strong) NSArray <HHCustomerContact *> *ContactList;//

@property (nonatomic, strong) NSString *LinkAddress;//
@property (nonatomic, strong) NSString *LinkMobile;//
@property (nonatomic, strong) NSString *LinkName;//
@property (nonatomic, strong) NSString *LinkPeople;//

@end
//还款账户
@interface HHCustomerPayAcct : NSObject
@property (nonatomic, strong) NSArray <HHCustomerImage *> *CardList;//

@property (nonatomic, strong) HHCustomerPayAcct *MainAccount;//
@property (nonatomic, strong) NSArray <HHCustomerPayAcct *> *OtherAccount;//

@property (nonatomic, strong) NSString *BankAccount;//
@property (nonatomic, strong) NSString *BankAdd;//
@property (nonatomic, strong) NSString *BankMobile;//
@property (nonatomic, strong) NSString *BankName;//

@end
//登记证
@interface HHCustomerRegCer : NSObject
@property (nonatomic, strong) NSArray <HHCustomerImage *> *RegistrationList;//

@end
//居住证
@interface HHCustomerLive : NSObject
@property (nonatomic, strong) NSArray <HHCustomerImage *> *ProofList;//
@property (nonatomic, strong) HHCustomerMetaDatas *CR_HOUSE_TYPE;//
@property (nonatomic, strong) HHCustomerMetaDatas *LIVINGLIFE;//
@property (nonatomic, strong) HHCustomerMetaDatas *LIVINGSTATUS;//
@property (nonatomic, strong) NSString *CR_NATU_MAILING_ADDRESS;//

@end
//其他材料
@interface HHCustomerOther : NSObject
@property (nonatomic, strong) NSArray <HHCustomerImage *> *MaterialList;//

@end
//婚姻证明
@interface HHCustomerWeddig : NSObject
@property (nonatomic, strong) HHCustomerMetaDatas *CivilState;//
@property (nonatomic, strong) NSArray <HHCustomerImage *> *WeddingList;//

@end
#pragma mark - ***************客户配偶信息*****************
@interface HHCustomerSpouseInfo : NSObject
@property (nonatomic, strong) HHCustomerWeddig *Wedding;//婚姻证明
@property (nonatomic, strong) HHCustomerIDCard *IDCard;//身份证
@property (nonatomic, strong) HHCustomerHousehold *Household;//户籍
@end
#pragma mark - ***************客户担保人信息*****************
@interface HHCustomerGuarantorInfo : NSObject
@property (nonatomic, strong) HHCustomerIDCard *IDCard;//身份证
@property (nonatomic, strong) HHCustomerHousehold *Household;//户籍
@property (nonatomic, strong) HHCustomerBankFlow *BankStatement;//银行卡流水
@property (nonatomic, strong) HHCustomerCredit *CreditDetail;//征信
@property (nonatomic, strong) HHCustomerMetaDatas *GUARANTOR_TYPE;//担保人类型
@property (nonatomic, strong) NSString *GUARANTOR_ID;//id  0新增 非零修改

@end
#pragma mark - ***************客户信息图片*****************

@interface HHCustomerImage : NSObject <NSCopying>
@property (nonatomic, strong) NSString *FILE_NAME;
@property (nonatomic, strong) NSString *PATH;
@property (nonatomic, strong) NSString *TYPE;
@property (nonatomic, strong) NSString *YT_PATH;
@property (nonatomic, strong) UIColor *bgColor;
@end
#pragma mark - ***************客户信息选项元数据*****************
@interface HHCustomerMetaDatas : NSObject
@property (nonatomic, strong) NSArray <HHCustomerMetaData *> *List;
@property (nonatomic, strong) NSString *Selected;
@property (nonatomic, strong) HHCustomerMetaData *selectMetaData;

@end
@interface HHCustomerMetaData : NSObject  <NSCopying>
@property (nonatomic, strong) NSString *Key;
@property (nonatomic, strong) NSString *Value;
@property (nonatomic, assign) BOOL isSelected;

@end
#pragma mark - ***************数据统计*****************
//data statistics
/*
 "Model": {
 "Title": "2016年10月-2016年12月",
 "OrderNum": 37,
 "OrderAmount": 40.9,
 "tb": {
 "DownOrUp_Num": true, //同比数量是否增长  true为增长  false 为下跌
 "Margin_Num": "100",  //同比数量涨幅
 "DownOrUp_Amount": false, //同比金额是否增长  true为增长  false 为下跌
 "Margin_Amount": "-100" //同比金额涨幅
 },
 "hb": {
 "DownOrUp_Num": false, //环比数量是否增长  true为增长  false 为下跌
 "Margin_Num": "0",//环比数量涨幅
 "DownOrUp_Amount": false, //环比金额是否增长  true为增长  false 为下跌
 "Margin_Amount": "0"//环比金额涨幅


 */
@interface HHDataTbData : NSObject
@property (nonatomic, assign) BOOL DownOrUp_Num;//同比数量是否增长
@property (nonatomic, assign) BOOL DownOrUp_Amount;//同比金额是否增长
@property (nonatomic, strong) NSString *Margin_Num;//同比数量涨幅
@property (nonatomic, strong) NSString *Margin_Amount;//同比金额涨幅
@end
@interface HHDataHbData : NSObject
@property (nonatomic, assign) BOOL DownOrUp_Num;//环比数量是否增长
@property (nonatomic, assign) BOOL DownOrUp_Amount;//环比金额是否增长
@property (nonatomic, strong) NSString *Margin_Num;//环比数量涨幅
@property (nonatomic, strong) NSString *Margin_Amount;//环比金额涨幅
@end
@interface HHTotalData : NSObject
@property (nonatomic, strong) NSString *Title;//日期
@property (nonatomic, strong) NSString * OrderNum;//单数
@property (nonatomic, strong) NSString * OrderAmount;//金额
//@property (nonatomic, assign) NSInteger  OrderAmount;//金额

@end
@interface HHRefuseData : NSObject
@property (nonatomic, strong) NSString* OrderNum;//单数
@property (nonatomic, strong) NSString* OrderAmount;//金额
@end
@interface HHTimeOut : NSObject
@property (nonatomic, strong) NSString* OrderNum;//单数
@property (nonatomic, strong) NSString* OrderAmount;//金额
@end
@interface HHDataStatisticsData : NSObject
@property (nonatomic, strong) NSString *DateRange;//日期
@property (nonatomic, assign) NSInteger OrderNum;//单数
@property (nonatomic, assign) NSInteger OrderAmount;//金额
@property (nonatomic, strong) NSArray* Data;//
@property (nonatomic, assign) id Model;//
@property (nonatomic, strong) HHDataTbData *tbData;//同比
@property (nonatomic, strong) HHDataHbData *HbData;//环比
@property (nonatomic, strong) HHTotalData *TotalData;//
//逾期/拒绝
@property (nonatomic, strong) NSString *DeteTitle;//日期
@property (nonatomic, assign) id Refuse;//
@property (nonatomic, assign) id TimeOut;//
@property (nonatomic, strong) HHRefuseData *refuseData;//
@property (nonatomic, strong) HHTimeOut *timeOutData;//

@end




















@interface HHCustomerDetail : NSObject
@property (nonatomic, strong) NSString *APPLICANTCITY;//居住省份
@property (nonatomic, strong) NSString *APPLICANTDISTRICT;//居住城市
@property (nonatomic, strong) NSString *ASSIGNEE_CODE;//受托人编号---委托授权时用到
@property (nonatomic, strong) NSString *CLERK_ID;//客户经理ID
@property (nonatomic, strong) NSString *CLERK_NAME;//客户经理NAME
@property (nonatomic, strong) NSString *COMPANYCITY;//工作省份
@property (nonatomic, strong) NSString *COMPANYDISTRICT;//工作城市
@property (nonatomic, strong) NSString *COOPERATION;//合作类型
@property (nonatomic, strong) NSString *CR_AFTERTAXINCOME;//申请人税后年收入
@property (nonatomic, strong) NSString *CR_AFTERTAXINCOME_OTHER;//其他税后年收入
@property (nonatomic, strong) NSString *CR_AREA_ID;//客户所在地区
@property (nonatomic, strong) NSString *CR_BANK_ACCOUNTS;//开户账号
@property (nonatomic, strong) NSString *CR_BANK_ADD;//
@property (nonatomic, strong) NSString *CR_BASE_INCOME;//收入
@property (nonatomic, strong) NSString *CR_BECR_CODE;//客户编号
@property (nonatomic, strong) NSString *CR_BECR_NAME;//客户名称
@property (nonatomic, strong) NSString *CR_BECR_TYPE;//客户类型1：自然人 2：法人 3：事业单位
@property (nonatomic, strong) NSString *CR_BIRTH_DATE;//自然人出生日期
@property (nonatomic, strong) NSString *CR_BUSINESS_MAIN;//主营业务
@property (nonatomic, strong) NSString *CR_CARD_LIMIT;//信用卡透支额度情况
@property (nonatomic, strong) NSString *CR_CAR_LOAN;//车贷1否2是
@property (nonatomic, strong) NSString *CR_CAR_LOAN_MONEY;//车贷金额
@property (nonatomic, strong) NSString *CR_CAR_STAFF;//员工购车1否2是
@property (nonatomic, strong) NSString *CR_CDJE;//车贷金额
@property (nonatomic, strong) NSString *CR_CHECK_DATE;//现居住地入住日期
@property (nonatomic, strong) NSString *CR_CHILDREN_EDUCATION;//子女就学情况
@property (nonatomic, strong) NSString *CR_CHILDREN_NUMBER;//子女人数
@property (nonatomic, strong) NSString *CR_CITY_ID;//客户所在市
@property (nonatomic, strong) NSString *CR_COMPANY_EMAIL;//法人电子邮箱
@property (nonatomic, strong) NSString *CR_CORP_COMPANY_LINKPHONE;//联系电话
@property (nonatomic, strong) NSString *CR_CORP_REGISTE_PHONE;//注册电话
@property (nonatomic, strong) NSString *CR_CORP_WORK_UNITS_ADDRESS;//单位地址
@property (nonatomic, strong) NSString *CR_CREATE_ID;//创建人
@property (nonatomic, strong) NSString *CR_CUST_LEVEL;//客户分类
@property (nonatomic, strong) NSString *CR_DRIVING_LICENCE;//驾驶证
@property (nonatomic, strong) NSString *CR_DRIVING_LICENCE_CODE;//驾驶员身份证号码
@property (nonatomic, strong) NSString *CR_DRIVING_LICENCE_NAME;//驾驶员姓名
@property (nonatomic, strong) NSString *CR_DRIVING_LICENCE_NUM;//驾驶证号码
@property (nonatomic, strong) NSString *CR_DRIVING_LICENCE_REL;//驾驶证与主贷人关系
@property (nonatomic, strong) NSString *CR_EDUCATION;//文化程度
@property (nonatomic, strong) NSString *CR_ENTERPRISE;//单位性质
@property (nonatomic, strong) NSString *CR_ENTRY_DATE;//入职日期
@property (nonatomic, strong) NSString *CR_FAMILY_INCOME;//家庭收入
@property (nonatomic, strong) NSString *CR_FIRST_CAR;//是否首次购车1否2是
@property (nonatomic, strong) NSString *CR_GRADE;//客户等级
@property (nonatomic, strong) NSString *CR_GUARANTEE;//是否担保1否2是
@property (nonatomic, strong) NSString *CR_HEALTH;//健康状况
@property (nonatomic, strong) NSString *CR_HOUSE_TYPE;//房屋性质
@property (nonatomic, strong) NSString *CR_HOUSE_TYPE_W;//承租人配偶房屋类型 1自有全款 2自有贷款3租赁4其他
@property (nonatomic, strong) NSString *CR_ID_CARD_TYPE;//身份证类型
@property (nonatomic, strong) NSString *CR_INDUSTRY;//行业
@property (nonatomic, strong) NSString *CR_LOAN_LIMIT;//个人贷款额度
@property (nonatomic, strong) NSString *CR_LOCAL_YEAR;//本地居住年限
@property (nonatomic, strong) NSString *CR_MAILING_ADDRESS;//邮寄地址1同家庭地址2同单位地址3其他
@property (nonatomic, strong) NSString *CR_MAIN_BUSINESS;//主营业务
@property (nonatomic, strong) NSString *CR_MARRIAGE_STATE;//婚姻状况
@property (nonatomic, strong) NSString *CR_MATE_AFTERTAXINCOME;//配偶税后年收入
@property (nonatomic, strong) NSString *CR_MATE_BIRTH_DATE;//配偶出生日期
@property (nonatomic, strong) NSString *CR_MATE_HOME_ADDRESS;//家庭住址
@property (nonatomic, strong) NSString *CR_MATE_INCOME;//每月净收入
@property (nonatomic, strong) NSString *CR_MATE_INDUSTRY;//行业
@property (nonatomic, strong) NSString *CR_MATE_INDUSTRY_TYPE;//职业类型
@property (nonatomic, strong) NSString *CR_MATE_LOAN_AMOUNT;//贷款额
@property (nonatomic, strong) NSString *CR_MATE_MAILING_ADDRESS;//现居住地址
@property (nonatomic, strong) NSString *CR_MATE_MAILING_ADDRESS_DZ;//邮寄地址
@property (nonatomic, strong) NSString *CR_MATE_MONTHLY;//月供
@property (nonatomic, strong) NSString *CR_MATE_POSITION;//职位
@property (nonatomic, strong) NSString *CR_MATE_POSITION_AREACODE;//邮编
@property (nonatomic, strong) NSString *CR_MATE_POSITION_ZIPCODE;//区号
@property (nonatomic, strong) NSString *CR_MATE_SOURCE_INCOME;//配偶主要收入来源
@property (nonatomic, strong) NSString *CR_MATE_TERM;//期限
@property (nonatomic, strong) NSString *CR_MATE_WORK_EXPERIENCE;//本单位工作期限
@property (nonatomic, strong) NSString *CR_MATE_WORK_POSTALCODE;//配偶现工作单位邮政编码
@property (nonatomic, strong) NSString *CR_MATE_ZIPCODE;//邮编
@property (nonatomic, strong) NSString *CR_MODIFY_ID;//修改人
@property (nonatomic, strong) NSString *CR_MONTHLY_INCOME;//承租人月收入
@property (nonatomic, strong) NSString *CR_MONTHLY_PAY;//承租人月供

@property (nonatomic, strong) NSString *CR_NATU_AGE;//自然人年龄
@property (nonatomic, strong) NSString *CR_NATU_FAX;//自然人担保传真
@property (nonatomic, strong) NSString *CR_NATU_HJ_ADDRESS;//户籍所在地
@property (nonatomic, strong) NSString *CR_NATU_HOME_ADDRESS;//自然人家庭地址
@property (nonatomic, strong) NSString *CR_NATU_IDCARD;//自然人身份证号
@property (nonatomic, strong) NSString *CR_NATU_IDCARD_ADDRESS;//自然人身份证地址
@property (nonatomic, strong) NSString *CR_NATU_MATE_ACCOUNT;//配偶户口1本地2非本地
@property (nonatomic, strong) NSString *CR_NATU_MATE_DOCUMENT;//证件类型
@property (nonatomic, strong) NSString *CR_NATU_MATE_EDUCATION;//教育1本科以上2本科3高中4高中以下
@property (nonatomic, strong) NSString *CR_NATU_MATE_IDCARD;//自然人配偶身份证号
@property (nonatomic, strong) NSString *CR_NATU_MATE_IDCARD_ADDRESS;//自然人配偶身份证地址
@property (nonatomic, strong) NSString *CR_NATU_MATE_MOBILE;//自然人配偶手机
@property (nonatomic, strong) NSString *CR_NATU_MATE_NAME;//自然人配偶姓名
@property (nonatomic, strong) NSString *CR_NATU_MATE_NEXUS;//与申请人关系1夫妻2朋友3其他
@property (nonatomic, strong) NSString *CR_NATU_MATE_PHOTOPATH;//自然人配偶照片
@property (nonatomic, strong) NSString *CR_NATU_MATE_PROPERTY;//
@property (nonatomic, strong) NSString *CR_NATU_MATE_SEX;//配偶性别1男2女
@property (nonatomic, strong) NSString *CR_NATU_MATE_WORK_ADDRESS;//自然人配偶工作地址
@property (nonatomic, strong) NSString *CR_NATU_MATE_WORK_PHONE;//自然人配偶工作单位电话
@property (nonatomic, strong) NSString *CR_NATU_MATE_WORK_UNITS;//自然人配偶工作单位
@property (nonatomic, strong) NSString *CR_NATU_MOBILE;//自然人手机
@property (nonatomic, strong) NSString *CR_NATU_PHONE;//自然人电话
@property (nonatomic, strong) NSString *CR_NATU_PHOTOPATH;//自然人照片路径
@property (nonatomic, strong) NSString *CR_NATU_POSITION;//自然人职位
@property (nonatomic, strong) NSString *CR_NATU_POSITION_AREACODE;//邮寄地址区号
@property (nonatomic, strong) NSString *CR_NATU_POSITION_QT;//其他职位
@property (nonatomic, strong) NSString *CR_NATU_POSITION_ZIPCODE;//邮寄地址邮编
@property (nonatomic, strong) NSString *CR_NATU_SEX;//自然人性别
@property (nonatomic, strong) NSString *CR_NATU_WORK_ADDRESS;//自然人工作地址
@property (nonatomic, strong) NSString *CR_NATU_WORK_PHONE;//自然人工作单位电话
@property (nonatomic, strong) NSString *CR_NATU_WORK_UNITS;//自然人工作单位
@property (nonatomic, strong) NSString *CR_NATU_ZIP;//自然人邮编



@property (nonatomic, strong) NSString *CR_OPEN_BANK;//开户银行
@property (nonatomic, strong) NSString *CR_POSITION;//岗位
@property (nonatomic, strong) NSString *CR_POST_ADDRESS;//邮寄地址
@property (nonatomic, strong) NSString *CR_PROVINCE_ID;//客户所在省
@property (nonatomic, strong) NSString *CR_REMARK;//备 注
@property (nonatomic, strong) NSString *CR_SERVICE_YEAR;//承租人本单位工作年限
@property (nonatomic, strong) NSString *CR_SOURCE_INCOME;//申请人主要收入来源
@property (nonatomic, strong) NSString *CR_STATUS;//状态
@property (nonatomic, strong) NSString *CR_TYPE;//类型
@property (nonatomic, strong) NSString *CR_TYPE_OCCUPATION;//职业类型
@property (nonatomic, strong) NSString *CR_USED_NAME;//承租人曾用名
@property (nonatomic, strong) NSString *CR_WORKAGE;//工作年限
@property (nonatomic, strong) NSString *CR_WORKING;//工作情况
@property (nonatomic, strong) NSString *CR_WORK_INCOME;//月收入
@property (nonatomic, strong) NSString *CR_WORK_POSTALCODE;//现工作单位邮政编码
@property (nonatomic, strong) NSString *EMPLOYEE_AGE;//年龄
@property (nonatomic, strong) NSString *EMPLOYEE_CODE;//工号
@property (nonatomic, strong) NSString *EMPLOYEE_DEPTID;//组织机构id
@property (nonatomic, strong) NSString *EMPLOYEE_EMAIL;//邮箱
@property (nonatomic, strong) NSString *EMPLOYEE_EMPT;//部门
@property (nonatomic, strong) NSString *EMPLOYEE_GENDER;//性别
@property (nonatomic, strong) NSString *EMPLOYEE_ID;//
@property (nonatomic, strong) NSString *EMPLOYEE_ID_CARD;//身份证号
@property (nonatomic, strong) NSString *EMPLOYEE_ID_CARD_ADDR;//身份证地址
@property (nonatomic, strong) NSString *EMPLOYEE_ISDEPT;//员工所属部门
@property (nonatomic, strong) NSString *EMPLOYEE_MOBILE_TEL;//手机号
@property (nonatomic, strong) NSString *EMPLOYEE_NAME;//姓名
@property (nonatomic, strong) NSString *EMPLOYEE_NO;//员工编号
@property (nonatomic, strong) NSString *EMPLOYEE_QQ;//QQ
@property (nonatomic, strong) NSString *EMPLOYEE_TELEPONE;//联系电话（家庭）
@property (nonatomic, strong) NSString *EMPLOYEE_ZHIFU;//职务
@property (nonatomic, strong) NSString *EMP_TYPE;//类型 0临时 1实习 2试用 3在职 4离职 5：公司辞退（还没有办离职手续）  6：申请转正中
@property (nonatomic, strong) NSString *GENERAL_TAXPAYER;//是否为一般纳税人：0：是  1：不是
@property (nonatomic, strong) NSString *LIVINGLIFE;//现居住年限
@property (nonatomic, strong) NSString *LIVINGSTATUS;//居住状态
@property (nonatomic, strong) NSString *MAILING_ADDRESS_DZ;//邮寄地址
@property (nonatomic, strong) NSString *MAILING_CREDIT;//贷记卡1有2无
@property (nonatomic, strong) NSString *MAILING_CREDIT_OVERDUE;//贷记卡逾期1有2无
@property (nonatomic, strong) NSString *MAILING_LOAN;//贷款1有2无
@property (nonatomic, strong) NSString *MAILING_LOANS_OVERDUE;//贷款逾期1有2无
@property (nonatomic, strong) NSString *MATECITY;//配偶居住省份
@property (nonatomic, strong) NSString *MATECOMPANYCITY;//配偶工作省份
@property (nonatomic, strong) NSString *MATECOMPANYDISTRICT;//配偶工作城市
@property (nonatomic, strong) NSString *MATEDISTRICT;//配偶居住城市
@property (nonatomic, strong) NSString *MATE_FIXED_TELEPHONE;//固定电话1家庭2单位
@property (nonatomic, strong) NSString *MATE_FIXED_TELEPHONE_CODE;//固定电话号
@property (nonatomic, strong) NSString *MONEY_TYPE;//币种
@property (nonatomic, strong) NSString *NATU_ACCOUNT;//户口1本地2非本地
@property (nonatomic, strong) NSString *NATU_SELF_EMAIL;//自然人电子邮箱
@property (nonatomic, strong) NSString *REPAYMENTRECORDS;//还款记录
@property (nonatomic, strong) NSString *TRUE_MONEY_TYPE;//实收资本币种
@property (nonatomic, strong) NSString *VERIFICATION;//身份证验证

@end
@interface HHCustomerGuarantor : NSObject
@property (nonatomic, strong) NSString *CR_ENTERPRISE;//单位性质
@property (nonatomic, strong) NSString *CR_NATU_HOME_ADDRESS;//自然人家庭地址
@property (nonatomic, strong) NSString *CR_NATU_MAILING_ADDRESS;//自然人-通讯地址
@property (nonatomic, strong) NSString *GUARANTORTYPE;//担保人类型
@property (nonatomic, strong) NSString *ID_CARD_TYPE;//自然人-身份证类型
@property (nonatomic, strong) NSString *NATU_EMAIL;//自然人-身份证类型
@property (nonatomic, strong) NSString *NATU_IDCARD_ADDRESS;//自然人-身份证地址
@property (nonatomic, strong) NSString *NATU_MOBILE;//自然人-手机号码
@property (nonatomic, strong) NSString *NATU_PHONE;//自然人：家庭电话
@property (nonatomic, strong) NSString *NATU_WORK_ADDRESS;//自然人：单位地址
@property (nonatomic, strong) NSString *NATU_WORK_UNITS;//自然人：工作单位
@property (nonatomic, strong) NSString *UNIT_NAME;//单位名称中文
@property (nonatomic, strong) NSString *UNIT_NAME_E;//单位名称英文


@end
