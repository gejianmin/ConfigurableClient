//
//  HHDataSession.m
//  HHNetworking
//
//  Created by LWJ on 2016/12/17.
//  Copyright © 2016年 HHAuto. All rights reserved.
//



#import "HHInterface.h"
@implementation HHDataSession
- (void)asyncFetchProjectInfoBySupplierIDWithType:(NSInteger )DataType complete:(HHSessionCompleteBlock)complete{
    [HHSecurity sharedInstance].businessLine=kSecRZZLBusinessLine;
    NSString *url;
    if (DataType == 0) {
        url=[self urlWithPath:kBangSPReportGetAPPListByDay];
    }else if (DataType == 1){
        url=[self urlWithPath:kBangSPReportGetAPPListByWeek];
    }else if (DataType == 2){
        url=[self urlWithPath:kBangSPReportGetAPPListByMonth];
    }else if (DataType == 3){
        url=[self urlWithPath:kBangSPReportGetAPPListByQuarter];
    }else if (DataType == 4){
        url=[self urlWithPath:kBangSPReportGetAPPListByYear];
    }else if (DataType == 5){
        url=[self urlWithPath:kBangSPReportGetPayListByDay];
    }else if (DataType == 6){
        url=[self urlWithPath:kBangSPReportGetPayListByWeek];
    }else if (DataType == 7){
        url=[self urlWithPath:kBangSPReportGetPayListByMonth];
    }else if (DataType == 8){
        url=[self urlWithPath:kBangSPReportGetPayListByQuarter];
    }else if (DataType == 9){
        url=[self urlWithPath:kBangSPReportGetPayListByYear];
    }else if (DataType == 10){
        url=[self urlWithPath:kBangSPReportRefuseAndTimeOut];
    }
    [self DATA:url params:@{@"PostModel":@{@"SupplierID":[HHClient sharedInstance].user.FinanceLeaseId}} complete:^(id response,HHError *error) {
        if (response) {
            //HHDataStatisticsData *dataStatistics=[HHDataStatisticsData mj_objectArrayWithKeyValuesArray:response[@"Data"]];
            HHDataStatisticsData *dataStatistics;
            if (DataType == 10) {
                NSLog(@"预期数据：%@",response);
                dataStatistics=[HHDataStatisticsData mj_objectWithKeyValues:response[@"Data"]];

//                if (dataStatistics.Data.count > 0) {
                    dataStatistics.refuseData = [[HHRefuseData alloc]init];
                    NSDictionary * dict = dataStatistics.Refuse;
                    dataStatistics.refuseData.OrderNum =[NSString stringWithFormat:@"%@",dict[@"OrderNum"]] ;
                    dataStatistics.refuseData.OrderAmount =[NSString stringWithFormat:@"%@", dict[@"OrderAmount"]];
                    dataStatistics.timeOutData = [[HHTimeOut alloc]init];
                    NSDictionary * dict2 = dataStatistics.TimeOut;
                    dataStatistics.timeOutData.OrderNum =[NSString stringWithFormat:@"%@",dict2[@"OrderNum"]] ;
                    dataStatistics.timeOutData.OrderAmount =[NSString stringWithFormat:@"%@", dict2[@"OrderAmount"]];
//                }
            }else{
               dataStatistics=[HHDataStatisticsData mj_objectWithKeyValues:response[@"Data"]];

                if (dataStatistics.Data.count > 0) {
                    for (int i =0; i< dataStatistics.Data.count; i++) {
                        dataStatistics.DateRange = dataStatistics.Data[i][@"DateRange"];
                        dataStatistics.OrderNum = dataStatistics.Data[i][@"OrderNum"];
                        dataStatistics.OrderAmount = dataStatistics.Data[i][@"OrderAmount"];
                    }
                    NSDictionary * model = dataStatistics.Model;
                    dataStatistics.TotalData = [[HHTotalData alloc]init];
                    dataStatistics.TotalData.Title = model[@"Title"];
                    dataStatistics.TotalData.OrderNum =[NSString stringWithFormat:@"%@",model[@"OrderNum"]] ;
                    dataStatistics.TotalData.OrderAmount =[NSString stringWithFormat:@"%@", model[@"OrderAmount"]];
                    
                    dataStatistics.HbData = [[HHDataHbData alloc]init];
                    NSDictionary * dict = dataStatistics.Model[@"hb"];
                    dataStatistics.HbData.DownOrUp_Num =[dict[@"DownOrUp_Num"] boolValue];
                    dataStatistics.HbData.DownOrUp_Amount =[dict[@"DownOrUp_Amount"] boolValue];
                    dataStatistics.HbData.Margin_Num =dict[@"Margin_Num"];
                    dataStatistics.HbData.Margin_Amount =dict[@"Margin_Amount"];
                    
                    dataStatistics.tbData = [[HHDataTbData alloc]init];
                    NSDictionary * dict2 = dataStatistics.Model[@"tb"];
                    dataStatistics.tbData.DownOrUp_Num =[dict2[@"DownOrUp_Num"] boolValue];
                    dataStatistics.tbData.DownOrUp_Amount =[dict2[@"DownOrUp_Amount"] boolValue];
                    dataStatistics.tbData.Margin_Num =dict2[@"Margin_Num"];
                    dataStatistics.tbData.Margin_Amount =dict2[@"Margin_Amount"];
                }
            }
                complete(dataStatistics,nil);
        }else{
            complete(nil,error);
        }
    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;
}

@end
