//
//  ALUserTool.h
//  ArcBlog
//
//  Created by Arclin on 15/12/14.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALUserResult;
@interface ALUserTool : NSObject

/**
 *  请求用户的未读数
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(ALUserResult *result)) success failure:(void(^)(NSError *error)) failure;

@end
