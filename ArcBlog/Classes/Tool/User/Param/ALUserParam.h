//
//  ALUserParam.h
//  ArcBlog
//
//  Created by Arclin on 15/12/14.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALBaseParam.h"

@interface ALUserParam : ALBaseParam

/**
 *  当前用户的唯一标识符 
 */
@property (nonatomic,copy) NSString *uid;

@end
