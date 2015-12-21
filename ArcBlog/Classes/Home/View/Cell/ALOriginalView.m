//
//  ALOriginalView.m
//  ArcBlog
//
//  Created by Arclin on 15/12/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALOriginalView.h"
#import "ALStatusFrame.h"
#import "ALStatus.h"

#import "UIImageView+WebCache.h"

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
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
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
    nameView.font = ALNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = ALTimeFont;
    timeView.textColor = [UIColor lightGrayColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = ALSourceFont;
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = ALTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
}

- (void)setStatusF:(ALStatusFrame *)statusF{
    
    _statusF = statusF;
    // 设置frame
    [self setUpFrame];
    // 设置data
    [self setUpData];
    
}

- (void)setUpData{
    
    ALStatus *status = _statusF.status;
    
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

    // 昵称
    _nameView.text = status.user.name;
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    _vipView.image = [UIImage imageNamed:imageName];
    
    // 时间
    _timeView.text = status.created_at;
    
    // 来源
    _sourceView.text = status.source;
    
    // 正文
    _textView.text = status.text;
    
}

- (void)setUpFrame{

    // 头像
    _iconView.frame = _statusF.originalIconFrame;
    
    // 昵称
    _nameView.frame = _statusF.originalNameFrame;
    
    // vip
    if (_statusF.status.user.vip) { // 是VIP
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }
    
    // 时间
    _timeView.frame = _statusF.originalTimeFrame;
    
    // 来源
    _sourceView.frame = _statusF.originalSourceFrame;
    
    // 正文
    _textView.frame = _statusF.originalTextFrame;
}
@end
