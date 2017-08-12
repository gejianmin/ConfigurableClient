//
//  HHFileSession.m
//  HHNetworking
//
//  Created by LWJ on 2016/12/5.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHInterface.h"
#import "HHProject.h"
@implementation HHFileSession
- (NSURL *)downloadSmallPathWithImage:(HHCustomerImage *)image{
    NSString *imagePath=[[NSString stringWithFormat:@"%@%@?path=%@",kFileURLString,kBangDownloadImage,image.PATH] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:imagePath];
}
- (NSURL *)downloadLargePathWithImage:(HHCustomerImage *)image{
    NSString *imagePath=[[NSString stringWithFormat:@"%@%@?path=%@",kFileURLString,kBangDownloadImage,image.YT_PATH] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:imagePath];
}
- (void)asyncUploadImage:(UIImage *)image nameWordKey:(NSString *)wordKey projectId:(NSString *)projectId  complete:(HHSessionCompleteBlock)complete{
    NSString *url=[self urlWithBase:kFileURLString path:kBangUploadImage];

    NSString *fileName=[NSString stringWithFormat:@"%@_%ld.jpg",wordKey,(long)([[NSDate date] timeIntervalSince1970]*1000)];
//    NSDictionary *jsonDict=@{@"FileName":fileName,@"FileType":@"image",@"ProjectID":projectId};
//    NSError *error;
//    NSData *json=[NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:&error];
    url=[[url stringByAppendingFormat:@"?FileName=%@&FileType=image&ProjectID=%@",fileName,projectId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HHFile *file=[[HHFile alloc] init];
    file.data=UIImageJPEGRepresentation(image, 0.4);
    file.mimeType=@"image/jpeg";
    file.name=fileName;
    file.key=@"image";

    [self FILE:url params:nil files:@[file] complete:^(id response, HHError *error) {
        if (error) {
            FMWLog(@"error:%@",error);
            complete(nil,error);
            
        }else{
            
            HHCustomerImage *image=[HHCustomerImage mj_objectWithKeyValues:response[@"Data"]];

            complete(image,nil);
            FMWLog(@"\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",url,response);
            
        }

    }];

}
@end

