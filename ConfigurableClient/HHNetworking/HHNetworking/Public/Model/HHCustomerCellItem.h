//
//  HHProjectCellItem.h
//  HHFinancialService
//
//  Created by LWJ on 2016/12/1.
//  Copyright © 2016年 Lxrent. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,HHCustomerInfoType) {
    HHCustomerInfoTypeIDCard,
    HHCustomerInfoTypeCredit,
    HHCustomerInfoTypeFamily,
    HHCustomerInfoTypeMarriage,
    HHCustomerInfoTypeDrive,
    HHCustomerInfoTypeEdu,
    HHCustomerInfoTypeLive,
    HHCustomerInfoTypeLicense,
    HHCustomerInfoTypeRegisterCer,
    HHCustomerInfoTypeAssessRep,
    HHCustomerInfoTypePayAccount,
    HHCustomerInfoTypeBankLow,
    HHCustomerInfoTypeApplyForm,
    HHCustomerInfoTypeEmergcy,
    HHCustomerInfoTypeOther,
    
    HHCustomerInfoTypeSpouseIDCard,
    HHCustomerInfoTypeSpouseFamily,
    HHCustomerInfoTypeMarriageCer,
    
    HHCustomerInfoTypeGuarantorType,
    HHCustomerInfoTypeGuarantorIDCard,
    HHCustomerInfoTypeGuarantorFamily,
    HHCustomerInfoTypeGuarantorCredit,
    HHCustomerInfoTypeGuarantorBankLow

};
typedef NS_ENUM(NSInteger,HHCustomerItemStyle) {
    HHCustomerItemStyleInput,
    HHCustomerItemStyleSelection,
    HHCustomerItemStyleDetail,
    HHCustomerItemStyleImage
};
@class HHCustomerMetaData,HHCustomerImage,HHCustomer,HHIDCard,HHProject;
@interface HHCustomerCellItem : NSObject <NSCopying>
@property (nonatomic, strong) NSString *reuseId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *imageURLKey;
@property (nonatomic, strong) NSString *selectedItemKey;
@property (nonatomic, strong) NSString *imageNamedWord;
@property (nonatomic, assign) BOOL noImage;
@property (nonatomic, assign) NSInteger minImageCount;//default 0
@property (nonatomic, assign) NSInteger maxImageCount;//default NSIntegerMax

@property (nonatomic, assign) HHCustomerInfoType type;
@property (nonatomic, assign) HHCustomerItemStyle itemStyle;

@property (nonatomic, copy) NSArray <HHCustomerCellItem *> *extensionInfo;//单条
@property (nonatomic, copy) NSArray <NSArray <HHCustomerCellItem *> *> *extensionInfos;//多条

@property (nonatomic, strong) HHCustomerMetaData *selectMetaData;
@property (nonatomic, copy) NSArray <HHCustomerMetaData *> *metaData;
@property (nonatomic, copy) NSArray <HHCustomerImage *> *images;

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value;

+ (NSArray <NSArray <HHCustomerCellItem *> *> *)customerInfoItemsByCustomer:(HHCustomer *)customer project:(HHProject *)project;

+ (NSArray <HHCustomerCellItem *> *)customerBaseInfoByCustomer:(HHCustomer *)customer project:(HHProject *)project;
+ (NSArray <HHCustomerCellItem *> *)spouseInfoByCustomer:(HHCustomer *)customer;
+ (NSArray <HHCustomerCellItem *> *)guarantorInfoByCustomer:(HHCustomer *)customer;

+ (NSArray <HHCustomerCellItem *> *)emengercyInfoByCustomerWithSection:(NSInteger )indexSection;
+ (NSArray <HHCustomerCellItem *> *)payAccountInfoByCustomer;

+ (NSArray <HHCustomerCellItem *> *)IDCardInfoByIDCardItems:(NSArray <HHCustomerCellItem *> *)items IDCard:(HHIDCard *)card nameEditable:(BOOL)nameEditable;

@end
