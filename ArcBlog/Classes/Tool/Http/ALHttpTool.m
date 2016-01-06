//
//  ALHttpTool.m
//  ArcBlog
//
//  Created by Arclin on 15/12/11.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALHttpTool.h"
#import "AFNetworking.h"
#import "ALUploadParam.h"
@implementation ALHttpTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // AFN请求成功的时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        if(success){
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    // 发送Post请求
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 发送请求
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)Upload:(NSString *)URLString parameters:(id)parameters uploadParam:(ALUploadParam *)uploadParam success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) { // 上传的文件全部拼接到formData
        
        /**
         *  FileData:要上传的文件的二进制数据
         *  name:上传参数名称
         *  fileName：上传到服务器的文件名称
         *  mimeType：文件类型
         */
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end


