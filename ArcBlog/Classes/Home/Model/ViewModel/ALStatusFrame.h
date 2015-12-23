//
//  ALStatusFrame.h
//  ArcBlog
//
//  Created by Arclin on 15/12/19.
//  Copyright © 2015年 sziit. All rights reserved.
//  ViewModel = 模型 + 对应控件的frame

#import <Foundation/Foundation.h>

@class ALStatus;
@interface ALStatusFrame : NSObject

/**
 *  微博数据
 */
@property (nonatomic,strong) ALStatus *status;

/**
 *  原创微博
 */
@property (nonatomic,assign) CGRect originalViewFrame;


/*******  原创微博子控件frame  **********/
// 头像frame
@property (nonatomic,assign) CGRect originalIconFrame;

// 昵称frame
@property (nonatomic,assign) CGRect originalNameFrame;

// vipframe
@property (nonatomic,assign) CGRect originalVipFrame;

// 时间frame
@property (nonatomic,assign) CGRect originalTimeFrame;

// 来源frame
@property (nonatomic,assign) CGRect originalSourceFrame;

// 正文frame
@property (nonatomic,assign) CGRect originalTextFrame;

// 配图frame
@property (nonatomic,assign) CGRect originalPhotosFrame;

/**
 *  转发微博
 */
@property (nonatomic,assign) CGRect retweetViewFrame;

/*******  转发微博子控件frame  **********/
// 昵称frame
@property (nonatomic,assign) CGRect retweetNameFrame;

// 正文frame
@property (nonatomic,assign) CGRect retweetTextFrame;

// 配图frame
@property (nonatomic,assign) CGRect retweetPhotosFrame;

/**
 *  工具条
 */
@property (nonatomic,assign) CGRect toolBarFrame;


/**
 *  cell的高度
 */
@property (nonatomic,assign) CGFloat cellHeight;
@end
