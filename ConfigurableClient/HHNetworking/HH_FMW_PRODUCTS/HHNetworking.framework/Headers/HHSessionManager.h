//
//  HHSessionManager.h
//  HHNetworking
//
//  Created by LWJ on 2016/10/21.
//  Copyright © 2016年 HHAuto. All rights reserved.
//
#import <Foundation/Foundation.h>
@protocol HHAuthSession;
@protocol HHVehicleSession;
@protocol HHCalculateSession;
@protocol HHProjectSession;
@protocol HHFileSession;
@protocol HHDataSession;

@protocol HHSessionManager <HHAuthSession,HHCalculateSession,HHVehicleSession,HHProjectSession,HHFileSession,HHDataSession>

@end
