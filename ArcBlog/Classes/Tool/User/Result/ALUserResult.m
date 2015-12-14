//
//  ALUserResult.m
//  ArcBlog
//
//  Created by Arclin on 15/12/14.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALUserResult.h"

@implementation ALUserResult

- (int)messageCount{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totalCount{
    return self.messageCount + _status + _follower;
}
@end
