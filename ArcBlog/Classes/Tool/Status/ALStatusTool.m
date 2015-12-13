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
@implementation ALStatusTool

+ (void)newStautsWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
   
    // 创建一个参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (sinceId) { // 有微博数据，才需要下拉刷新
        
        params[@"since_id"] = sinceId;
        
    }
    params[@"access_token"] = [ALAccountTool account].access_token;
    
    [ALHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(id responseObject) {// HttpTool请求成功的回调
        // 请求成功代码先保存
        
        // 获取到微博数据，转换成模型
        // 获取微博字典数组
        NSArray *dictArr = responseObject[@"statuses"];
        // 字典数组转换为模型数组
        NSArray *statuses = (NSMutableArray *)[ALStatus objectArrayWithKeyValuesArray:dictArr];
        
        if (success) {
            success(statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)moreStautsWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    // 创建一个参数字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (maxId) { // 有微博数据，才需要下拉刷新
        
        params[@"max_id"] = maxId;
        
    }
    params[@"access_token"] = [ALAccountTool account].access_token;
    
    [ALHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(id responseObject) {// HttpTool请求成功的回调
        // 请求成功代码先保存
        
        // 获取到微博数据，转换成模型
        // 获取微博字典数组
        NSArray *dictArr = responseObject[@"statuses"];
        // 字典数组转换为模型数组
        NSArray *statuses = (NSMutableArray *)[ALStatus objectArrayWithKeyValuesArray:dictArr];
        
        if (success) {
            success(statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
