//
//  ALAccountTool.m
//  ArcBlog
//
//  Created by Arclin on 15/12/5.
//  Copyright © 2015年 sziit. All rights reserved.
//  

#import "ALAccountTool.h"
#import "ALAccount.h"

#define ALAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"account.data"]

@implementation ALAccountTool

// 类方法一般用静态变量代替成员属性
static ALAccount *_account;

+ (void)saveAccount:(ALAccount *)account{

    [NSKeyedArchiver archiveRootObject:account toFile:ALAccountFileName];

}

+ (ALAccount *)account{
    
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:ALAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回nil
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期了
            return nil;
        }
    }
    // 过期时间 = 当前保存时间 + 有效期
    return _account;
}
@end
