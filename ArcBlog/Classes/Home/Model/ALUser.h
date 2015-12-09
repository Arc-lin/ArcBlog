//
//  ALUser.h
//  ArcBlog
//
//  Created by Arclin on 15/12/9.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALUser : NSObject

/**
 *  昵称
 */
@property (nonatomic,copy) NSString *name;
/**
 *  微博头像
 */
@property (nonatomic,strong) NSURL *profile_image_url;

@end
