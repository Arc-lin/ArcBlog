//
//  ALHttpTool.h
//  ArcBlog
//
//  Created by Arclin on 15/12/11.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALHttpTool : NSObject

/**
 *  get
 *
 *  get 请求
 不需要返回值：1.网络的数据会延迟，并不会马上返回
 
 */

+ (void)GET:(NSString *)URLString
                        parameters:(id)parameters
                        success:(void(^)(id responseObject))success
                        failure:(void(^)(NSError *error))failure;

@end
