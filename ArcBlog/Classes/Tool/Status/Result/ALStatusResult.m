//
//  ALStatusResult.m
//  ArcBlog
//
//  Created by Arclin on 15/12/13.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALStatusResult.h"

#import "ALStatus.h"
@implementation ALStatusResult

+ (NSDictionary *)objectClassInArray{
    return @{@"statuses":[ALStatus class]};
}

@end
