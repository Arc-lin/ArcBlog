 //
//  ALRootTool.m
//  ArcBlog
//
//  Created by Arclin on 15/12/6.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALRootTool.h"
#import "ALTabBarController.h"
#import "ALNewFeatureController.h"
#define ALVersionKey @"version"
@implementation ALRootTool
// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window{
    
    // 1. 获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2. 获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:ALVersionKey];
    
    // 3.判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion]) {     // 没有最新的版本号
        
        // 创建tabBarVc
        ALTabBarController *tabBarVc = [[ALTabBarController alloc] init];
        
        // 设置窗口的根控制器
        window.rootViewController = tabBarVc;
    }else{      // 有最新的版本号
    
        // 进入新特性界面
        ALNewFeatureController *vc = [[ALNewFeatureController alloc] init];
        
        window.rootViewController = vc;
        
        // 保持当前的版本，使用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:ALVersionKey];
    }

    
}

@end
