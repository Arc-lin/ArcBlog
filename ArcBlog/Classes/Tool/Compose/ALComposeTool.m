//
//  ALComposeTool.m
//  ArcBlog
//
//  Created by Arclin on 16/1/3.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALComposeTool.h"
#import "ALHttpTool.h"
#import "ALComposeParam.h"
#import "MJExtension.h"

@implementation ALComposeTool

+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    ALComposeParam *param = [ALComposeParam param];
    param.status =status;
    
    [ALHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
