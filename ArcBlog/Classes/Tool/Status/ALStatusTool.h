//
//  ALStatusTool.h
//  ArcBlog
//
//  Created by Arclin on 15/12/13.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALStatusTool : NSObject

/**
 *  请求更新的微博数据
 *
 *  sinceId: 返回比这个更大的微博数据
 *  success: 请求成功的时候回调
 *  failure: 请求失败的时候回调
 */

+ (void)newStautsWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

/**
 *  请求更多的微博数据
 *
 *  @param maxId   返回小于等于这个id的微博数据
 *  @param success 请求成功时的回调
 *  @param failure 请求失败时的回调
 */
+ (void)moreStautsWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

@end
