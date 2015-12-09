//
//  ALStatus.m
//  ArcBlog
//
//  Created by Arclin on 15/12/9.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALStatus.h"
#import "ALPhoto.h"
@implementation ALStatus

// 实现这个方法，就会自动把数组中的字典转换为对应的模型
+ (NSDictionary *)objectClassInArray{

    return @{@"pic_urls":[ALPhoto class]};
}

@end
