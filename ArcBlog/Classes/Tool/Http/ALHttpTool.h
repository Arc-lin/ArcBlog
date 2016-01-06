//
//  ALHttpTool.h
//  ArcBlog
//
//  Created by Arclin on 15/12/11.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALUploadParam;
@interface ALHttpTool : NSObject

/**
 *  get
 *
 *  get 请求
 不需要返回值：1.网络的数据会延迟，并不会马上返回
 
*  发送get请求
*
*  @param URLString  请求的基本URL
*  @param parameters 请求的参数字典
*  @param success    请求成功的回调
*  @param failure    请求失败的回调
*/
+ (void)GET:(NSString *)URLString
                        parameters:(id)parameters
                        success:(void(^)(id responseObject))success
                        failure:(void(^)(NSError *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的基本参数
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString
                        parameters:(id)parameters
                        success:(void(^)(id responseObject))success
                        failure:(void(^)(NSError *error))failure;

/**
 *  上传请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)Upload:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(ALUploadParam *)uploadParam
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;


@end
