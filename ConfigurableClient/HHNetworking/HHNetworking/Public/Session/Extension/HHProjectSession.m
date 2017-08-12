//
//  HHProjectSession.m
//  HHNetworking
//
//  Created by LWJ on 2016/11/30.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHInterface.h"
#import "HHProject.h"
#import "HHCustomerCellItem.h"
#import "HHUserInfo.h"
@implementation HHProjectSession
- (void)asyncFetchProjectList:(HHList)list complete:(HHSessionCompleteBlock)complete{
    [HHSecurity sharedInstance].businessLine=kSecRZZLBusinessLine;
    NSString *url=[self urlWithPath:kBangGetProjectList];
    [self DATA:url params:@{@"PostModel":@{@"SupplierID":[HHClient sharedInstance].user.FinanceLeaseId,@"rows":@(list.pageSize),@"page":@(list.pageIndex),@"totalRows":@(0),@"totalPages":@(0)}} complete:^(id response, HHError *error) {
        if (response) {
            NSArray *temp=[HHProject mj_objectArrayWithKeyValuesArray:response[@"Data"][@"Data"]];
            complete([temp copy],nil);
        }else{
            complete(nil,error);
        }
    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;

}
- (void)asyncDeleteProject:(HHProject *)project complete:(HHSessionCompleteBlock)complete{
    [HHSecurity sharedInstance].businessLine=kSecRZZLBusinessLine;
    NSString *url=[self urlWithPath:kBangDeleteQuotation];
    [self DATA:url params:@{@"PostModel":@{@"Project_ID":project.ProjectID,@"Suppliers_ID":[HHClient sharedInstance].user.FinanceLeaseId}} complete:^(id response, HHError *error) {
        if (response) {
            complete(response,nil);
        }else{
            complete(nil,error);
        }

    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;
}
- (void)asyncFetchProjectInfoById:(NSString *)pid complete:(HHSessionCompleteBlock)complete{
    [HHSecurity sharedInstance].businessLine=kSecRZZLBusinessLine;
    NSString *url=[self urlWithPath:kBangGetProjectInfo];
    [self DATA:url params:@{@"PostModel":@{@"Supplier_Id":[HHClient sharedInstance].user.FinanceLeaseId,@"Project_Id":pid}} complete:^(id response, HHError *error) {
        if (response) {
            HHCustomer *customer=[HHCustomer mj_objectWithKeyValues:response[@"Data"]];
            complete(customer,nil);

        }else{
            complete(nil,error);
        }
    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;

}
- (void)asyncSaveCustomerInfo:(HHCustomerCellItem *)item projectId:(NSString *)projectId complete:(HHSessionCompleteBlock)complete{
    [HHSecurity sharedInstance].businessLine=kSecRZZLBusinessLine;

    NSString *url;
    switch (item.type) {
        case HHCustomerInfoTypeIDCard:
            url=[self urlWithPath:kBangAddIDCard];
            break;
        case HHCustomerInfoTypeCredit:
            url=[self urlWithPath:kBangAddDetailCredit];
            break;
        case HHCustomerInfoTypeFamily:
            url=[self urlWithPath:kBangAddResidence];
            break;
        case HHCustomerInfoTypeMarriage:
            url=[self urlWithPath:kBangAddCivilState];
            break;
        case HHCustomerInfoTypeDrive:
            url=[self urlWithPath:kBangAddDriver];
            break;
        case HHCustomerInfoTypeEdu:
            url=[self urlWithPath:kBangAddEducation];
            break;
        case HHCustomerInfoTypeLive:
            url=[self urlWithPath:kBangAddProofOfResidence];
            break;
        case HHCustomerInfoTypeLicense:
            url=[self urlWithPath:kBangAddDrivingLicense];
            break;
        case HHCustomerInfoTypeRegisterCer:
            url=[self urlWithPath:kBangAddRegistCer];
            break;
        case HHCustomerInfoTypeAssessRep:
            url=[self urlWithPath:kBangAddCarAssessReport];
            break;
        case HHCustomerInfoTypePayAccount:
            url=[self urlWithPath:kBangAddRepaymentAccount];
            break;
        case HHCustomerInfoTypeBankLow:
            url=[self urlWithPath:kBangAddBankLow];
            break;
        case HHCustomerInfoTypeApplyForm:
            url=[self urlWithPath:kBangAddApplicationForm];
            break;
        case HHCustomerInfoTypeEmergcy:
            url=[self urlWithPath:kBangEmergcyContact];
            break;
        case HHCustomerInfoTypeOther:
            url=[self urlWithPath:kBangAddOtherAddFile];
            break;
        case HHCustomerInfoTypeSpouseIDCard:
            url=[self urlWithPath:kBangSaveSpouseInfo];
            break;
        case HHCustomerInfoTypeSpouseFamily:
            url=[self urlWithPath:kBangAddSpouseResidence];
            break;
        case HHCustomerInfoTypeMarriageCer:
            url=[self urlWithPath:kBangAddMarriageCer];
            break;
        case HHCustomerInfoTypeGuarantorIDCard:
            url=[self urlWithPath:kBangSaveGuarantorCard];
            break;
        case HHCustomerInfoTypeGuarantorFamily:
            url=[self urlWithPath:kBangAddGuarantorResidence];
            break;
        case HHCustomerInfoTypeGuarantorCredit:
            url=[self urlWithPath:kBangSaveGuarantorCredit];
            break;
        case HHCustomerInfoTypeGuarantorBankLow:
            url=[self urlWithPath:kBangAddGuarantorBankCard];
            break;

        default:
            break;
    }
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"Project_Id"]=projectId;
    dict[@"Supplier_Id"]=[HHClient sharedInstance].user.FinanceLeaseId;
    dict[@"Supplier_Employee_Id"]=[HHClient sharedInstance].user.EmployeeId;

    if (item.type==HHCustomerInfoTypePayAccount) {//还款账户 多项 有图
        NSMutableDictionary *temp1=[NSMutableDictionary dictionary];
        NSMutableArray *temp2=[NSMutableArray array];

        for (int i=0; i<item.extensionInfos.count; i++) {
            if (i>0) {
                NSMutableDictionary *temp3=[NSMutableDictionary dictionary];
                for (HHCustomerCellItem *subItem in item.extensionInfos[i]) {
                    if (subItem.itemStyle==HHCustomerItemStyleSelection) {
                        temp3[subItem.key]=subItem.selectMetaData.Value;
                    }else{
                        temp3[subItem.key]=subItem.value;
                    }
                }
                [temp2 addObject:temp3];
            }else{
                for (HHCustomerCellItem *subItem in item.extensionInfos[i]) {
                    if (subItem.itemStyle==HHCustomerItemStyleSelection) {
                        temp1[subItem.key]=subItem.selectMetaData.Value;
                    }else{
                        temp1[subItem.key]=subItem.value;
                    }
                }

            }
            dict[@"MainAccount"]=temp1;
            dict[@"OtherAccount"]=temp2;
            NSMutableArray *temp1=[NSMutableArray array];
            for (HHCustomerImage *image in item.images) {
                [temp1 addObject:image.mj_keyValues];
            }
            dict[item.imageURLKey]=temp1;

        }
    }else{
        if (item.extensionInfos.count>0) {//多项无图
            NSMutableArray *temp1=[NSMutableArray array];
            for (NSArray *array in item.extensionInfos) {
                NSMutableDictionary *temp2=[NSMutableDictionary dictionary];
                
                for (HHCustomerCellItem *subItem in array) {
                    if (subItem.itemStyle==HHCustomerItemStyleSelection) {
                        temp2[subItem.key]=subItem.selectMetaData.Value;
                    }else{
                        temp2[subItem.key]=subItem.value;
                    }
                }
                [temp1 addObject:temp2];
            }
            dict[item.key]=temp1;
        }else{//单项有图
            if (item.key.length>0) {//值包含在单独key内
                NSMutableDictionary *temp1=[NSMutableDictionary dictionary];

                for (HHCustomerCellItem *subItem in item.extensionInfo) {
                    if (subItem.itemStyle==HHCustomerItemStyleSelection) {
                        temp1[subItem.key]=subItem.selectMetaData.Value;
                    }else{
                        temp1[subItem.key]=subItem.value;
                    }
                }
                dict[item.key]=temp1;
            }else{//值在最外层
                for (HHCustomerCellItem *subItem in item.extensionInfo) {
                    if (subItem.itemStyle==HHCustomerItemStyleSelection) {
                        dict[subItem.key]=subItem.selectMetaData.Value;
                    }else{
                        dict[subItem.key]=subItem.value;
                    }
                }

            }
            NSMutableArray *temp1=[NSMutableArray array];
            for (HHCustomerImage *image in item.images) {
                [temp1 addObject:image.mj_keyValues];
            }
            dict[item.imageURLKey]=temp1;

        }
    }
    [self DATA:url params:@{@"PostModel":dict} complete:^(id response, HHError *error) {
        if (response) {
            complete(response,nil);
            
        }else{
            complete(nil,error);
        }
    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;
}
- (void)asyncSubmitProject:(HHProject *)project complete:(HHSessionCompleteBlock)complete{
    [HHSecurity sharedInstance].businessLine=kSecRZZLBusinessLine;
    NSString *url=[self urlWithPath:kBangSumbitProject];
    [self DATA:url params:@{@"PostModel":@{@"Supplier_Id":[HHClient sharedInstance].user.FinanceLeaseId,@"Project_Id":project.ProjectID}} complete:^(id response, HHError *error) {
        if (response) {
            complete(response,nil);
            
        }else{
            complete(nil,error);
        }
    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;

}
- (void)asyncOCRWithIDCardImage:(UIImage *)image complete:(HHSessionCompleteBlock)complete{
    NSString *url=kFacePlusOCRIDCard;
    
    HHFile *file=[[HHFile alloc] init];
    file.data=UIImageJPEGRepresentation(image, 0.5);
    file.key=@"image";
    file.mimeType=@"image/jpeg";
    file.name=[NSString stringWithFormat:@"%d.jpg",(int)[[NSDate date] timeIntervalSince1970]];
    [self FILE:url params:@{@"api_key":kFaceID_APP_KEY,@"api_secret":kFaceID_APP_SECRET,@"legality":@"0"} files:@[file] HTTPHeader:nil complete:^(id response, HHError *error) {
        
        if (response) {
            FMWLog(@"\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",url,response);
            HHIDCard *idcard=[HHIDCard mj_objectWithKeyValues:response];
            complete(idcard,nil);
        }else{
            FMWLog(@"error:%@",error);
            if (complete) {
                complete(nil,error);
            }
        }
        
    }];
}

@end
