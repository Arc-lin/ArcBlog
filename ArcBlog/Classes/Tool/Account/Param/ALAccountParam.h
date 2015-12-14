//
//  ALAccountParam.h
//  ArcBlog
//
//  Created by Arclin on 15/12/14.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALAccountParam : NSObject

/**
 *  AppKey
 */
@property (nonatomic,copy) NSString *client_id;
/**
 *  AppSecret
 */
@property (nonatomic,copy) NSString *client_secret;
/**
 *  请求的类型，填写authorization_code
 */
@property (nonatomic,copy) NSString *grant_type;
/**
 *  代用authorize获得的code值
 */
@property (nonatomic,copy) NSString *code;
/**
 *  回调地址
 */
@property (nonatomic,copy) NSString *redirect_uri;


@end
