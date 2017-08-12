//
//  HHInterface.h
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#ifndef HHInterface_h
#define HHInterface_h

#define kFastDecode u_int count=0;\
objc_property_t *properties=class_copyPropertyList([self class], &count);\
for (int i=0; i<count; i++) {\
const char* pname=property_getName(properties[i]);\
NSString *key=[NSString stringWithUTF8String:pname];\
id value=[aDecoder decodeObjectForKey:key];\
if (value) {\
[self setValue:value forKey:key];\
}\
}\
free(properties);

#define kFastEncode     u_int count=0;\
objc_property_t *properties=class_copyPropertyList([self class], &count);\
for (int i=0; i<count; i++) {\
const char* pname=property_getName(properties[i]);\
NSString *key=[NSString stringWithUTF8String:pname];\
id value=[self valueForKey:key];\
[aCoder encodeObject:value forKey:key];\
}\
free(properties);



#import "HHNetworking.h"
#import "HHAPIConst.h"
#import "HHServerConfig.h"
#import "MJExtension.h"
@interface HHSessionManager : NSObject <HHSessionManager>
@property (nonatomic, strong) NSMutableDictionary <NSString *,id> *sessions;
@property (nonatomic, strong) NSString *currentSessionClassName;

@end
@interface HHAuthSession : HHBaseSession <HHAuthSession>
@end
@interface HHCalculateSession : HHBaseSession

@end

@interface HHVehicleSession : HHBaseSession <HHVehicleSession>
@property (nonatomic, strong) id brandCache;
@property (nonatomic, strong) NSMutableDictionary<NSString *,id> *seriesCache;
@property (nonatomic, strong) NSMutableDictionary<NSString *,id> *vehicleCache;
@property (nonatomic, assign) BOOL cacheExpire;

@end
@interface HHProjectSession : HHBaseSession <HHProjectSession>

@end
@interface HHFileSession : HHBaseSession <HHFileSession>

@end
@interface HHDataSession : HHBaseSession <HHDataSession>

@end

#endif /* HHInterface_h */
