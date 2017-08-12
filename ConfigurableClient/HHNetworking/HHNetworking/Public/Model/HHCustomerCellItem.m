//
//  HHProjectCellItem.m
//  HHFinancialService
//
//  Created by LWJ on 2016/12/1.
//  Copyright © 2016年 Lxrent. All rights reserved.
//

#import "HHCustomerCellItem.h"
#import "HHProject.h"
#import <objc/runtime.h>
#import "HHUserInfo.h"
@implementation HHCustomerCellItem
-(id)copyWithZone:(NSZone *)zone{
    HHCustomerCellItem *item=[[HHCustomerCellItem alloc] init];
    u_int count=0;
    objc_property_t *properties=class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        const char* pname=property_getName(properties[i]);
        NSString *key=[NSString stringWithUTF8String:pname];
        id value=[self valueForKey:key];
        if (value) {
            [item setValue:value forKey:key];
        }
    }
    free(properties);
    
    NSMutableArray *temp1=[NSMutableArray array];
    for (HHCustomerCellItem *obj in self.extensionInfo) {
        [temp1 addObject:[obj copy]];
    }
    item.extensionInfo=temp1;
    item.selectMetaData=[self.selectMetaData copy];
    
    NSMutableArray *temp2=[NSMutableArray array];
    for (id obj in self.metaData) {
        [temp2 addObject:[obj copy]];
    }
    item.metaData=temp2;
    NSMutableArray *temp3=[NSMutableArray array];
    for (id obj in self.images) {
        [temp3 addObject:[obj copy]];
    }
    item.images=temp3;
    
    
    return item;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _minImageCount=0;
        _maxImageCount=NSIntegerMax;
    }
    return self;
}
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value{
    HHCustomerCellItem *idcard=[[HHCustomerCellItem alloc] init];
    idcard.title=title;
    idcard.value=value;
    idcard.itemStyle=HHCustomerItemStyleInput;
    idcard.imageURLKey=@"UrlList";
    return idcard;
    
}
-(NSString *)reuseId{
    if (_reuseId==nil) {
        switch (self.itemStyle) {
            case HHCustomerItemStyleSelection:
                _reuseId=@"HHCustomerItemStyleSelection";
                break;
            case HHCustomerItemStyleInput:
                _reuseId=@"HHCustomerItemStyleInput";
                break;
            case HHCustomerItemStyleDetail:
                _reuseId=@"HHCustomerItemStyleDetail";
                break;
            case HHCustomerItemStyleImage:
                _reuseId=@"HHCustomerItemStyleImage";
                break;
                
            default:
                _reuseId=@"cell";
                break;
        }
    }
    return _reuseId;
}
-(NSString *)imageNamedWord{
    if (_imageNamedWord==nil) {
        switch (self.type) {
            case HHCustomerInfoTypeIDCard:
                _imageNamedWord=@"本人身份证";
                break;
            case HHCustomerInfoTypeCredit:
                _imageNamedWord=@"本人收入证明";
                break;
            case HHCustomerInfoTypeFamily:
                _imageNamedWord=@"本人户口本";
                break;
            case HHCustomerInfoTypeMarriage:
                _imageNamedWord=@"婚姻证明";
                break;
            case HHCustomerInfoTypeDrive:
                _imageNamedWord=@"驾驶证";
                break;
            case HHCustomerInfoTypeEdu:
                _imageNamedWord=@"";
                break;
            case HHCustomerInfoTypeLive:
                _imageNamedWord=@"房屋证明";
                break;
            case HHCustomerInfoTypeLicense:
                _imageNamedWord=@"行驶证";
                break;
            case HHCustomerInfoTypeRegisterCer:
                _imageNamedWord=@"登记证书";
                break;
            case HHCustomerInfoTypeAssessRep:
                _imageNamedWord=@"二手车评估报告";
                break;
            case HHCustomerInfoTypePayAccount:
                _imageNamedWord=@"银行卡";
                break;
            case HHCustomerInfoTypeBankLow:
                _imageNamedWord=@"本人银行流水";
                break;
            case HHCustomerInfoTypeApplyForm:
                _imageNamedWord=@"申请表";
                
                break;
            case HHCustomerInfoTypeEmergcy:
                _imageNamedWord=@"";
                
                break;
            case HHCustomerInfoTypeOther:
                _imageNamedWord=@"其他";
                
                break;
            case HHCustomerInfoTypeSpouseIDCard:
                _imageNamedWord=@"配偶身份证";
                
                break;
            case HHCustomerInfoTypeSpouseFamily:
                _imageNamedWord=@"配偶户口本";
                
                break;
            case HHCustomerInfoTypeMarriageCer:
                _imageNamedWord=@"婚姻证明";
                
                break;
            case HHCustomerInfoTypeGuarantorIDCard:
                _imageNamedWord=@"担保人身份证";
                
                break;
            case HHCustomerInfoTypeGuarantorFamily:
                _imageNamedWord=@"担保人户口本";
                
                break;
            case HHCustomerInfoTypeGuarantorCredit:
                _imageNamedWord=@"担保人收入证明";
                
                break;
            case HHCustomerInfoTypeGuarantorBankLow:
                _imageNamedWord=@"担保人银行流水";
                
                break;
                
            default:
                _imageNamedWord=@"";
                break;
        }
    }
    return _imageNamedWord;
}
+ (NSString *)formatBirthDateString:(NSString *)dateStr{
    NSDateFormatter *datefmt=[[NSDateFormatter alloc] init];
    datefmt.dateFormat=@"YYYY/MM/DD hh:mm:ss";
    NSDate *birthDate=[datefmt dateFromString:dateStr];
    datefmt.dateFormat=@"yyyy-MM-dd";
    NSString *birthDateStr=[datefmt stringFromDate:birthDate];
    
    return birthDateStr?birthDateStr:dateStr;
}
#pragma mark - 配置所有项数据源
//所有
+ (NSArray <NSArray <HHCustomerCellItem *> *> *)customerInfoItemsByCustomer:(HHCustomer *)customer project:(HHProject *)project{
    NSArray *baseinfo=[self customerBaseInfoByCustomer:customer project:project];
    NSArray *spouse=[self spouseInfoByCustomer:customer];
    NSArray *guarantor=[self guarantorInfoByCustomer:customer];
    return @[baseinfo,spouse,guarantor];
}
#pragma mark 基本信息数据源对象
//基本信息
+ (NSArray <HHCustomerCellItem *> *)customerBaseInfoByCustomer:(HHCustomer *)customer project:(HHProject *)project{
    NSString * cardImagesCount=@(customer.BasicInfo.IDCard.CardList.count).stringValue;
    HHCustomerCellItem *idcard=[HHCustomerCellItem itemWithTitle:@"身份证" value:cardImagesCount];
    idcard.type=HHCustomerInfoTypeIDCard;
    idcard.extensionInfo=[self setupIDCardItemsByCustomer:customer];
    idcard.images=[self setupIDCardImagesByCustomer:customer];
    idcard.imageURLKey=@"IDCardList";
    idcard.minImageCount=2;
    idcard.maxImageCount=2;
    
    NSString *creditImagesCount=@(customer.BasicInfo.CreditReport.ReportList.count).stringValue;
    HHCustomerCellItem *credit=[HHCustomerCellItem itemWithTitle:@"详版征信证明" value:creditImagesCount];
    credit.type=HHCustomerInfoTypeCredit;
    credit.extensionInfo=[self setupCreditItemsByCustomer:customer];
    credit.images=[self setupCreditImagesByCustomer:customer];
    credit.key=@"DetailCredit";
    credit.minImageCount=2;
    
    NSString *familyImagesCount=@(customer.BasicInfo.Household.UrlList.count).stringValue;
    
    HHCustomerCellItem *family=[HHCustomerCellItem itemWithTitle:@"户籍" value:familyImagesCount];
    family.type=HHCustomerInfoTypeFamily;
    family.extensionInfo=[self setupFamilyItemsByCustomer:customer];
    family.images=[self setupFamilyImagesByCustomer:customer];
    family.imageURLKey=@"CardFirst";
    family.key=@"Residence";
    family.minImageCount=2;
    
    NSString *weddingImagesCount=@(customer.BasicInfo.Wedding.WeddingList.count).stringValue;
    
    HHCustomerCellItem *marriage=[HHCustomerCellItem itemWithTitle:@"婚姻证明" value:weddingImagesCount];
    marriage.type=HHCustomerInfoTypeMarriage;
    marriage.extensionInfo=[self setupMarriageItemsByCustomer:customer];
    marriage.images=[self setupMarriageImagesByCustomer:customer];
    marriage.selectedItemKey=@"CivilState";
    marriage.minImageCount=2;
    
    
    NSString *driveImagesCount=@(customer.BasicInfo.Driver.DriverList.count).stringValue;
    HHCustomerCellItem *drive=[HHCustomerCellItem itemWithTitle:@"驾驶证" value:driveImagesCount];
    drive.type=HHCustomerInfoTypeDrive;
    drive.extensionInfo=[self setupDriveItemsByCustomer:customer];
    drive.images=[self setupDriveImagesByCustomer:customer];
    drive.key=@"Drivercard";
    drive.minImageCount=2;
    drive.maxImageCount=3;
    
    HHCustomerCellItem *edu=[HHCustomerCellItem itemWithTitle:@"学历证明" value:nil];
    edu.type=HHCustomerInfoTypeEdu;
    edu.extensionInfo=[self setupEduItemsByCustomer:customer];
    edu.images=[self setupEduImagesByCustomer:customer];
    edu.selectedItemKey=@"CR_EDUCATION";
    edu.noImage=YES;
    
    NSString *liveImagesCount=@(customer.BasicInfo.ProofOfResidence.ProofList.count).stringValue;
    HHCustomerCellItem *live=[HHCustomerCellItem itemWithTitle:@"居住证明" value:liveImagesCount];
    live.type=HHCustomerInfoTypeLive;
    live.extensionInfo=[self setupLiveItemsByCustomer:customer];
    live.images=[self setupLiveImagesByCustomer:customer];
    
    NSString *licenseImagesCount=@(customer.BasicInfo.DrivingLicense.DrivingLicenseList.count).stringValue;
    
    HHCustomerCellItem *license=[HHCustomerCellItem itemWithTitle:@"行驶证" value:licenseImagesCount];
    license.type=HHCustomerInfoTypeLicense;
    license.extensionInfo=[self setupLicenseItemsByCustomer:customer];
    license.images=[self setupLicenseImagesByCustomer:customer];
    license.minImageCount=2;
    license.maxImageCount=3;
    
    NSString *regImagesCount=@(customer.BasicInfo.Registration.RegistrationList.count).stringValue;
    HHCustomerCellItem *djzs=[HHCustomerCellItem itemWithTitle:@"登记证书" value:regImagesCount];
    djzs.type=HHCustomerInfoTypeRegisterCer;
    djzs.extensionInfo=[self setupRegisterItemsByCustomer:customer];
    djzs.images=[self setupRegisterImagesByCustomer:customer];
    djzs.minImageCount=3;
    
    NSString *assessImagesCount=@(customer.BasicInfo.CarAssessReport.CarAssessReportList.count).stringValue;
    HHCustomerCellItem *pgbg=[HHCustomerCellItem itemWithTitle:@"车辆评估报告" value:assessImagesCount];
    pgbg.type=HHCustomerInfoTypeAssessRep;
    pgbg.extensionInfo=[self setupAssessItemsByCustomer:customer];
    pgbg.images=[self setupAssessImagesByCustomer:customer];
    pgbg.minImageCount=1;
    
    NSString *payAccImagesCount=@(customer.BasicInfo.RepaymentAccount.CardList.count).stringValue;
    HHCustomerCellItem *hkzh=[HHCustomerCellItem itemWithTitle:@"还款账户" value:payAccImagesCount];
    hkzh.type=HHCustomerInfoTypePayAccount;
    hkzh.extensionInfos=[self setupPayAccItemsByCustomer:customer];
    hkzh.images=[self setupPayAccImagesByCustomer:customer];
    hkzh.imageURLKey=@"CardList";
    hkzh.minImageCount=1;
    hkzh.maxImageCount=3;
    
    NSString *bankflowImagesCount=@(customer.BasicInfo.BankStatements.StatementsList.count).stringValue;
    HHCustomerCellItem *yhls=[HHCustomerCellItem itemWithTitle:@"银行流水" value:bankflowImagesCount];
    yhls.type=HHCustomerInfoTypeBankLow;
    yhls.extensionInfo=[self setupBankLowItemsByCustomer:customer];
    yhls.images=[self setupBanklowImagesByCustomer:customer];
    yhls.imageURLKey=@"StatementsList";
    yhls.minImageCount=1;
    
    NSString *applyformImagesCount=@(customer.BasicInfo.ApplicationForm.ApplicationFormList.count).stringValue;
    HHCustomerCellItem *sqb=[HHCustomerCellItem itemWithTitle:@"申请表" value:applyformImagesCount];
    sqb.type=HHCustomerInfoTypeApplyForm;
    sqb.extensionInfo=[self setupApplyFormItemsByCustomer:customer];
    sqb.images=[self setupApplyFormImagesByCustomer:customer];
    sqb.minImageCount=1;
    
    HHCustomerCellItem *jjlxr=[HHCustomerCellItem itemWithTitle:@"紧急联系人" value:nil];
    jjlxr.type=HHCustomerInfoTypeEmergcy;
    jjlxr.extensionInfos=[self setupEmergcyItemsByCustomer:customer];
    jjlxr.images=[self setupEmergcyImagesByCustomer:customer];
    jjlxr.key=@"ContactList";
    jjlxr.noImage=YES;
    
    NSString *otherImagesCount=@(customer.BasicInfo.OtherMaterial.MaterialList.count).stringValue;
    HHCustomerCellItem *other=[HHCustomerCellItem itemWithTitle:@"其他补充材料" value:otherImagesCount];
    other.type=HHCustomerInfoTypeOther;
    other.extensionInfo=[self setupOtherItemsByCustomer:customer];
    other.images=[self setupOtherImagesByCustomer:customer];
    if ([project.CarType isEqualToString:@"X"]) {
        return @[idcard,credit,family,marriage,drive,edu,live,license,djzs,hkzh,yhls,sqb,jjlxr,other];
    }else{
        return @[idcard,credit,family,marriage,drive,edu,live,license,djzs,pgbg,hkzh,yhls,sqb,jjlxr,other];
    }
}
#pragma mark 配偶信息数据源对
//配偶信息
+ (NSArray <HHCustomerCellItem *> *)spouseInfoByCustomer:(HHCustomer *)customer{
    NSString *cardImagesCount=@(customer.SpouseInfo.IDCard.CardList.count).stringValue;
    HHCustomerCellItem *idcard=[HHCustomerCellItem itemWithTitle:@"身份证" value:cardImagesCount];
    idcard.type=HHCustomerInfoTypeSpouseIDCard;
    idcard.extensionInfo=[self setupSpouseIDCardItemsByCustomer:customer];
    idcard.images=[self setupSpouseIDCardImagesByCustomer:customer];
    idcard.minImageCount=2;
    idcard.maxImageCount=2;
    
    NSString *familyImagesCount=@(customer.SpouseInfo.Household.HouseholdList.count).stringValue;
    HHCustomerCellItem *family=[HHCustomerCellItem itemWithTitle:@"户籍" value:familyImagesCount];
    family.type=HHCustomerInfoTypeSpouseFamily;
    family.extensionInfo=[self setupSpouseFamilyItemsByCustomer:customer];
    family.images=[self setupSpouseFamilyImagesByCustomer:customer];
    family.minImageCount=2;
    
    NSString *weddingImagesCount=@(customer.SpouseInfo.Wedding.WeddingList.count).stringValue;
    HHCustomerCellItem *marriage_cer=[HHCustomerCellItem itemWithTitle:@"结婚证" value:weddingImagesCount];
    marriage_cer.type=HHCustomerInfoTypeMarriageCer;
    marriage_cer.images=[self setupSpouseMarriageImagesByCustomer:customer];
    marriage_cer.minImageCount=2;
    
    return @[idcard,family,marriage_cer];
}
#pragma mark 担保人信息数据源对象
//担保人信息
+ (NSArray <HHCustomerCellItem *> *)guarantorInfoByCustomer:(HHCustomer *)customer{
    HHCustomerCellItem *guarantor=[HHCustomerCellItem itemWithTitle:@"担保人类型" value:@"自然人"];
    guarantor.type=HHCustomerInfoTypeGuarantorType;
    
    
    NSString *cardImagesCount=@(customer.GuarantorInfo.IDCard.CardList.count).stringValue;
    HHCustomerCellItem *idcard=[HHCustomerCellItem itemWithTitle:@"身份证" value:cardImagesCount];
    idcard.type=HHCustomerInfoTypeGuarantorIDCard;
    idcard.extensionInfo=[self setupGuarantorIDCardItemsByCustomer:customer];
    idcard.images=[self setupGuaranrorIDCardImagesByCustomer:customer];
    idcard.key=@"GuarantorInfomations";
    idcard.minImageCount=2;
    idcard.maxImageCount=2;
    
    NSString *familyImagesCount=@(customer.GuarantorInfo.Household.HouseholdList.count).stringValue;
    HHCustomerCellItem *family=[HHCustomerCellItem itemWithTitle:@"户籍" value:familyImagesCount];
    family.type=HHCustomerInfoTypeGuarantorFamily;
    family.extensionInfo=[self setupGuarantorFamilyItemsByCustomer:customer];
    family.images=[self setupGuarantorFamilyImagesByCustomer:customer];
    family.minImageCount=2;
    
    
    NSString *creditImagesCount=@(customer.GuarantorInfo.CreditDetail.CreditDetailList.count).stringValue;
    HHCustomerCellItem *credit=[HHCustomerCellItem itemWithTitle:@"征信报告" value:creditImagesCount];
    credit.type=HHCustomerInfoTypeGuarantorCredit;
    credit.extensionInfo=[self setupGuarantorCreditItemsByCustomer:customer];
    credit.images=[self setupGuarantorCreditImagesByCustomer:customer];
    credit.key=@"GuarantorCredit";
    credit.minImageCount=2;
    
    NSString *bankflowImagesCount=@(customer.GuarantorInfo.BankStatement.BankStatementList.count).stringValue;
    HHCustomerCellItem *yhls=[HHCustomerCellItem itemWithTitle:@"银行流水" value:bankflowImagesCount];
    yhls.type=HHCustomerInfoTypeGuarantorBankLow;
    yhls.images=[self setupGuarantorBanklowImagesByCustomer:customer];
    yhls.minImageCount=1;
    
    
    return @[guarantor,idcard,family,credit,yhls];
}
#pragma mark - ********************* 基本信息单项 ************************
//身份证
+ (NSArray <HHCustomerCellItem *> *)setupIDCardItemsByCustomer:(HHCustomer *)customer{
    
    HHCustomerCellItem *name=[HHCustomerCellItem itemWithTitle:@"姓名" value:customer.BasicInfo.IDCard.Name];
    name.type=HHCustomerInfoTypeIDCard;
    name.itemStyle=HHCustomerItemStyleDetail;
    name.key=@"Name";
    
    HHCustomerCellItem *gender=[HHCustomerCellItem itemWithTitle:@"性别" value:customer.BasicInfo.IDCard.Sex.selectMetaData.Key];
    gender.type=HHCustomerInfoTypeIDCard;
    gender.selectMetaData=customer.BasicInfo.IDCard.Sex.selectMetaData;
    gender.metaData=customer.BasicInfo.IDCard.Sex.List;
    gender.itemStyle=HHCustomerItemStyleSelection;
    gender.key=@"Sex";
    
    
    HHCustomerCellItem *birth=[HHCustomerCellItem itemWithTitle:@"出生" value:[self formatBirthDateString:customer.BasicInfo.IDCard.BirthDate]];
    birth.type=HHCustomerInfoTypeIDCard;
    birth.key=@"BirthDate";
    birth.placeholder=@"xxxx-xx-xx";
    
    HHCustomerCellItem *addr=[HHCustomerCellItem itemWithTitle:@"住址" value:customer.BasicInfo.IDCard.IDCardAddress];
    addr.type=HHCustomerInfoTypeIDCard;
    addr.key=@"IDCardAddress";
    
    HHCustomerCellItem *idcard=[HHCustomerCellItem itemWithTitle:@"公民身份证号码" value:customer.BasicInfo.IDCard.IDNumber];
    idcard.type=HHCustomerInfoTypeIDCard;
    idcard.key=@"IDNumber";
    
    return @[name,gender,birth,addr,idcard];
}
+ (NSArray <HHCustomerImage *>*)setupIDCardImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.IDCard.CardList copy];
}
//征信报告
+ (NSArray <HHCustomerCellItem *> *)setupCreditItemsByCustomer:(HHCustomer *)customer{
    
    HHCustomerCellItem *sshy=[HHCustomerCellItem itemWithTitle:@"所属行业" value:customer.BasicInfo.CreditReport.Property];
    sshy.type=HHCustomerInfoTypeCredit;
    //    sshy.selectMetaData=customer.BasicInfo.CreditReport.Property.selectMetaData;
    //    sshy.metaData=customer.BasicInfo.CreditReport.Property.List;
    //    sshy.itemStyle=HHCustomerItemStyleSelection;
    sshy.key=@"Property";
    
    HHCustomerCellItem *zw=[HHCustomerCellItem itemWithTitle:@"职务" value:customer.BasicInfo.CreditReport.Position.selectMetaData.Key];
    zw.selectMetaData=customer.BasicInfo.CreditReport.Position.selectMetaData;
    zw.metaData=customer.BasicInfo.CreditReport.Position.List;
    zw.type=HHCustomerInfoTypeCredit;
    zw.itemStyle=HHCustomerItemStyleSelection;
    zw.key=@"Position";
    
    HHCustomerCellItem *gzdw=[HHCustomerCellItem itemWithTitle:@"工作单位名称" value:customer.BasicInfo.CreditReport.WorkName];
    gzdw.type=HHCustomerInfoTypeCredit;
    gzdw.key=@"WorkName";
    
    HHCustomerCellItem *gznx=[HHCustomerCellItem itemWithTitle:@"工作年限" value:customer.BasicInfo.CreditReport.ServiceYear];
    gznx.type=HHCustomerInfoTypeCredit;
    gznx.key=@"ServiceYear";
    
    HHCustomerCellItem *dwdh=[HHCustomerCellItem itemWithTitle:@"单位电话" value:customer.BasicInfo.CreditReport.WorkPhone];
    dwdh.type=HHCustomerInfoTypeCredit;
    dwdh.key=@"WorkPhone";
    
    HHCustomerCellItem *shsr=[HHCustomerCellItem itemWithTitle:@"申请人税后年收入" value:customer.BasicInfo.CreditReport.Aftertaxincome];
    shsr.type=HHCustomerInfoTypeCredit;
    shsr.key=@"Aftertaxincome";
    
    HHCustomerCellItem *qyxz=[HHCustomerCellItem itemWithTitle:@"企业性质" value:customer.BasicInfo.CreditReport.Industry.selectMetaData.Key];
    qyxz.type=HHCustomerInfoTypeCredit;
    qyxz.selectMetaData=customer.BasicInfo.CreditReport.Industry.selectMetaData;
    qyxz.metaData=customer.BasicInfo.CreditReport.Industry.List;
    qyxz.itemStyle=HHCustomerItemStyleSelection;
    qyxz.key=@"Industry";
    
    
    return @[sshy,zw,gzdw,gznx,dwdh,shsr,qyxz];
}
+ (NSArray <HHCustomerImage *>*)setupCreditImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.CreditReport.ReportList copy];
}
//户籍
+ (NSArray <HHCustomerCellItem *> *)setupFamilyItemsByCustomer:(HHCustomer *)customer{
    
    HHCustomerCellItem *name=[HHCustomerCellItem itemWithTitle:@"姓名" value:customer.BasicInfo.Household.Name];
    name.type=HHCustomerInfoTypeFamily;
    name.key=@"Name";
    
    HHCustomerCellItem *addr=[HHCustomerCellItem itemWithTitle:@"户籍所在地" value:customer.BasicInfo.Household.DomicilePlace];
    addr.type=HHCustomerInfoTypeFamily;
    addr.key=@"DomicilePlace";
    
    HHCustomerCellItem *oldname=[HHCustomerCellItem itemWithTitle:@"曾用名" value:customer.BasicInfo.Household.UsedName];
    oldname.type=HHCustomerInfoTypeFamily;
    oldname.key=@"UsedName";
    
    
    return @[name,addr,oldname];
}
+ (NSArray <HHCustomerImage *> *)setupFamilyImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.Household.UrlList copy];
}
//婚姻证明
+ (NSArray <HHCustomerCellItem *> *)setupMarriageItemsByCustomer:(HHCustomer *)customer{
    HHCustomerCellItem *num=[HHCustomerCellItem itemWithTitle:@"婚姻状况" value:customer.BasicInfo.Wedding.CivilState.selectMetaData.Key];
    num.type=HHCustomerInfoTypeMarriage;
    num.itemStyle=HHCustomerItemStyleSelection;
    num.selectMetaData=customer.BasicInfo.Wedding.CivilState.selectMetaData;
    num.metaData=customer.BasicInfo.Wedding.CivilState.List;
    num.key=@"CivilState";
    return @[num];
}
+ (NSArray <HHCustomerImage *>*)setupMarriageImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.Wedding.WeddingList copy];
}
//驾驶证
+ (NSArray <HHCustomerCellItem *> *)setupDriveItemsByCustomer:(HHCustomer *)customer{
    
    HHCustomerCellItem *name=[HHCustomerCellItem itemWithTitle:@"驾驶员姓名" value:customer.BasicInfo.Driver.DriverName];
    name.type=HHCustomerInfoTypeDrive;
    name.key=@"DriverName";
    
    HHCustomerCellItem *num=[HHCustomerCellItem itemWithTitle:@"驾驶证号码" value:customer.BasicInfo.Driver.DriverIDCard];
    num.type=HHCustomerInfoTypeDrive;
    num.key=@"DriverIDCard";
    
    return @[name,num];
}
+ (NSArray <HHCustomerImage *>*)setupDriveImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.Driver.DriverList copy];
}
//学历证明
+ (NSArray <HHCustomerCellItem *> *)setupEduItemsByCustomer:(HHCustomer *)customer{
    HHCustomerCellItem *num=[HHCustomerCellItem itemWithTitle:@"学历" value:customer.BasicInfo.Education.EducateGrade.selectMetaData.Key];
    num.type=HHCustomerInfoTypeEdu;
    num.itemStyle=HHCustomerItemStyleSelection;
    num.selectMetaData=customer.BasicInfo.Education.EducateGrade.selectMetaData;
    num.metaData=customer.BasicInfo.Education.EducateGrade.List;
    num.key=@"CR_EDUCATION";
    return @[num];
}
+ (NSArray <HHCustomerImage *>*)setupEduImagesByCustomer:(HHCustomer *)customer{
    return nil;
}
//居住证明
+ (NSArray <HHCustomerCellItem *> *)setupLiveItemsByCustomer:(HHCustomer *)customer{
    
    HHCustomerCellItem *state=[HHCustomerCellItem itemWithTitle:@"居住状态" value:customer.BasicInfo.ProofOfResidence.LIVINGSTATUS.selectMetaData.Key];
    state.type=HHCustomerInfoTypeLive;
    state.itemStyle=HHCustomerItemStyleSelection;
    state.selectMetaData=customer.BasicInfo.ProofOfResidence.LIVINGSTATUS.selectMetaData;
    state.metaData=customer.BasicInfo.ProofOfResidence.LIVINGSTATUS.List;
    state.key=@"LIVINGSTATUS";
    
    HHCustomerCellItem *idust=[HHCustomerCellItem itemWithTitle:@"房屋性质" value:customer.BasicInfo.ProofOfResidence.CR_HOUSE_TYPE.selectMetaData.Key];
    idust.itemStyle=HHCustomerItemStyleSelection;
    idust.selectMetaData=customer.BasicInfo.ProofOfResidence.CR_HOUSE_TYPE.selectMetaData;
    idust.metaData=customer.BasicInfo.ProofOfResidence.CR_HOUSE_TYPE.List;
    idust.type=HHCustomerInfoTypeLive;
    idust.key=@"CR_HOUSE_TYPE";
    
    HHCustomerCellItem *year=[HHCustomerCellItem itemWithTitle:@"现居住年限" value:customer.BasicInfo.ProofOfResidence.LIVINGLIFE.selectMetaData.Key];
    year.type=HHCustomerInfoTypeLive;
    year.itemStyle=HHCustomerItemStyleSelection;
    year.selectMetaData=customer.BasicInfo.ProofOfResidence.LIVINGLIFE.selectMetaData;
    year.metaData=customer.BasicInfo.ProofOfResidence.LIVINGLIFE.List;
    year.key=@"LIVINGLIFE";
    
    HHCustomerCellItem *addr=[HHCustomerCellItem itemWithTitle:@"现居住地址" value:customer.BasicInfo.ProofOfResidence.CR_NATU_MAILING_ADDRESS];
    addr.type=HHCustomerInfoTypeLive;
    addr.key=@"CR_NATU_MAILING_ADDRESS";
    
    
    
    return @[state,idust,year,addr];
}
+ (NSArray <HHCustomerImage *>*)setupLiveImagesByCustomer:(HHCustomer *)customer{
    
    return [customer.BasicInfo.ProofOfResidence.ProofList copy];
}
//行驶证
+ (NSArray <HHCustomerCellItem *> *)setupLicenseItemsByCustomer:(HHCustomer *)customer{
    return nil;
}
+ (NSArray <HHCustomerImage *>*)setupLicenseImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.DrivingLicense.DrivingLicenseList copy];
}
//登记证
+ (NSArray <HHCustomerCellItem *> *)setupRegisterItemsByCustomer:(HHCustomer *)customer{
    return nil;
}
+ (NSArray <HHCustomerImage *>*)setupRegisterImagesByCustomer:(HHCustomer *)customer{
    
    return [customer.BasicInfo.Registration.RegistrationList copy];
}
//评估报告
+ (NSArray <HHCustomerCellItem *> *)setupAssessItemsByCustomer:(HHCustomer *)customer{
    return nil;
}
+ (NSArray <HHCustomerImage *>*)setupAssessImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.CarAssessReport.CarAssessReportList copy];
}



//还款账户
+ (NSArray <NSArray <HHCustomerCellItem *> *> *)setupPayAccItemsByCustomer:(HHCustomer *)customer{
    
    NSMutableArray *temp=[NSMutableArray array];
    for (int i=0; i<customer.BasicInfo.RepaymentAccount.OtherAccount.count+1; i++) {
        HHCustomerPayAcct *acct= i==0?customer.BasicInfo.RepaymentAccount.MainAccount:customer.BasicInfo.RepaymentAccount.OtherAccount[i-1];
        HHCustomerCellItem *name=[HHCustomerCellItem itemWithTitle:@"户名" value:acct.BankName];
        name.type=HHCustomerInfoTypePayAccount;
        name.key=@"BankName";
        
        HHCustomerCellItem *bank=[HHCustomerCellItem itemWithTitle:@"开户行" value:acct.BankAdd];
        bank.type=HHCustomerInfoTypePayAccount;
        bank.key=@"BankAdd";
        
        HHCustomerCellItem *num=[HHCustomerCellItem itemWithTitle:@"银行账户" value:acct.BankAccount];
        num.type=HHCustomerInfoTypePayAccount;
        num.key=@"BankAccount";
        
        HHCustomerCellItem *tel=[HHCustomerCellItem itemWithTitle:@"预留手机号码" value:acct.BankMobile];
        tel.type=HHCustomerInfoTypePayAccount;
        tel.key=@"BankMobile";
        
        [temp addObject:@[name,bank,num,tel]];
    }
    
    return [temp copy];
}
+ (NSArray <HHCustomerImage *>*)setupPayAccImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.RepaymentAccount.CardList copy];
}
//银行卡流水
+ (NSArray <HHCustomerCellItem *> *)setupBankLowItemsByCustomer:(HHCustomer *)customer{
    return nil;
}
+ (NSArray <HHCustomerImage *>*)setupBanklowImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.BankStatements.StatementsList copy];
}
//申请表
+ (NSArray <HHCustomerCellItem *> *)setupApplyFormItemsByCustomer:(HHCustomer *)customer{
    return nil;
}
+ (NSArray <HHCustomerImage *>*)setupApplyFormImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.ApplicationForm.ApplicationFormList copy];
}
//紧急联系人
+ (NSArray <NSArray <HHCustomerCellItem *> *> *)setupEmergcyItemsByCustomer:(HHCustomer *)customer{
    NSMutableArray *temp=[NSMutableArray array];
    NSLog(@"紧急联系人数量=======%d",customer.BasicInfo.CrashContactPerson.ContactList.count);
    if (customer.BasicInfo.CrashContactPerson.ContactList.count > 0) {
        for (int i=0; i<customer.BasicInfo.CrashContactPerson.ContactList.count; i++) {
            HHCustomerContact *contact=customer.BasicInfo.CrashContactPerson.ContactList[i];
            HHCustomerCellItem *people=[HHCustomerCellItem itemWithTitle:[NSString stringWithFormat:@"联系人%d", i+1]value:contact.LinkPeople];
            people.type=HHCustomerInfoTypeEmergcy;
            people.key=@"LinkPeople";
            people.itemStyle = HHCustomerItemStyleDetail;
            HHCustomerCellItem *name=[HHCustomerCellItem itemWithTitle:@"姓名" value:contact.LinkName];
            name.type=HHCustomerInfoTypeEmergcy;
            name.key=@"LinkName";
            HHCustomerCellItem *tel=[HHCustomerCellItem itemWithTitle:@"手机号码" value:contact.LinkMobile];
            tel.type=HHCustomerInfoTypeEmergcy;
            tel.key=@"LinkMobile";
            HHCustomerCellItem *addr=[HHCustomerCellItem itemWithTitle:@"现居住地址" value:contact.LinkAddress];
            addr.type=HHCustomerInfoTypeEmergcy;
            addr.key=@"LinkAddress";
            [temp addObject:@[people,name,tel,addr]];
        }
    }else{
        NSLog(@"没有添加联系人");
        for (int i=0; i<customer.BasicInfo.CrashContactPerson.ContactList.count+2; i++) {
            HHCustomerContact *contact=customer.BasicInfo.CrashContactPerson.MainAccount;
            HHCustomerCellItem *people=[HHCustomerCellItem itemWithTitle:[NSString stringWithFormat:@"联系人%d", i+1]value:contact.LinkPeople];
            people.type=HHCustomerInfoTypeEmergcy;
            people.key=@"LinkPeople";
            people.itemStyle = HHCustomerItemStyleDetail;
            HHCustomerCellItem *name=[HHCustomerCellItem itemWithTitle:@"姓名" value:contact.LinkName];
            name.type=HHCustomerInfoTypeEmergcy;
            name.key=@"LinkName";
            HHCustomerCellItem *tel=[HHCustomerCellItem itemWithTitle:@"手机号码" value:contact.LinkMobile];
            tel.type=HHCustomerInfoTypeEmergcy;
            tel.key=@"LinkMobile";
            HHCustomerCellItem *addr=[HHCustomerCellItem itemWithTitle:@"现居住地址" value:contact.LinkAddress];
            addr.type=HHCustomerInfoTypeEmergcy;
            addr.key=@"LinkAddress";
            [temp addObject:@[people,name,tel,addr]];
        }
    }
        return [temp copy];
}
+ (NSArray <HHCustomerImage *>*)setupEmergcyImagesByCustomer:(HHCustomer *)customer{
    return nil;
}
//其他补充材料
+ (NSArray <HHCustomerCellItem *> *)setupOtherItemsByCustomer:(HHCustomer *)customer{
    return nil;
}
+ (NSArray <HHCustomerImage *>*)setupOtherImagesByCustomer:(HHCustomer *)customer{
    return [customer.BasicInfo.OtherMaterial.MaterialList copy];
}
#pragma mark - ******************配偶信息********************
//配偶身份证
+ (NSArray <HHCustomerCellItem *> *)setupSpouseIDCardItemsByCustomer:(HHCustomer *)customer{
    
    HHCustomerCellItem *name=[HHCustomerCellItem itemWithTitle:@"姓名" value:customer.SpouseInfo.IDCard.Name];
    name.type=HHCustomerInfoTypeSpouseIDCard;
    name.key=@"SpouseInfosName";
    
    HHCustomerCellItem *gender=[HHCustomerCellItem itemWithTitle:@"性别" value:customer.SpouseInfo.IDCard.Sex.selectMetaData.Key];
    gender.type=HHCustomerInfoTypeSpouseIDCard;
    gender.selectMetaData=customer.SpouseInfo.IDCard.Sex.selectMetaData;
    gender.metaData=customer.SpouseInfo.IDCard.Sex.List;
    gender.itemStyle=HHCustomerItemStyleSelection;
    gender.key=@"SpouseInfosSex";
    
    HHCustomerCellItem *birth=[HHCustomerCellItem itemWithTitle:@"出生" value:[self formatBirthDateString:customer.SpouseInfo.IDCard.BirthDate]];
    birth.type=HHCustomerInfoTypeSpouseIDCard;
    birth.key=@"SpouseInfosCS";
    birth.placeholder=@"xxxx-xx-xx";
    
    HHCustomerCellItem *addr=[HHCustomerCellItem itemWithTitle:@"住址" value:customer.SpouseInfo.IDCard.IDCardAddress];
    addr.type=HHCustomerInfoTypeSpouseIDCard;
    addr.key=@"SpouseInfosAddress";
    
    HHCustomerCellItem *idcard=[HHCustomerCellItem itemWithTitle:@"公民身份证号码" value:customer.SpouseInfo.IDCard.IDNumber];
    idcard.type=HHCustomerInfoTypeSpouseIDCard;
    idcard.key=@"SpouseInfosCard";
    
    return @[name,gender,birth,addr,idcard];
}
+ (NSArray <HHCustomerImage *>*)setupSpouseIDCardImagesByCustomer:(HHCustomer *)customer{
    return [customer.SpouseInfo.IDCard.CardList copy];
}
//配偶户籍
+ (NSArray <HHCustomerCellItem *> *)setupSpouseFamilyItemsByCustomer:(HHCustomer *)customer{
    return nil;
}
+ (NSArray <HHCustomerImage *>*)setupSpouseFamilyImagesByCustomer:(HHCustomer *)customer{
    return [customer.SpouseInfo.Household.HouseholdList copy];
}
+ (NSArray <HHCustomerImage *>*)setupSpouseMarriageImagesByCustomer:(HHCustomer *)customer{
    return [customer.SpouseInfo.Wedding.WeddingList copy];
}
#pragma mark - ******************担保人信息********************
+ (NSArray <HHCustomerCellItem *> *)setupGuarantorTypeItemsByCustomer:(HHCustomer *)customer{
    return nil;
}
+ (NSArray <HHCustomerCellItem *> *)setupGuarantorIDCardItemsByCustomer:(HHCustomer *)customer{
    HHCustomerCellItem *name=[HHCustomerCellItem itemWithTitle:@"姓名" value:customer.GuarantorInfo.IDCard.Name];
    name.type=HHCustomerInfoTypeGuarantorIDCard;
    name.key=@"GuarantorName";
    
    HHCustomerCellItem *gender=[HHCustomerCellItem itemWithTitle:@"性别" value:customer.GuarantorInfo.IDCard.Sex.selectMetaData.Key];
    gender.type=HHCustomerInfoTypeGuarantorIDCard;
    gender.itemStyle=HHCustomerItemStyleSelection;
    gender.selectMetaData=customer.GuarantorInfo.IDCard.Sex.selectMetaData;
    gender.metaData=customer.GuarantorInfo.IDCard.Sex.List;
    gender.key=@"GuarantorSex";
    
    HHCustomerCellItem *birth=[HHCustomerCellItem itemWithTitle:@"出生" value:[self formatBirthDateString:customer.GuarantorInfo.IDCard.BirthDate]];
    birth.type=HHCustomerInfoTypeGuarantorIDCard;
    birth.key=@"GuarantorCS";
    birth.placeholder=@"xxxx-xx-xx";
    
    HHCustomerCellItem *addr=[HHCustomerCellItem itemWithTitle:@"住址" value:customer.GuarantorInfo.IDCard.IDCardAddress];
    addr.type=HHCustomerInfoTypeGuarantorIDCard;
    addr.key=@"GuarantorAddress";
    
    HHCustomerCellItem *idcard=[HHCustomerCellItem itemWithTitle:@"公民身份证号码" value:customer.GuarantorInfo.IDCard.IDNumber];
    idcard.type=HHCustomerInfoTypeGuarantorIDCard;
    idcard.key=@"GuarantorCard";
    
    return @[name,gender,birth,addr,idcard];
}
+ (NSArray <HHCustomerImage *>*)setupGuaranrorIDCardImagesByCustomer:(HHCustomer *)customer{
    return [customer.GuarantorInfo.IDCard.CardList copy];
}
//户籍
+ (NSArray <HHCustomerCellItem *> *)setupGuarantorFamilyItemsByCustomer:(HHCustomer *)customer{
    return nil;
}
+ (NSArray <HHCustomerImage *>*)setupGuarantorFamilyImagesByCustomer:(HHCustomer *)customer{
    return customer.GuarantorInfo.Household.HouseholdList;
}
//征信
+ (NSArray <HHCustomerCellItem *> *)setupGuarantorCreditItemsByCustomer:(HHCustomer *)customer{
    
    ;
    
    HHCustomerCellItem *rela=[HHCustomerCellItem itemWithTitle:@"担保人与申请人关系" value:customer.GuarantorInfo.CreditDetail.Guarantorrelation.selectMetaData.Key];
    rela.selectMetaData=customer.GuarantorInfo.CreditDetail.Guarantorrelation.selectMetaData;
    rela.metaData=customer.GuarantorInfo.CreditDetail.Guarantorrelation.List;
    rela.itemStyle=HHCustomerItemStyleSelection;
    rela.type=HHCustomerInfoTypeGuarantorCredit;
    rela.key=@"Guarantorrelation";
    
    HHCustomerCellItem *mob=[HHCustomerCellItem itemWithTitle:@"手机号码" value:customer.GuarantorInfo.CreditDetail.Guarantormobile];
    mob.type=HHCustomerInfoTypeGuarantorCredit;
    mob.key=@"Guarantormobile";
    
    HHCustomerCellItem *shnsr=[HHCustomerCellItem itemWithTitle:@"税后年收入" value:customer.GuarantorInfo.CreditDetail.Guarantorworkincome];
    shnsr.type=HHCustomerInfoTypeGuarantorCredit;
    shnsr.key=@"Guarantorworkincome";
    
    HHCustomerCellItem *work=[HHCustomerCellItem itemWithTitle:@"现工作单位" value:customer.GuarantorInfo.CreditDetail.GuarantorWorkunits];
    work.type=HHCustomerInfoTypeGuarantorCredit;
    work.key=@"GuarantorWorkunits";
    
    HHCustomerCellItem *workAddr=[HHCustomerCellItem itemWithTitle:@"现单位地址" value:customer.GuarantorInfo.CreditDetail.GuarantorWorkAddress];
    workAddr.type=HHCustomerInfoTypeGuarantorCredit;
    workAddr.key=@"GuarantorWorkAddress";
    
    HHCustomerCellItem *homeAddr=[HHCustomerCellItem itemWithTitle:@"现居住地址" value:customer.GuarantorInfo.CreditDetail.GuarantorMaillingAddress];
    homeAddr.type=HHCustomerInfoTypeGuarantorCredit;
    homeAddr.key=@"GuarantorMaillingAddress";
    
    HHCustomerCellItem *date=[HHCustomerCellItem itemWithTitle:@"现居住时间" value:customer.GuarantorInfo.CreditDetail.GuarantorLiveYear];
    date.type=HHCustomerInfoTypeGuarantorCredit;
    date.key=@"GuarantorLiveYear";
    
    
    
    return @[rela,mob,shnsr,work,workAddr,homeAddr,date];
}
+ (NSArray <HHCustomerImage *>*)setupGuarantorCreditImagesByCustomer:(HHCustomer *)customer{
    return [customer.GuarantorInfo.CreditDetail.CreditDetailList copy];
}
//银行卡流水
+ (NSArray <HHCustomerImage *>*)setupGuarantorBanklowImagesByCustomer:(HHCustomer *)customer{
    return [customer.GuarantorInfo.BankStatement.BankStatementList copy];
}
#pragma mark - *****************************************************
+ (NSArray <HHCustomerCellItem *> *)emengercyInfoByCustomerWithSection:(NSInteger )indexSection{
    
    HHCustomerCellItem *people=[HHCustomerCellItem itemWithTitle:[NSString stringWithFormat:@"联系人%d",indexSection+1] value:nil];
    people.type=HHCustomerInfoTypeEmergcy;
    people.key=@"LinkPeople";
    people.itemStyle = HHCustomerItemStyleDetail;
    
    HHCustomerCellItem *name=[HHCustomerCellItem itemWithTitle:@"姓名" value:nil];
    name.type=HHCustomerInfoTypeEmergcy;
    name.key=@"LinkName";
    
    HHCustomerCellItem *tel=[HHCustomerCellItem itemWithTitle:@"手机号码" value:nil];
    tel.type=HHCustomerInfoTypeEmergcy;
    tel.key=@"LinkMobile";
    
    HHCustomerCellItem *addr=[HHCustomerCellItem itemWithTitle:@"现居住地址" value:nil];
    addr.type=HHCustomerInfoTypeEmergcy;
    addr.key=@"LinkAddress";
    
    return @[people,name,tel,addr];
}
+ (NSArray <HHCustomerCellItem *> *)payAccountInfoByCustomer{
    
    HHCustomerCellItem *name=[HHCustomerCellItem itemWithTitle:@"户名" value:nil];
    name.type=HHCustomerInfoTypePayAccount;
    name.key=@"BankName";
    
    HHCustomerCellItem *bank=[HHCustomerCellItem itemWithTitle:@"开户行" value:nil];
    bank.type=HHCustomerInfoTypePayAccount;
    bank.key=@"BankAdd";
    
    HHCustomerCellItem *num=[HHCustomerCellItem itemWithTitle:@"银行账户" value:nil];
    num.type=HHCustomerInfoTypePayAccount;
    num.key=@"BankAccount";
    
    HHCustomerCellItem *tel=[HHCustomerCellItem itemWithTitle:@"预留手机号码" value:nil];
    tel.type=HHCustomerInfoTypePayAccount;
    tel.key=@"BankMobile";
    
    return @[name,bank,num,tel];
}
+ (NSArray <HHCustomerCellItem *> *)IDCardInfoByIDCardItems:(NSArray <HHCustomerCellItem *> *)items IDCard:(HHIDCard *)card nameEditable:(BOOL)nameEditable{
    if (card==nil||card.name.length==0) {
        return items;
    }
    NSMutableArray *temp=[NSMutableArray array];
    if (nameEditable) {
        [temp addObject:card.name?card.name:@""];
    }else{
        [temp addObject:items.firstObject.value];
    }
    [temp addObject:card.gender?card.gender:@""];
    if (card.birthday.month.length ==1&&card.birthday.day.length ==1) {
        [temp addObject:[NSString stringWithFormat:@"%@-0%@-0%@",card.birthday.year,card.birthday.month,card.birthday.day]];
    }else if(card.birthday.month.length ==1){
        [temp addObject:[NSString stringWithFormat:@"%@-0%@-%@",card.birthday.year,card.birthday.month,card.birthday.day]];
    }else if(card.birthday.day.length ==1){
        [temp addObject:[NSString stringWithFormat:@"%@-%@-0%@",card.birthday.year,card.birthday.month,card.birthday.day]];
    }else{
        [temp addObject:[NSString stringWithFormat:@"%@-%@-%@",card.birthday.year,card.birthday.month,card.birthday.day]];
    }
    [temp addObject:card.address?card.address:@""];
    [temp addObject:card.id_card_number?card.id_card_number:@""];
    int i=0;
    for (HHCustomerCellItem *aItem in items) {
        aItem.value=temp[i];
        if ([aItem.title isEqualToString:@"性别"]) {
            for (HHCustomerMetaData *metaData in aItem.metaData) {
                metaData.isSelected=NO;
                if ([metaData.Key isEqualToString:temp[i]]) {
                    metaData.isSelected=YES;
                    aItem.selectMetaData=metaData;
                }
            }
        }
        i++;
    }
    return items;
}

@end
