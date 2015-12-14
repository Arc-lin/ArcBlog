//
//  ALBaseParam.h
//  ArcBlog
//
//  Created by Arclin on 15/12/14.
//  Copyright © 2015年 sziit. All rights reserved.
//  基本参数模型

#import <Foundation/Foundation.h>

@interface ALBaseParam : NSObject
/**
 *  采用OAuth授权方式为必填参数，访问命令牌
 */
@property (nonatomic,copy) NSString *access_token;

+ (instancetype)param;

@end
