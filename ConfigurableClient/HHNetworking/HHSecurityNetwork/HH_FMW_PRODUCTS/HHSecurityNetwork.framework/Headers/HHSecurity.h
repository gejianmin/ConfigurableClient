//
//  HHSecurity.h
//  HHSecurityNetwork
//
//  Created by LWJ on 2016/10/26.
//  Copyright © 2016年 HHAutohhauto. All rights reserved.
//  参数加密解密

#import <Foundation/Foundation.h>

@interface HHSecurity : NSObject

@property (nonatomic, copy) NSString *businessKey;
@property (nonatomic, copy) NSString *signatureKey;
@property (nonatomic, copy) NSString *businessLine;

+ (instancetype)sharedInstance;

- (void)setCommonParam:(NSString *)object forKey:(NSString *)key;


/*!
 *  RSA参数加密
 */
- (NSData *)dataByEncryptParams:(NSDictionary *)param;
/*!
 *  响应数据解密
 */
- (id)JSONDecryptResponseData:(NSDictionary *)object;

- (NSData *)RSAEncryptionToString:(NSString *)string;

@end


@interface NSData (HHBase64)
/*!
 *  base64编码
 */
+ (NSData *)hh_dataWithBase64EncodedString:(NSString *)string;
- (NSString *)hh_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)hh_base64EncodedString;

/*!
 *  AES加密解密
 */
- (NSData *)hh_encryptAES:(NSString *)key;
- (NSData *)hh_decryptAES:(NSString *)key;


@end


@interface NSString (HHBase64)
/*!
 *  base64编码
 */
+ (NSString *)hh_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)hh_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)hh_base64EncodedString;
- (NSString *)hh_base64DecodedString;
- (NSData *)hh_base64DecodedData;


/**
 AES加密解密
 */
- (NSString *)hh_encryptAES:(NSString *)key;
- (NSString *)hh_decryptAES:(NSString *)key;


@end
