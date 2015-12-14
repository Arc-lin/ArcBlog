//
//  ALUserTool.m
//  ArcBlog
//
//  Created by Arclin on 15/12/14.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALUserTool.h"
#import "ALHttpTool.h"
#import "ALUserResult.h"
#import "ALUserParam.h"
#import "ALAccountTool.h"
#import "ALAccount.h"
#import "MJExtension.h"
@implementation ALUserTool

+ (void)unreadWithSuccess:(void (^)(ALUserResult *))success failure:(void (^)(NSError *))failure{
    
    // 创建参数模型
    ALUserParam *param = [ALUserParam param];
    param.uid = [ALAccountTool account].uid;
    
    [ALHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 字典转模型
        ALUserResult *result = [ALUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
