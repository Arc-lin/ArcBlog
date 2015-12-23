//
//  ALRetweetView.m
//  ArcBlog
//
//  Created by Arclin on 15/12/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALRetweetView.h"
#import "ALStatus.h"
#import "ALStatusFrame.h"
#import "ALPhotosView.h"

@interface ALRetweetView()

@property (nonatomic,weak) UILabel *nameView; // 昵称

@property (nonatomic,weak) UILabel *textView; // 正文

@property (nonatomic,weak) ALPhotosView *photosView; // 配图

@end

@implementation ALRetweetView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    
    return self;
    
}

// 添加所有子控件
- (void)setUpAllChildView{

    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.textColor = [UIColor blueColor];
    nameView.font = ALNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = ALTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    // 配图
    ALPhotosView *photosView = [[ALPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
    
}

- (void)setStatusF:(ALStatusFrame *)statusF{
    
    _statusF = statusF;
    
    ALStatus *status = statusF.status;
    
    // 昵称
    _nameView.frame = statusF.retweetNameFrame;
    _nameView.text = status.retweetName;
    
    // 正文
    _textView.frame = statusF.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
    
    // 配图
    _photosView.frame = statusF.retweetPhotosFrame;
#warning TODO:配图数据
    
    
}
@end
