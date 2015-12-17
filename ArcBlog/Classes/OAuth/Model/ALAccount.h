//
//  ALAccount.h
//  ArcBlog
//
//  Created by Arclin on 15/11/25.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALAccount : NSObject<NSCoding>
/**
 *   "access_token" = "2.00VXShZCRiqKMCadfe2d2d17kmU4HE";
     "expires_in" = 157679999;
     "remind_in" = 157679999;
     uid = 2359756797;
 */
/*
 * 获取数据的访问命令牌
 */
@property (nonatomic,copy) NSString *access_token;
/*
 * 账号的有效期
 */
@property (nonatomic,copy) NSString *expires_in;
/*
 * 用户唯一标识符
 */
@property (nonatomic,copy) NSString *uid;
/*
 * 过期时间 = 当前保存时间+有效期
 */
@property (nonatomic,strong) NSDate *expires_date;
/*
 * 账号的有效期
 */
@property (nonatomic,copy) NSString *remind_in;
/**
 *  账号的昵称
 */
@property (nonatomic,copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
