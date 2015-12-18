//
//  ALOriginalView.m
//  ArcBlog
//
//  Created by Arclin on 15/12/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALOriginalView.h"

@interface ALOriginalView()

@property (nonatomic,weak) UIImageView *iconView; // 头像

@property (nonatomic,weak) UILabel *nameView; // 昵称

@property (nonatomic,weak) UIImageView *vipView; // vip

@property (nonatomic,weak) UILabel *timeView; // 时间

@property (nonatomic,weak) UILabel *sourceView; // 来源

@property (nonatomic,weak) UILabel *textView; // 正文


@end


@implementation ALOriginalView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildView];
        
    }
    
    return self;

}

// 添加所有子控件
- (void)setUpAllChildView{
    
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    [self addSubview:nameView];
    _nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    [self addSubview:textView];
    _textView = textView;
}
@end
