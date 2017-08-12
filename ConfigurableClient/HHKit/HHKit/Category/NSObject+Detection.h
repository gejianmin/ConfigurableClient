//
//  NSObject+Detection.h
//  LoginAPI
//
//  Created by Lxrent on 16/5/17.



#import <Foundation/Foundation.h>

@interface NSObject (Detection)

//怎么判断用户输入了是否正确的邮箱地址
-(BOOL)validateEmail:(NSString*)email;

- (BOOL) NSStringIsValidEmail:(NSString*)checkString;

- (BOOL)isValidateEmail:(NSString *)Email;
//判断字符串是否是整型

- (BOOL)isPureInt:(NSString*)string;

//判断是否为浮点形：

- (BOOL)isPureFloat:(NSString*)string;

- (BOOL)isValiMobile:(NSString *)mobile;

-(BOOL)judgePassWordLegal:(NSString *)pass;

@end
