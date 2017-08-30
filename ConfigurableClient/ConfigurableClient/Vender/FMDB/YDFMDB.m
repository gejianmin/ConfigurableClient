//
//  YDFMDB.m
//  XYFrameWork
//
//  Created by 中企互联 on 17/2/28.
//  Copyright © 2017年 yuandong. All rights reserved.
//

#import "YDFMDB.h"

#import <FMDB.h>

@interface YDFMDB ()

@property (nonatomic,strong) FMDatabase * db;
@property (nonatomic,strong) FMDatabaseQueue * queue;

@end

@implementation YDFMDB


+ (instancetype)manager {
    static YDFMDB *fmdb;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        fmdb = [[[self class] alloc]init];
        [fmdb initDataBase];
    });
    return fmdb;
}

-(void)initDataBase{
    
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"searchRecords.sqlite"];
    
    
// 创建数据库实例 db 这里说明下:如果路径中不存在@"searchRecords.sqlite"的文件,sqlite会自动创建@"searchRecords.sqlite"
    // 实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:filePath];
    
    if ([_db open]) {
        // 初始化数据表 1.搜索记录表 2.用户登录表
//        NSString *personSql = @"create table 'search_record' ('id' integer   ,'content' VARCHAR(255) ,'time' VARCHAR(255))";
//            NSString *carSql = @"CREATE TABLE 'search_record' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'headurl' VARCHAR(255),'name' VARCHAR(255),'phonenumber' VARCHAR(255),'time' VARCHAR(255),'sourceID' VARCHAR(255),'sourceType' VARCHAR(255) )";
        
        //@property (nonatomic, strong) NSString * newsId;/*!< ID*/
        //@property (nonatomic, strong) NSString * title;/*!< 简言*/
        //@property (nonatomic, strong) NSString * Summary;/*!< 内容*/
        //@property (nonatomic, strong) NSString * date;/*!< 时间*/
        //@property (nonatomic, strong) NSString * url;/*!< 链接*/
        
                NSString *carSql = @"create table 'search_record' ('id' integer   ,'newsId' VARCHAR(255) ,'title' VARCHAR(255),'Summary' VARCHAR(255),'date' VARCHAR(255),'url' VARCHAR(255))";

        
        [_db executeUpdate:carSql];
    }
    
    
    [_db close];
    
}
/**
 *  添加person
 *
 */
- (void)addDataWithHeadurl:(NSString *)headurl name:(NSString *)name phonenumber:(NSString *)phonenumber {
//   
//    NSArray * arr_tmp = [self getAllRecords];
//    for (YDContactRecordModel * model in arr_tmp) {
//        if ([model.phonenumber isEqualToString:phonenumber] ||
//            phonenumber.length == 0) {
//          
//            return;
//        }
//    }
//     [_db open];
//    NSString * time = [self getTimeNow];
//    [_db executeUpdate:@"INSERT INTO search_record(headurl,name,phonenumber,time)VALUES(?,?,?,?)",headurl,name,phonenumber,time];
//    [_db close];
}

- (void)addDataWithID:(NSString *)ID headurl:(NSString *)headurl name:(NSString *)name phonenumber:(NSString *)phonenumber sourceType:(YDFMDBSourceType)sourceType {
    NSArray * arr_tmp = [self getAllRecords];
    for (YDContactRecordModel * model in arr_tmp) {
        if ([model.phonenumber isEqualToString:phonenumber] ||
            phonenumber.length == 0) {
            
            return;
        }
    }
    NSString * sourceTypeTemp = [NSString stringWithFormat:@"%ld",sourceType];
    [_db open];
    NSString * time = [self getTimeNow];
    [_db executeUpdate:@"INSERT INTO search_record(headurl,name,phonenumber,time,sourceID,sourceType)VALUES(?,?,?,?,?,?)",headurl,name,phonenumber,time,ID,sourceTypeTemp];
    [_db close];
}


- (BOOL)addDataWithModel:(HeaderModel*)model {
    
    NSArray * arr_tmp = [self getAllRecords];
    for (HeaderModel * modelTmp in arr_tmp) {
        if ([modelTmp.newsId isEqualToString:model.newsId]) {
            
            return NO;
        }
    }
    
    
    [_db open];
   BOOL result =  [_db executeUpdate:@"INSERT INTO search_record(newsId,title,Summary,date,url)VALUES(?,?,?,?,?)",model.newsId,model.title,model.content ? model.content : model.Summary,model.date,model.url];
    [_db close];
    return result;
}
- (void)deleteAllRecords {
        [_db open];
    
    [_db executeUpdate:@"Delete from search_record"];
    
        [_db close];
}

- (BOOL)removeDataWithModel:(HeaderModel*)model{
    [_db open];
//    delete from tablename where id=11
   BOOL result =  [_db executeUpdate:[NSString stringWithFormat:@"Delete from search_record where newsId=%@",model.newsId]];
    
    [_db close];
    return result;
}


/**
 *  获取所有数据
 *
 */
- (NSMutableArray *)getAllRecords {
    //查询已知数据库文件
    
    [_db open];
    // 1.执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"select * from search_record"];
//    FMResultSet *resultSet = [self.db executeQuery:@"select * from search_record ORDER BY id DESC LIMIT 0, 10"];
    NSMutableArray * arr = [NSMutableArray array];
    // 2.遍历结果
    while ([resultSet next]) {
        
        NSString *newsId = [resultSet stringForColumn:@"newsId"];
        NSString *title = [resultSet stringForColumn:@"title"];
        NSString *Summary = [resultSet stringForColumn:@"Summary"];
        NSString *date = [resultSet stringForColumn:@"date"];
        NSString *url = [resultSet stringForColumn:@"url"];
        HeaderModel * model = [[HeaderModel alloc] init];
        model.newsId = newsId;
        model.title = title;
        model.Summary = Summary;
        model.date = date;
        model.url = url;
        
        [arr addObject:model];
    }
    [_db close];
    return arr;

}

- (NSMutableArray *)getAllRecordContainLocalPhone:(BOOL)isContain {
    //查询已知数据库文件
    
    [_db open];
    // 1.执行查询语句 SELECT *  FROM tableName ORDER BY time DESC LIMIT 0, 10
//    FMResultSet *resultSet = [self.db executeQuery:@"select * from search_record"];
    FMResultSet *resultSet = [self.db executeQuery:@"select * from search_record ORDER BY id DESC LIMIT 0, 10"];
    NSMutableArray * arr = [NSMutableArray array];
    // 2.遍历结果
    while ([resultSet next]) {
        
        NSString *ZDID = [resultSet stringForColumn:@"id"];
        NSString *headurl = [resultSet stringForColumn:@"headurl"];
        NSString *name = [resultSet stringForColumn:@"name"];
        NSString *phonenumber = [resultSet stringForColumn:@"phonenumber"];
        NSString *time = [resultSet stringForColumn:@"time"];
        NSString *sourceID = [resultSet stringForColumn:@"sourceID"];
        NSString *sourceType = [resultSet stringForColumn:@"sourceType"];
        YDContactRecordModel * model = [[YDContactRecordModel alloc] init];
        model.ZDID = ZDID;
        model.sourceType = sourceType;
        model.sourceID = sourceID;
        model.headurl = headurl;
        model.name = name;
        model.phonenumber = phonenumber;
        model.time = time;
//        if (isContain) {
//            [arr addObject:model];
//        }else{
//            if ([sourceType integerValue] == YDFMDBSourceTypeLocalTelphone) {
//                continue;
//            }
//            
//            [arr addObject:model];
//        }
        if (!isContain) {
            if ([sourceType integerValue] == YDFMDBSourceTypeLocalTelphone) {
                continue;
            }
        }
//        if ([model.phonenumber isEqualToString:[[[HHClient sharedInstance] user] mobilePhone]]) {
//             continue;
//        }
        [arr addObject:model];
        
    }
    [_db close];
    return arr;
    
}

/**
 *  返回当前时间
 *
 *  @return <#return value description#>
 */
- (NSString *)getTimeNow
{
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    //取出个随机数
    //    int last = arc4random() % 10000;
    //    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@-%i", date,last];
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    //    NSLog(@"%@", timeNow);
    return timeNow;
}
@end

