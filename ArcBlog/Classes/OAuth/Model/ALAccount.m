//
//  ALAccount.m
//  ArcBlog
//
//  Created by Arclin on 15/11/25.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALAccount.h"

#define ALAccountTokenKey @"token"
#define ALUidKey @"uid"
#define ALExpires_inKey @"expire"
#define ALExpires_dateKey @"date"
#define ALNameKey @"name"

#import "MJExtension.h"

@implementation ALAccount
// 底层遍历当前类的所有属性，一个一个归档和接档,便于归档和解档
MJCodingImplementation
+ (instancetype)accountWithDict:(NSDictionary *)dict{
    
    ALAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in{
    
    _expires_in = expires_in;
    
    // 计算下过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

//// 归档的时候调用，告诉系统那个属性需要归档，如何归档
//- (void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:_access_token forKey:ALAccountTokenKey];
//    [aCoder encodeObject:_expires_in forKey:ALExpires_inKey];
//    [aCoder encodeObject:_uid forKey:ALUidKey];
//    [aCoder encodeObject:_expires_date forKey:ALExpires_dateKey];
//    [aCoder encodeObject:_name forKey:ALNameKey];
//}
//
//// 解档的时候调用，告诉系统那个属性需要解档，如何解档
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
//        // 一定要记得赋值
//        _access_token = [aDecoder decodeObjectForKey:ALAccountTokenKey];
//        _expires_in = [aDecoder decodeObjectForKey:ALExpires_inKey];
//        _uid = [aDecoder decodeObjectForKey:ALUidKey];
//        _expires_date = [aDecoder decodeObjectForKey:ALExpires_dateKey];
//        _name = [aDecoder decodeObjectForKey:ALNameKey];
//    }
//    return self;
//}
/*
 * KVC底层实现：遍历字典里所有key（uid）
 * 一个一个获取key、会去模型里查找setKey：setUid：,直接调用这个方法，赋值 setUid：obj
 * 寻找有没有带下划线的_key,_uid,直接拿到属性赋值
 * 寻找有没有key的属性，如果有，直接赋值
 * 在模型里找不到对应的key，就会报错
 */
@end
