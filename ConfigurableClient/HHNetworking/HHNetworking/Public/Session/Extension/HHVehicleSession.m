//
//  HHVehicleSession.m
//  HHNetworking
//
//  Created by 葛建民 on 16/11/8.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHInterface.h"
#import "HHcar.h"
@implementation HHVehicleSession

-(void)asyncFetchCarBrandsComplete:(HHSessionCompleteBlock)complete{
    

    if (self.brandCache) {
        [self handleBrandData:self.brandCache complete:complete];
        return;
    }
    id diskCache=[self cacheBrand];
    if (diskCache) {
        self.brandCache=diskCache;
        [self handleBrandData:diskCache complete:complete];
        return;
    }
    [HHSecurity sharedInstance].businessLine = kSecVehicleBusinessLine;
    NSString *url=[self urlWithPath:kCustomerCarGetCarBrands];

    [self DATA:url params:nil complete:^(id response, HHError *error) {
        if (response) {

            self.brandCache=response[@"Data"];
            [self setCacheBrand:response[@"Data"]];
            [self handleBrandData:response[@"Data"] complete:complete];
        }else {
            if (complete) {
                complete(nil,error);
            }
        }
    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;
}
- (void)asyncFetchCarSeriesByBid:(NSInteger)bid complete:(HHSessionCompleteBlock)complete{

    if (self.seriesCache[@(bid).stringValue]) {
        [self handleSeriseData:self.seriesCache[@(bid).stringValue] complete:complete];
        return;
    }
    id diskCache=[self cacheSeriesByBrandId:bid];
    if (diskCache) {
        [self.seriesCache setObject:diskCache forKey:@(bid).stringValue];
        [self handleSeriseData:diskCache complete:complete];
        return;
    }
    [HHSecurity sharedInstance].businessLine = kSecVehicleBusinessLine;
    NSString *url=[self urlWithPath:kCustomerCarGetSeries];

    [self DATA:url params:@{@"brandId":@(bid)} complete:^(id response, HHError *error) {
        if (response) {
            [self.seriesCache setObject:response[@"Data"] forKey:@(bid).stringValue];
            [self setCacheSeries:response[@"Data"] brandId:bid];
            [self handleSeriseData:response[@"Data"] complete:complete];
        }else {
            if (complete) {
                complete(nil,error);
            }
        }
        
    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;
}
- (void)asyncFetchCarVehicleBySid:(NSInteger)sid complete:(HHSessionCompleteBlock)complete{
    
    if (self.vehicleCache[@(sid).stringValue]) {
        [self handleVehicleData:self.vehicleCache[@(sid).stringValue] complete:complete];
        return;
    }
    id diskCache=[self cacheVehicleBySeriesId:sid];
    if (diskCache) {
        [self.vehicleCache setObject:diskCache forKey:@(sid).stringValue];
        [self handleVehicleData:diskCache complete:complete];
        return;
    }
    [HHSecurity sharedInstance].businessLine = kSecVehicleBusinessLine;
    NSString *url=[self urlWithPath: kCustomerCarGetVehicles];
    [self DATA:url params:@{@"SeriesId":@(sid)} complete:^(id response, HHError *error) {
        if (response) {
            [self.vehicleCache setObject:response[@"Data"] forKey:@(sid).stringValue];
            [self setCacheVehicle:response[@"Data"] seriesId:sid];
            [self handleVehicleData:response[@"Data"] complete:complete];
        }else {
            if (complete) {
                complete(nil,error);
            }
        }
        
    }];
    [HHSecurity sharedInstance].businessLine=kSecBusinessLine;
}

#pragma mark - ***************车型数据处理********************
- (void)handleBrandData:(id)response complete:(HHSessionCompleteBlock)complete{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *list=response;
        
        NSMutableArray *brands=[HHCarBrand mj_objectArrayWithKeyValuesArray:list];
        NSMutableArray *dataSource=[NSMutableArray array];
        
        if (brands.count>0) {
            HHCarBrand *brand1=brands.firstObject;
            NSMutableArray *zimus=[NSMutableArray arrayWithObject:brand1.Initial];
            for (int i=0; i<brands.count; i++) {
                HHCarBrand *brand_t=brands[i];
                if (![brand1.Initial isEqualToString:brand_t.Initial]&&![zimus containsObject:brand_t.Initial]) {
                    [zimus addObject:[brand_t.Initial stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
                }
            }
            NSArray *sortzimus=[zimus sortedArrayUsingSelector:@selector(compare:)];
            
            for (int m=0; m<sortzimus.count; m++) {
                NSString *zimu=sortzimus[m];
                NSMutableArray *temp=[NSMutableArray array];
                for (int i=0; i<brands.count; i++) {
                    HHCarBrand *brand_t=brands[i];
                    if ([[brand_t.Initial stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:zimu]) {
                        [temp addObject:brand_t];
//                        [brands removeObject:brand_t];
                    }
                }
                [dataSource addObject:@{zimu:temp}];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (complete) {
                complete([dataSource copy],nil);
            }
        });
    });
    
}

- (void)handleSeriseData:(id)response complete:(HHSessionCompleteBlock)complete{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *list=response;
        NSMutableArray *series=[HHCarSeries mj_objectArrayWithKeyValuesArray:list];
        NSMutableArray *dataSource=[NSMutableArray array];
        
        if (series.count>0) {
            HHCarSeries *series1=series.firstObject;
            NSMutableArray *types=[NSMutableArray arrayWithObject:series1.ManufacturerName];
            for (int i=0; i<series.count; i++) {
                HHCarSeries *series_t=series[i];
                if (![series1.ManufacturerName isEqualToString:series_t.ManufacturerName]&&![types containsObject:series_t.ManufacturerName]) {
                    [types addObject:series_t.ManufacturerName];
                }
            }
            NSArray *sorttypes=[types sortedArrayUsingSelector:@selector(compare:)];
            
            for (int m=0; m<sorttypes.count; m++) {
                NSString *type=sorttypes[m];
                NSMutableArray *temp=[NSMutableArray array];
                for (int i=0; i<series.count; i++) {
                    HHCarSeries *series_t=series[i];
                    
                    if ([type isEqualToString:series_t.ManufacturerName]) {
                        [temp addObject:series_t];
//                        [series removeObject:series_t];
                    }
                }
                [dataSource addObject:@{type:temp}];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (complete) {
                complete([dataSource copy],nil);
            }
        });
    });
    
}

- (void)handleVehicleData:(id)response complete:(HHSessionCompleteBlock)complete{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *list=response;//response[@"list"]
        NSMutableArray *vehicles=[HHCarVehicle mj_objectArrayWithKeyValuesArray:list];
        NSMutableArray *dataSource=[NSMutableArray array];
        
        if (vehicles.count>0) {
            HHCarVehicle *vehicle1=vehicles.firstObject;
            NSMutableArray *years=[NSMutableArray arrayWithObject:vehicle1.Year];
            for (int i=0; i<vehicles.count; i++) {
                HHCarVehicle *vechicle_t=vehicles[i];
                if (![vehicle1.Year isEqualToNumber:vechicle_t.Year]&&![years containsObject:vechicle_t.Year]) {
                    [years addObject:vechicle_t.Year];
                }
            }
//            NSArray *sortyears=[years sortedArrayUsingSelector:@selector(compare:)];
            NSArray *sortyears=[years sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                if ([obj1 integerValue]>[obj2 integerValue]) {
                    return NSOrderedAscending;
                }else{
                    return NSOrderedDescending;
                }
            }];

            for (int m=0; m<sortyears.count; m++) {
                NSNumber *year=sortyears[m];
                NSMutableArray *temp=[NSMutableArray array];
                for (int i=0; i<vehicles.count; i++) {
                    HHCarVehicle *vechicle_t=vehicles[i];
                    
                    if ([year isEqualToNumber:vechicle_t.Year]) {
                        [temp addObject:vechicle_t];
//                        [vehicles removeObject:vechicle_t];
                    }
                }
                [dataSource addObject:@{year.stringValue:temp}];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (complete) {
                complete([dataSource copy],nil);
            }
        });
    });
    
}

#pragma mark - *****************车型缓存***********************

- (void)setCacheBrand:(NSArray *)response{
    NSInteger nowTimeStamp=(NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *cachePath=[self dirCarBrandCache];
    NSFileManager *manage=[NSFileManager defaultManager];
    NSArray *array=[manage contentsOfDirectoryAtPath:cachePath error:nil];
    
    for (NSString *filename in array) {
        [manage removeItemAtPath:[cachePath stringByAppendingPathComponent:filename] error:nil];
    }
    NSString *filePath=[NSString stringWithFormat:@"%@/%@.data",cachePath,@(nowTimeStamp).stringValue];
    [response writeToFile:filePath atomically:YES];
}
- (id)cacheBrand{
    NSInteger nowTimeStamp=(NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *cachePath=[self dirCarBrandCache];
    NSFileManager *manage=[NSFileManager defaultManager];
    NSError *error;
    NSString *cacheFileName=[[manage contentsOfDirectoryAtPath:cachePath error:&error] lastObject];
    if (error) {
        return nil;
    }
    NSInteger timestamp=[[cacheFileName stringByDeletingPathExtension] integerValue];
    
    if (nowTimeStamp-timestamp>7*24*60*60) {
        self.cacheExpire=YES;
        return nil;
    }else{
        self.cacheExpire=NO;
        NSString *filePath=[cachePath stringByAppendingPathComponent:cacheFileName];
        return [NSArray arrayWithContentsOfFile:filePath];
    }
    
}
- (void)setCacheSeries:(id)response brandId:(NSInteger)bid{
    NSInteger nowTimeStamp=(NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *cachePath=[self dirCarSeriesCache];
    NSFileManager *manage=[NSFileManager defaultManager];
    NSArray *array=[manage contentsOfDirectoryAtPath:cachePath error:nil];
    
    for (NSString *filename in array) {
        NSArray *items=[[filename stringByDeletingPathExtension] componentsSeparatedByString:@"_"];
        if (bid==[items.firstObject integerValue]) {
            [manage removeItemAtPath:[cachePath stringByAppendingPathComponent:filename] error:nil];
            break;
        }
    }
    NSString *filePath=[NSString stringWithFormat:@"%@/%ld_%@.data",cachePath,bid,@(nowTimeStamp).stringValue];
    [response writeToFile:filePath atomically:YES];
    
}
- (id)cacheSeriesByBrandId:(NSInteger)bid{
    //    NSInteger nowTimeStamp=(NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *cachePath=[self dirCarSeriesCache];
    NSFileManager *manage=[NSFileManager defaultManager];
    NSError *error;
    NSArray *fileNames=[manage contentsOfDirectoryAtPath:cachePath error:&error];
    if (error) {
        return nil;
    }
    for (NSString *name in fileNames) {
        NSArray *items=[[name stringByDeletingPathExtension] componentsSeparatedByString:@"_"];
        if (bid==[items.firstObject integerValue]) {
            //            NSInteger timestamp=[items.lastObject integerValue];
            if (self.cacheExpire) {
                return nil;
            }else{
                NSString *filePath=[cachePath stringByAppendingPathComponent:name];
                return [NSArray arrayWithContentsOfFile:filePath];
            }
        }
    }
    return nil;
}

- (void)setCacheVehicle:(id)response seriesId:(NSInteger)sid{
    NSInteger nowTimeStamp=(NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *cachePath=[self dirCarVehicleCache];
    NSFileManager *manage=[NSFileManager defaultManager];
    NSArray *array=[manage contentsOfDirectoryAtPath:cachePath error:nil];
    
    for (NSString *filename in array) {
        NSArray *items=[[filename stringByDeletingPathExtension] componentsSeparatedByString:@"_"];
        if (sid==[items.firstObject integerValue]) {
            [manage removeItemAtPath:[cachePath stringByAppendingPathComponent:filename] error:nil];
            break;
        }
    }
    NSString *filePath=[NSString stringWithFormat:@"%@/%ld_%@.data",cachePath,sid,@(nowTimeStamp).stringValue];
    [response writeToFile:filePath atomically:YES];
    
    
}
- (id)cacheVehicleBySeriesId:(NSInteger)sid{
    //    NSInteger nowTimeStamp=(NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *cachePath=[self dirCarVehicleCache];
    NSFileManager *manage=[NSFileManager defaultManager];
    NSError *error;
    NSArray *fileNames=[manage contentsOfDirectoryAtPath:cachePath error:&error];
    if (error) {
        return nil;
    }
    for (NSString *name in fileNames) {
        NSArray *items=[[name stringByDeletingPathExtension] componentsSeparatedByString:@"_"];
        if (sid==[items.firstObject integerValue]) {
            //            NSInteger timestamp=[items.lastObject integerValue];
            if (self.cacheExpire) {
                return nil;
            }else{
                NSString *filePath=[cachePath stringByAppendingPathComponent:name];
                return [NSArray arrayWithContentsOfFile:filePath];
            }
        }
    }
    return nil;
    
}


- (void)clearMemoryCache{
    self.brandCache=nil;
    self.seriesCache=nil;
    self.vehicleCache=nil;
}
- (void)clearDiskCache{
    //    NSInteger nowTimeStamp=(NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *brandCachePath=[self dirCarBrandCache];
    NSString *seriesCachePath=[self dirCarSeriesCache];
    NSString *vehicleCachePath=[self dirCarVehicleCache];
    
    NSFileManager *manage=[NSFileManager defaultManager];
    NSArray *array1=[manage contentsOfDirectoryAtPath:brandCachePath error:nil];
    NSArray *array2=[manage contentsOfDirectoryAtPath:seriesCachePath error:nil];
    NSArray *array3=[manage contentsOfDirectoryAtPath:vehicleCachePath error:nil];
    
    for (NSString *filename in array1) {
        [manage removeItemAtPath:[brandCachePath stringByAppendingPathComponent:filename] error:nil];
    }
    for (NSString *filename in array2) {
        [manage removeItemAtPath:[seriesCachePath stringByAppendingPathComponent:filename] error:nil];
    }
    for (NSString *filename in array3) {
        [manage removeItemAtPath:[vehicleCachePath stringByAppendingPathComponent:filename] error:nil];
    }
    
}
- (void)clearAllCache{
    [self clearMemoryCache];
    [self clearDiskCache];
}

- (NSString *)dirCarBrandCache{
    return [self setupCarCacheDir:@"brand"];
}
- (NSString *)dirCarSeriesCache{
    return [self setupCarCacheDir:@"series"];
}
- (NSString *)dirCarVehicleCache{
    return [self setupCarCacheDir:@"vehicle"];
}
- (NSString *)setupCarCacheDir:(NSString *)dir{
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *carCacheDir=[NSString stringWithFormat:@"%@/com.hhauto.cache/cars/%@",cacheFolder,dir];
    NSFileManager *manager=[NSFileManager defaultManager];
    BOOL rs=[manager fileExistsAtPath:carCacheDir];
    NSError *error;
    if (!rs) {
        [manager createDirectoryAtPath:carCacheDir withIntermediateDirectories:YES attributes:nil error:&error];
    }
    if (error) {
        return nil;
    }
    return carCacheDir;
}

@end
