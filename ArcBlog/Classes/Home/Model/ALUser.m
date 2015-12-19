//
//  ALUser.m
//  ArcBlog
//
//  Created by Arclin on 15/12/9.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALUser.h"

@implementation ALUser

- (void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}
@end
