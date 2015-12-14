//
//  ALAccountTool.m
//  ArcBlog
//
//  Created by Arclin on 15/12/5.
//  Copyright © 2015年 sziit. All rights reserved.
//  

#import "ALAccountTool.h"
#import "ALAccount.h"
#import "AFNetworking.h"
#import "ALHttpTool.h"
#import "ALAccountParam.h"
#import "MJExtension.h"
#define ALAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"account.data"]
#define ALAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define ALClient_id @"2012167609"
#define ALRedirect_uri @"http://www.baidu.com"
#define ALClient_secret @"e6662273e723697cc49e74539462b1ba"

@implementation ALAccountTool

// 类方法一般用静态变量代替成员属性
static ALAccount *_account;

+ (void)saveAccount:(ALAccount *)account{

    [NSKeyedArchiver archiveRootObject:account toFile:ALAccountFileName];

}

+ (ALAccount *)account{
    
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:ALAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回nil
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期了
            return nil;
        }
    }
    // 过期时间 = 当前保存时间 + 有效期
    return _account;
}

+ (void)accessTokenWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    // 创建参数模型
    ALAccountParam *param = [[ALAccountParam alloc] init];
    param.client_id = ALClient_id;
    param.client_secret = ALClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = ALRedirect_uri;
    
    [ALHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        
        // 字典转模型
        ALAccount *account = [ALAccount accountWithDict:responseObject];
        
        // 保存账号信息:
        //数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        [ALAccountTool saveAccount:account];
        
        if(success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
