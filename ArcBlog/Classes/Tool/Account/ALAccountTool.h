//
//  ALAccountTool.h
//  ArcBlog
//
//  Created by Arclin on 15/12/5.
//  Copyright © 2015年 sziit. All rights reserved.
//  专门处理账号的业务（账号的存储和读取）

#import <Foundation/Foundation.h>

@class ALAccount;

@interface ALAccountTool : NSObject

+ (void)saveAccount:(ALAccount *)account;

+ (ALAccount *)account;

+ (void)accessTokenWithCode:(NSString *)code success:(void(^)()) success failure:(void(^)(NSError *error)) failure;

@end
