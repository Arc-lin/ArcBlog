//
//  ALStatusCacheTool.h
//  ArcBlog
//
//  Created by Arclin on 16/2/6.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALStatusParam;
@interface ALStatusCacheTool : NSObject

// statuses:模型数组
+ (void)saveWithSatatuses:(NSArray *)statuses;

+ (NSArray *)statusesWithParam:(ALStatusParam *)param;

@end
