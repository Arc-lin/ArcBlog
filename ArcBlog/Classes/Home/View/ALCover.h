//
//  ALCover.h
//  ArcBlog
//
//  Created by Arclin on 15/11/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>
// 代理什么时候用，一般自定义控件的时候都用代理
// 为什么？因为一个控件以后可能要扩充新的功能，为了程序的拓展性，一般用代理
@class ALCover;
@protocol ALCoverDelegate <NSObject>

@optional
//点击蒙版的时候调用
- (void)coverDidClickCover:(ALCover *)cover;

@end

@interface ALCover : UIView
/*
 显示蒙版
 */
+ (instancetype)show;

// 设置浅灰色蒙版
@property (nonatomic,assign) BOOL dimBackground;

@property (nonatomic,weak) id<ALCoverDelegate> delegate;

@end
