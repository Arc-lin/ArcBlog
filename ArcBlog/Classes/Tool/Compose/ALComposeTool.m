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
#import "ALUploadParam.h"
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

+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    ALComposeParam *param = [ALComposeParam param];
    param.status = status;
    
    // 创建上传的模型
    ALUploadParam *uploadP = [[ALUploadParam alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    // 注意：以后如果一个方法，要传很多参数，就把参数包装成一个模型
    [ALHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadP success:^(id responseObject) {
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
