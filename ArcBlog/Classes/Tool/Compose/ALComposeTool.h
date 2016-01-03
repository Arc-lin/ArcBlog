//
//  ALComposeTool.h
//  ArcBlog
//
//  Created by Arclin on 16/1/3.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALComposeTool : UIView

+ (void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
