#!/bin/sh

#  RSA_KEY.sh
#  HHSecurityNetwork
#
#  Created by LWJ on 2016/10/28.
#  Copyright © 2016年 HHAutohhauto. All rights reserved.


#cd到你要生成rsa密钥文件夹下，执行该脚本

openssl genrsa -out private_key.pem 1024 #公用私钥

openssl req -new -key private_key.pem -out rsaCertReq.csr

openssl x509 -req -days 3650 -in rsaCertReq.csr -signkey private_key.pem -out rsaCert.crt

openssl x509 -outform der -in rsaCert.crt -out ios_public_key.der　　　　　　　　　　　　　　　# Create ios_public_key.der For IOS

openssl pkcs12 -export -out ios_private_key.p12 -inkey private_key.pem -in rsaCert.crt　　# Create ios_private_key.p12 For IOS. 这一步，请记住你输入的密码，IOS代码里会用到

openssl rsa -in private_key.pem -out rsa_public_key_java.pem -pubout　　　　　　　　　　　　　# Create rsa_public_key_java.pem For Java
　
openssl pkcs8 -topk8 -in private_key.pem -out pkcs8_private_key_java.pem -nocrypt             # Create pkcs8_private_key_java.pem For Java






