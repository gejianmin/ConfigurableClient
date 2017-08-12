//
//  HHAPIConst.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#ifndef HHAPIConst_h
#define HHAPIConst_h

#if DEBUG

#   define FMWLog(id, ...) NSLog((@"%s [Line %d] " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else

#   define FMWLog(id, ...)

#endif

#define HH_RESPONSE_CODE [response[@"Header"][@"StatusCode"] integerValue]
#define HH_RESPONSE_CODE_ERROR response[@"Header"][@"Message"] 

#define HH_RESPONSE_DATA response[@"Data"]

#define HH_RESPONSE_DATA_ERROR response[@"Data"][@"Message"]
#define HH_RESPONSE_DATA_CODE [response[@"Data"][@"Result"] boolValue]

#define HH_JSONSERIALIZER_ERROR @"数据解析出错"

#define HH_AUTH_TOKEN @"HHFinancialServiceToken"

#define RESPONSE_SUCCESS_CODE 200



static NSTimeInterval const kRequestTimeOut=30.f;

////////////////////////////////////////////////////////////
//MARK:OCR
static NSString * const kFaceID_APP_KEY=@"GFby91zhWmr4kV_NbXv4--ghTLpuzR3S";
static NSString * const kFaceID_APP_SECRET=@"a6UbU7dDdZFzXUFaPg7Rin-VLPn5rWOS";
static NSString * const kFacePlusOCRIDCard=@"https://api.faceid.com/faceid/v1/ocridcard";




//MARK:上传图片
static NSString *const kBangUploadImagePath=@"MerchantArg/ImageUpload";

static NSString *const kBangLoginPath=@"User/AppLogin";//登陆

static NSString *const kBangLogOutPath=@"User/AppExit";//退出

static NSString *const kBangDetalisInfoPath=@"User/GetDealerInfo";//店铺详情

static NSString *const kBangCalculationList=@"api/CalculationList";//获取金融产品列表
static NSString *const kBangCalculationDetail=@"api/CalculationDetail";//获取金融产品详情
static NSString *const kBangCalculate=@"api/DoClaculation";//测算

static NSString *const kBangSaveProjectByCal=@"api/SaveProjectByCalc";//提报

//MARK:登陆,注册,忘记密码修改等
static NSString *const kGetPublicKeyURL=@"SysSecurity/SecurityKey/GetPublicKey";//获取公钥


//MARK:车
static NSString * const kCustomerCarGetCarBrands = @"vehicle/GetAllBrands"; /*车300 获取品牌  */

static NSString * const kCustomerCarGetSeries = @"vehicle/GetSeriesByBrandId"; /*车300 获取车系  */

static NSString * const kCustomerCarGetVehicles = @"vehicle/GetTrimsBySeriesId"; /*车300 获取车型  */

//MARK:项目管理
static NSString * const kBangGetProjectList=@"CustomerInfo/GetProjectList";//获取项目列表
static NSString * const kBangDeleteQuotation=@"CustomerInfo/DeleteQuotation";//删除项目
static NSString * const kBangGetProjectInfo=@"CustomerInfo/GetProjectInfo";//获取项目详情
static NSString * const kBangSumbitProject=@"CustomerInfo/SumbitProject";//提交项目
static NSString * const kBangUploadImage=@"upload/CustomInfoImg";//上传图片
static NSString * const kBangDownloadImage=@"download/CustomInfoShowImg";//下载图片

//基本信息
static NSString * const kBangAddIDCard=@"CustomerInfo/AddIDCard";//添加身份证信息
static NSString * const kBangAddDetailCredit=@"CustomerInfo/AddDetailCredit";//添加征信信息
static NSString * const kBangAddOtherAddFile=@"CustomerInfo/AddOtherAddFile";//添加其他补充信息
static NSString * const kBangEmergcyContact=@"CustomerInfo/AddCrashContactPerson";//添加紧急联系人信息
static NSString * const kBangAddApplicationForm=@"CustomerInfo/AddApplicationForm";//添加申请表信息
static NSString * const kBangAddResidence=@"CustomerInfo/AddResidence";//添加户籍信息
static NSString * const kBangAddBankLow=@"CustomerInfo/AddBankCardOrStatements";//添加用户银行卡流水信息
static NSString * const kBangAddDriver=@"CustomerInfo/AddDriver";//添加驾驶证信息
static NSString * const kBangAddCivilState=@"CustomerInfo/AddCivilState";//添加婚姻证明信息
static NSString * const kBangAddRepaymentAccount=@"CustomerInfo/AddRepaymentAccount";//添加还款账户信息
static NSString * const kBangAddCarAssessReport=@"CustomerInfo/AddCarAssessReport";//添加评估报告信息
static NSString * const kBangAddRegistCer=@"CustomerInfo/AddRegistrationCertificate";//添加登记证书信息
static NSString * const kBangAddDrivingLicense=@"CustomerInfo/AddDrivingLicense";//添加行驶证信息
static NSString * const kBangAddProofOfResidence=@"CustomerInfo/AddProofOfResidence";//添加居住证明信息
static NSString * const kBangAddEducation=@"CustomerInfo/AddAcademicQualifications";//添加学历证明信息

//配偶信息
static NSString * const kBangAddSpouseResidence=@"CustomerInfo/AddSpouseResidence";//更新配偶户籍
static NSString * const kBangAddMarriageCer=@"CustomerInfo/AddMarriageCertificate";//更新配偶结婚证
static NSString * const kBangSaveSpouseInfo=@"CustomerInfo/SaveSpouseInfo";//更新配偶身份证信息

//担保人信息
static NSString * const kBangSaveGuarantorCard=@"CustomerInfo/SaveGuarantorCard";//更新担保人身份证
static NSString * const kBangSaveGuarantorCredit=@"CustomerInfo/SaveGuarantorCredit";//更新担保人征信
static NSString * const kBangAddGuarantorBankCard=@"CustomerInfo/AddGuarantorBankCard";//更新担保人银行卡流水
static NSString * const kBangAddGuarantorResidence=@"CustomerInfo/AddGuarantorResidence";//更新担保人户籍
//数据统计
//申请数据
static NSString * const kBangSPReportGetAPPListByDay=@"HHBSPReport/GetAPPListByDay";//日
static NSString * const kBangSPReportGetAPPListByWeek=@"HHBSPReport/GetAppListByWeek";//周
static NSString * const kBangSPReportGetAPPListByMonth=@"HHBSPReport/GetAppListByMonth";//月
static NSString * const kBangSPReportGetAPPListByQuarter=@"HHBSPReport/GetAppListByQuarter";//季
static NSString * const kBangSPReportGetAPPListByYear=@"HHBSPReport/GetAppListByYear";//年
//放款数据
static NSString * const kBangSPReportGetPayListByDay=@"HHBSPReport/GetPayListByDay";//日
static NSString * const kBangSPReportGetPayListByWeek=@"HHBSPReport/GetPayListByWeek";//周
static NSString * const kBangSPReportGetPayListByMonth=@"HHBSPReport/GetPayListByMonth";//月
static NSString * const kBangSPReportGetPayListByQuarter=@"HHBSPReport/GetPayListByQuarter";//季
static NSString * const kBangSPReportGetPayListByYear=@"HHBSPReport/GetPayListByYear";//年
// 拒绝和逾期数据
static NSString * const kBangSPReportRefuseAndTimeOut=@"HHBSPReport/RefuseAndTimeOut";//拒绝和预期

#endif /* HHAPIConst_h */
