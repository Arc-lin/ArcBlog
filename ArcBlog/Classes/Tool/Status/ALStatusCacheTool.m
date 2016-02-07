//
//  ALStatusCacheTool.m
//  ArcBlog
//
//  Created by Arclin on 16/2/6.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALStatusCacheTool.h"
#import "ALStatus.h"
#import "ALAccountTool.h"
#import "ALAccount.h"
#import "ALStatusParam.h"
#import "FMDB.h"

@implementation ALStatusCacheTool

static FMDatabase *_db;

+ (void)initialize
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 拼接文件名
    NSString *filePath = [cachePath  stringByAppendingPathComponent:@"status.sqlite"];
    NSLog(@"%@",filePath);
    // 创建一个数据库实例
    _db = [FMDatabase databaseWithPath:filePath];
    
    // 打开数据库
    if ([_db open]) {
        NSLog(@"打开成功");
    }else{
        NSLog(@"打开失败");
    }
    
    // 创建表格
    BOOL flag = [_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,idstr text,access_token text,dict blob);"];
    if (flag) {
        NSLog(@"创建成功"); 
    }else{
        NSLog(@"创建失败");
    }
}

+ (void)saveWithSatatuses:(NSArray *)statuses
{
    // 遍历数组模型
    for (NSDictionary *statusDic in statuses) {
        NSString *idstr =statusDic[@"idstr"];
        NSString *accessToken = [ALAccountTool account].access_token;
        // 纯洁的字典
//        NSDictionary *statusDict = statuses.keyValues;
        
        //NSLog(@"%@",statusDic);
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDic];
        
        BOOL flag = [_db executeUpdate:@"insert into t_status (idstr,access_token,dict) values(?,?,?)",idstr,accessToken,data];
        
        if (flag) {
            NSLog(@"创建成功");
        }else{
            NSLog(@"创建失败");
        }
    }
}

+ (NSArray *)statusesWithParam:(ALStatusParam *)param
{
    // 进入程序第一次获取的查询语句
    NSString *sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;", param.access_token];
    if (param.since_id) { // 获取最新微博的查询语句
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@' order by idstr desc limit 20;",param.access_token,param.since_id];
    }else if(param.max_id){ // 获取更多微博的查询语句
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr <= '%@' order by idstr desc limit 20;",param.access_token,param.max_id];
    }
    
    FMResultSet *result = [_db executeQuery:sql];
    NSMutableArray *arrM = [NSMutableArray array];
    while ([result next]) {
        NSData *data = [result dataForColumn:@"dict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        ALStatus *s = [ALStatus objectWithKeyValues:dict];
        [arrM addObject:s];
    }
    return arrM;
    // select * from t_ststus where access_token = param.accessToken order by idstr desc limit 20;
}
@end
