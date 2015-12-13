//
//  ALStatusResult.h
//  ArcBlog
//
//  Created by Arclin on 15/12/13.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface ALStatusResult : NSObject<MJKeyValue>

/**
 *  用户的微博数组（ALStatus）
 */
@property (nonatomic,strong) NSArray *statuses;
/**
 *  用户最近微博总数
 */
@property (nonatomic,assign) int total_number;

@end
