//
//  AppDelegate.h
//  RSA
//
//  Created by Lxrent on 16/9/20.
//  Copyright © 2016年 Lxrent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSACryptor : NSObject

+ (instancetype)sharedRSACryptor;

@property (nonatomic, strong) NSString *rsa_pub_key;

/**
 *  生成密钥对
 *
 */
- (void)generateKeyPair:(NSUInteger)keySize;

/**
 *  加载公钥
 *
 *  @param publicKeyPath 公钥路径
 *
 */
- (void)loadPublicKey:(NSString *)publicKeyPath;

/**
 *  加载私钥
 *
 *  @param privateKeyPath p12文件路径
 *  @param password       p12文件密码
 *
 @code
 openssl pkcs12 -export -out p.p12 -inkey rsa_private_key.pem -in rsacert.crt
 @endcode
 */
- (void)loadPrivateKey:(NSString *)privateKeyPath password:(NSString *)password;

/**
 *  加密数据
 *
 *  @param plainData 明文数据
 *
 *  @return 密文数据
 */
- (NSData *)encryptData:(NSData *)plainData;

/**
 *  解密数据
 *
 *  @param cipherData 密文数据
 *
 *  @return 明文数据
 */
- (NSData *)decryptData:(NSData *)cipherData;

@end
