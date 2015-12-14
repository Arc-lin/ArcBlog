//
//  ALBaseParam.m
//  ArcBlog
//
//  Created by Arclin on 15/12/14.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALBaseParam.h"
#import "ALAccountTool.h"
#import "ALAccount.h"

@implementation ALBaseParam

+(instancetype)param{
    
    ALBaseParam *param = [[self alloc] init];
    
    param.access_token = [ALAccountTool account].access_token;
    
    return param;
    
}

@end
