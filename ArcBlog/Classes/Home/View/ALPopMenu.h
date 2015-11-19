//
//  ALPopMenu.h
//  ArcBlog
//
//  Created by Arclin on 15/11/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALPopMenu : UIImageView

/**
 * 显示弹出菜单
 */
+ (instancetype)showInRect:(CGRect)rect;

/*
 隐藏弹出菜单
 */
+ (void)hide;

// 内容视图
@property (nonatomic,weak) UIView *contentView;

@end
