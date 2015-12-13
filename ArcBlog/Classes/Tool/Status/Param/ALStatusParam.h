//
//  ALStatusParam.h
//  ArcBlog
//
//  Created by Arclin on 15/12/13.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

//请求数据常规开发部步骤：
//    1. 查看接口文档
//    2. 依据参数列表，设置参数模型
//    3. 依据结果列表，设置结果模型
//    4. 直接拿到对应的工具类请求
// 参数模型如何设计，直接参考接口文档的参数列表
@interface ALStatusParam : NSObject
/**
 *  采用OAuth授权方式为必填参数，访问命令牌
 */
@property (nonatomic,copy) NSString *access_token;
/**
 *  返回id比since_id大的微博（即比since_id时间晚的微博），默认为0
 */
@property (nonatomic,copy) NSString *since_id;
/**
 *  返回id小于或等于max_id的微博，默认为0
 */
@property (nonatomic,copy) NSString *max_id;

@end
