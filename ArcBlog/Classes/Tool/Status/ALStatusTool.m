//
//  ALStatusTool.m
//  ArcBlog
//
//  Created by Arclin on 15/12/13.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALStatusTool.h"
#import "ALHttpTool.h"
#import "ALStatus.h"
#import "ALAccount.h"
#import "ALAccountTool.h"
#import "ALStatusParam.h"
#import "MJExtension.h"
#import "ALStatusResult.h"
#import "ALStatusCacheTool.h"
@implementation ALStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
   
    // 创建一个参数模型
    ALStatusParam *param = [[ALStatusParam alloc] init];
    param.access_token = [ALAccountTool account].access_token;
    
    if (sinceId) { // 有微博数据，才需要下拉刷新
        param.since_id = sinceId;
    }
    
    // 先从数据库里面取数据
    NSArray *statuses = [ALStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    // 如果从数据库里面没有请求到数据，就向服务器请求
//    param.keyValues模型转字典，该功能由MJ框架提供
    [ALHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {// HttpTool请求成功的回调
        
        // 请求成功代码先保存
        // 获取到微博数据，转换成模型
        ALStatusResult *result = [ALStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        // 一定要保存服务器最原始的数据
        // 有新的数据，保存到数据库
        [ALStatusCacheTool saveWithSatatuses:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)moreStautsWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    // 创建一个参数模型
    ALStatusParam *param = [[ALStatusParam alloc] init];
    param.access_token = [ALAccountTool account].access_token;
    
    if (maxId) { // 有微博数据，才需要下拉刷新
        param.max_id = maxId;
    }
    
    // 先从数据库里面取数据
    NSArray *statuses = [ALStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    // 如果从数据库里面没有请求到数据，就向服务器请求
    
    [ALHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {// HttpTool请求成功的回调
        // 请求成功代码先保存
        
        // 把结果字典转换为结果模型
        ALStatusResult *result = [ALStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        // 一定要保存服务器最原始的数据
        // 有新的数据，保存到数据库
        [ALStatusCacheTool saveWithSatatuses:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
