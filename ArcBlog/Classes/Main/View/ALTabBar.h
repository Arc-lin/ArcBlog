//
//  ALTabBar.h
//  ArcBlog
//
//  Created by Arclin on 15/11/17.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALTabBar;

@protocol ALTabBarDelegate <NSObject>

@optional
- (void)tabBar:(ALTabBar *)tabBar didClickButton:(NSInteger)index;
/**
 *  点击加号按钮的时候调用
 */
- (void)tabBarDidClickPlusButton:(ALTabBar *)tabBar;

@end


@interface ALTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<ALTabBarDelegate> delegate;

@end
