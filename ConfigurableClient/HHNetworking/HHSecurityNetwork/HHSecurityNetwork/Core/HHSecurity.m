//
//  HHSecurity.m
//  HHSecurityNetwork
//
//  Created by LWJ on 2016/10/26.
//  Copyright © 2016年 HHAutohhauto. All rights reserved.
//

#import "HHSecurity.h"
#import "RSACryptor.h"
//#import "<#header#>"
#import <CommonCrypto/CommonCrypto.h>
#import <UIKit/UIKit.h>
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>


@interface HHSecurity()
@property (nonatomic, copy) NSString *AESKey;

@end
@implementation HHSecurity{
    NSMutableDictionary *_commonParams;
}
+(instancetype)sharedInstance{
    static HHSecurity *instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[HHSecurity alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _commonParams=[NSMutableDictionary dictionary];
        _commonParams[@"ClientType"]=@"iOS";
        _commonParams[@"DeviceId"]= [UIDevice currentDevice].identifierForVendor.UUIDString;
        _commonParams[@"IPAdress"]=[self getDeviceIPIpAddresses];
        _commonParams[@"OSVersion"]=[[UIDevice currentDevice] systemVersion];
        _commonParams[@"TimeStamp"]=[NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970]*1000)];
        _commonParams[@"AESKey"]=self.AESKey;
        _commonParams[@"clientVersion"]=[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        _businessKey=@"BussinessData";
        _signatureKey=@"SignatureKey";
        
    }
    return self;
}

- (void)setCommonParam:(NSString *)object forKey:(NSString *)key{
    _commonParams[key]=object;
}

-(void)setBusinessLine:(NSString *)businessLine{
    _businessLine=businessLine;
    NSAssert(businessLine.length, @"业务线参数为空");
    [self setCommonParam:businessLine forKey:@"BusinessLine"];
}

-(NSString *)AESKey{
    if (!_AESKey) {
        _AESKey = [NSUUID UUID].UUIDString;
        _AESKey = [_AESKey stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    return _AESKey;
}
- (NSString *)JSONSerialization:(id)obj
{
    if (obj == nil) {
        return @"";
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (NSData *)dataByEncryptParams:(NSDictionary *)param{
    
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:_commonParams];
    NSString *businessJSON = [self JSONSerialization:param];
    NSString *AESBusinessJSON=[businessJSON hh_encryptAES:self.AESKey];

    [allParams setValue:AESBusinessJSON forKey:_businessKey];

    NSMutableArray *tempAllValues=[NSMutableArray array];
    NSArray *allvalue=allParams.allValues;
    [allvalue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *lowstr=[obj lowercaseString];
        [tempAllValues addObject:lowstr];
    }];
    NSArray *sortedKeys=[tempAllValues sortedArrayUsingSelector:@selector(compare:)];
    NSString *unsignStr=[sortedKeys componentsJoinedByString:@""];
    NSString *signature = [[self RSAEncryptionToString:unsignStr] hh_base64EncodedString];
    [allParams setValue:signature forKey:_signatureKey];

    NSString *finalRSAJSON=[self JSONSerialization:allParams];
    
    NSData *endata=[self RSAEncryptionToString:finalRSAJSON];
    NSString *base64Str=[endata hh_base64EncodedString];
    NSData *data=[base64Str dataUsingEncoding:NSUTF8StringEncoding];

    return data;
}

- (id)JSONDecryptResponseData:(NSDictionary *)object{
    NSMutableDictionary *temp=[NSMutableDictionary dictionaryWithDictionary:object];
    NSString *encDataStr=object[@"Data"];
    if ([encDataStr isKindOfClass:[NSNull class]]) {
        return object;
    }

    NSString *datastr=[encDataStr hh_decryptAES:self.AESKey];
    id json=[NSJSONSerialization JSONObjectWithData:[datastr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    if (json) {
        temp[@"Data"]=json;
    }else{
        temp[@"Data"]=datastr;
    }
    return [temp copy];
}



- (NSData *)RSAEncryptionToString:(NSString *)string{
    
    
    NSString *orstr = string;
    NSMutableData *encryptStr = [NSMutableData data];
    for (NSInteger i = 0; i < ceilf(orstr.length / 117.0); i ++) {
        NSString *subStr = [orstr substringWithRange:NSMakeRange(i * 117, MIN(117, orstr.length - i * 117))];
        NSData *temp=[[RSACryptor sharedRSACryptor] encryptData:[subStr dataUsingEncoding:NSUTF8StringEncoding]]; 
        [encryptStr appendData:temp];
    }
    return encryptStr;
    
}
- (NSString *)getDeviceIPIpAddresses
{
    int sockfd =socket(AF_INET,SOCK_DGRAM, 0);
    //    if (sockfd <</span> 0) return nil;
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE =4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len =sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    NSString *deviceIP =@"";
    for (int i=0; i < ips.count; i++)
    {
        if (ips.count >0)
        {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    NSLog(@"%@",deviceIP);
        return deviceIP;
    
}

@end



#pragma GCC diagnostic ignored "-Wselector"


#import <Availability.h>
#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

@implementation NSData (HHBase64)

+ (NSData *)hh_dataWithBase64EncodedString:(NSString *)string
{
    if (![string length]) return nil;
    
    NSData *decoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
    }
    else
        
#endif
        
    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    
    return [decoded length]? decoded: nil;
}

- (NSString *)hh_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    if (![self length]) return nil;
    
    NSString *encoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        encoded = [self base64Encoding];
    }
    else
        
#endif
        
    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }
    
    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }
    
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    
    return result;
}

- (NSString *)hh_base64EncodedString
{
    return [self hh_base64EncodedStringWithWrapWidth:0];
}
- (NSData *)hh_encryptAES:(NSString *)key{
    return  [NSData hh_CCCryptData:self algorithm:kCCAlgorithmAES operation:kCCEncrypt keyString:key iv:nil];

}
- (NSData *)hh_decryptAES:(NSString *)key{
    return [NSData hh_CCCryptData:self algorithm:kCCAlgorithmAES operation:kCCDecrypt keyString:key iv:nil];

}

+ (NSData *)hh_CCCryptData:(NSData *)data algorithm:(CCAlgorithm)algorithm operation:(CCOperation)operation keyString:(NSString *)keyString iv:(NSData *)iv{
    int keySize = (algorithm == kCCAlgorithmAES) ? kCCKeySizeAES256 : kCCKeySizeDES;
    int blockSize = (algorithm == kCCAlgorithmAES) ? kCCKeySizeAES256: kCCBlockSizeDES;
    
    
    NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cKey[keySize];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:keySize];
    
    
    uint8_t cIv[blockSize];
    bzero(cIv, blockSize);
    int option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    if (iv) {
        [iv getBytes:cIv length:blockSize];
        option = kCCOptionPKCS7Padding;
    }
    
    
    size_t bufferSize = [data length] + blockSize;
    void *buffer = malloc(bufferSize);
    
    // 加密或解密
    size_t cryptorSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,algorithm,option,cKey,keySize,cIv,[data bytes],[data length],buffer,bufferSize,&cryptorSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:cryptorSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 加密或解密失败 | 状态编码: %d", cryptStatus);
    }
    
    return result;

}


@end


@implementation NSString (HHBase64)

+ (NSString *)hh_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData hh_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)hh_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data hh_base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)hh_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data hh_base64EncodedString];
}

- (NSString *)hh_base64DecodedString
{
    return [NSString hh_stringWithBase64EncodedString:self];
}

- (NSData *)hh_base64DecodedData
{
    return [NSData hh_dataWithBase64EncodedString:self];
}
- (NSString *)hh_encryptAES:(NSString *)key{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *result = [data hh_encryptAES:key];
    return [result base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    

}
- (NSString *)hh_decryptAES:(NSString *)key{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSData *result = [data hh_decryptAES:key];
    
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];

}

@end

