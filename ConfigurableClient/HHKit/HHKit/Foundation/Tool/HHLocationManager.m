//
//  HHLocationManager.m
//  HHKit
//
//  Created by LWJ on 16/7/21.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHLocationManager.h"
#import <UIKit/UIKit.h>
#import "PrivateHeader.h"

NSString *const kLocationDidUpdateNotification=@"kLocationDidUpdateNotification";

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0)
#define LocationDictLongitude(x) [(x)[@"longitude"] doubleValue]
#define LocationDictLatitude(x) [(x)[@"latitude"] doubleValue]

#define locationPromptTitle @"定位服务未开启"
#define locationPromptContent @"请在设置中开启定位服务"

static NSString *const HHLocationCacheKey = @"HHLocationCacheKey";


@interface HHLocationManager()<CLLocationManagerDelegate>
{
    NSMutableSet  *_hashTable;
    
    CLLocationManager *_locationManager;
    CLGeocoder *_geoCoder;
    CompleteLocationBlock _completeBlock;
    BOOL _isNeedGeo;
}
@property (nonatomic, assign, readwrite) BOOL isUpdatingLocation;//是否正在定位

@end
@implementation HHLocationManager

@synthesize locationCache=_locationCache;

static HHLocationManager *manager=nil;
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[HHLocationManager alloc] init];
    });
    return manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _hashTable=[NSMutableSet set];
        
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
        _locationManager.distanceFilter=1500.f;
        _locationManager.delegate=self;
        _geoCoder=[[CLGeocoder alloc] init];
    }
    return self;
}
-(void)requestAlwaysAuthorization{
    if (IS_OS_8_OR_LATER) {
        [_locationManager requestAlwaysAuthorization];
    }
}
- (HHLocationStatus)status{
    
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    HHLocationStatus managerStatus = HHLocationStatusServiceUnabled;
    switch (authorizationStatus) {
        case kCLAuthorizationStatusRestricted: {
            managerStatus = HHLocationStatusRestricted;
            break;
        }
        case kCLAuthorizationStatusDenied: {
            managerStatus = HHLocationStatusDenied;
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:{
            managerStatus=HHLocationStatusNormal;
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            managerStatus=HHLocationStatusNormal;
        }
            break;
        default: {
            managerStatus = HHLocationStatusServiceUnabled;
            break;
        }
    }
    
    return managerStatus;
}
- (void)storedLocation:(HHLocation *)location
{
    _locationCache=location;
    NSData *archiver=[NSKeyedArchiver archivedDataWithRootObject:location];
    
    [[NSUserDefaults standardUserDefaults] setObject:archiver forKey:HHLocationCacheKey];
}
-(void)setLocationCache:(HHLocation *)locationCache{
    _locationCache=locationCache;
    [self storedLocation:locationCache];
    
}
-(HHLocation *)locationCache{
    if (_locationCache==nil) {
        NSData *data=[[NSUserDefaults standardUserDefaults]objectForKey:HHLocationCacheKey];
        _locationCache=[NSKeyedUnarchiver unarchiveObjectWithData:data] ;
    }
    return _locationCache;
}
#pragma mark - updateLocation

- (void)startLocationReverseGeocode:(BOOL)isGeo complete:(CompleteLocationBlock)complete{
    _completeBlock=[complete copy];
    if (![CLLocationManager locationServicesEnabled]) {
        _locationEnabled=NO;
        [self completeUpdateLocation:nil status:[self status]];
    }else{
        [_locationManager requestWhenInUseAuthorization];
        
        if ([self status]!=HHLocationStatusNormal) {
            _locationEnabled=NO;
            [self completeUpdateLocation:nil status:[self status]];
        }else{
            _isNeedGeo=isGeo;
            [_locationManager startUpdatingLocation];
            self.isUpdatingLocation=YES;
        }
    }
}
- (void)startUpdateLocationComplete:(CompleteLocationBlock)complete{
    [self startLocationReverseGeocode:NO complete:complete];
}
- (void)stopUpdateLocation{
    [_locationManager stopUpdatingLocation];
}
#pragma mark - Geo
- (void)geocodeAddressString:(NSString *)addressString completionHandler:(CompleteLocationBlock)completionHandler{
    if (addressString) {
        [_geoCoder geocodeAddressString:addressString completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error) {
                [self completeUpdateLocation:nil status:HHLocationStatusGeoFailed];
            }else{
                CLPlacemark *place=[placemarks lastObject];
                HHLocation *hLocation=[[HHLocation alloc] initWithCLPlacemark:place];
                hLocation.address=place.name;
                [self completeUpdateLocation:hLocation status:HHLocationStatusNormal];

            }
        }];
    }else{
        [self completeUpdateLocation:nil status:HHLocationStatusGeoFailed];

    }
}

#pragma mark - CLLocation Delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [manager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }

    FMKLOG("\n///////\n\nchange Authorization status\n\n////////\n");
    if ([self status]==HHLocationStatusDenied) {
        [self locationServiceUnAuthorizedPrompt];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    FMKLOG("\n///////\n\nupdate location\n\n////////\n");
    [self stopUpdateLocation];
    if (locations.count>0) {
        CLLocation *location=[locations lastObject];
        HHLocation *hLocation=[[HHLocation alloc] initWithCLLocation:location];
        FMKLOG(@"当前经纬度:lon=%lf,lat=%lf",location.coordinate.longitude,location.coordinate.latitude);

        if (_isNeedGeo) {
            if ([_geoCoder isGeocoding]) {
                return;
            }
            __weak typeof(self) weakSelf=self;
            [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                FMKLOG(@"反GEO结果:placemarks:%@ \n error:%@",placemarks.lastObject.addressDictionary,error);

                __strong typeof(self) strongSelf=weakSelf;
                strongSelf.isUpdatingLocation = NO;
                if (error) {
                    [strongSelf setLocationCache:hLocation];
                    [strongSelf completeUpdateLocation:hLocation status:HHLocationStatusFailed];

                }else{
                    HHLocation *alocation=[[HHLocation alloc] initWithCLPlacemark:placemarks.lastObject];
                    [strongSelf setLocationCache:alocation];
                    [strongSelf completeUpdateLocation:alocation status:HHLocationStatusNormal];

                }
            }];
        }else{
            self.isUpdatingLocation = NO;
            [self setLocationCache:hLocation];
            [self completeUpdateLocation:hLocation status:HHLocationStatusNormal];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    FMKLOG(@"location error:%@",error);
    self.isUpdatingLocation = NO;
    _isNeedGeo=NO;
    [self stopUpdateLocation];

//    if (error.code == kCLErrorDenied || error.code==kCLErrorLocationUnknown) {
//    }
    [self completeUpdateLocation:nil status:HHLocationStatusFailed];
}
- (void)completeUpdateLocation:(HHLocation *)location status:(HHLocationStatus)status{
    
    if (_completeBlock) {
        _completeBlock(location,status);
    }
    [_hashTable enumerateObjectsUsingBlock:^(CompleteLocationBlock   callback, BOOL * _Nonnull stop) {
        callback(location,status);
    }];
    
}

- (void)locationHandleFinishCallback:(CompleteLocationBlock)callback{
    if (callback==nil) {
        return;
    }
    [_hashTable addObject:callback];
    
}



- (void)locationServiceUnAuthorizedPrompt
{
    
    if (IS_OS_8_OR_LATER) {
        [[[UIAlertView alloc] initWithTitle:locationPromptTitle
                                    message:locationPromptContent
                                   delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"设置", nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:locationPromptTitle
                                    message:locationPromptContent
                                   delegate:self
                          cancelButtonTitle:@"我知道了"
                          otherButtonTitles:nil] show];
    }
    
}

- (void)locationServiceUnablePrompt
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"设置"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}



@end
@implementation HHLocation

- (instancetype)initWithCLLocation:(CLLocation *)location{
    if (self=[super init]) {
        _location=location;
        _coordinate=location.coordinate;
    }
    return self;
}
- (instancetype)initWithCLPlacemark:(CLPlacemark *)placemark{
    if (self=[super init]) {
        _location=placemark.location;
        _coordinate=placemark.location.coordinate;
        _latitude=placemark.location.coordinate.latitude;
        _longitude=placemark.location.coordinate.longitude;
        _placemark=placemark;
        NSArray *addr=placemark.addressDictionary[@"FormattedAddressLines"];
        _address=[addr componentsJoinedByString:@""];
        _country=placemark.country;
        _province=placemark.administrativeArea;
        _city=placemark.locality;
        _district=placemark.subLocality;
        _street=placemark.thoroughfare;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        _longitude=[[aDecoder decodeObjectForKey:@"longitude"] doubleValue];
        _latitude=[[aDecoder decodeObjectForKey:@"latitude"] doubleValue];
        _coordinate=CLLocationCoordinate2DMake(_latitude, _longitude);
        _country=[aDecoder decodeObjectForKey:@"country"];
        _province=[aDecoder decodeObjectForKey:@"province"];
        _city=[aDecoder decodeObjectForKey:@"city"];
        _district=[aDecoder decodeObjectForKey:@"district"];
        _street=[aDecoder decodeObjectForKey:@"street"];
        _address=[aDecoder decodeObjectForKey:@"address"];

    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:@(self.latitude) forKey:@"latitude"];
    [aCoder encodeObject:@(self.longitude) forKey:@"longitude"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.district forKey:@"district"];
    [aCoder encodeObject:self.street forKey:@"street"];
    [aCoder encodeObject:self.address forKey:@"address"];

}
@end