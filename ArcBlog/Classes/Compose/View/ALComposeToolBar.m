//
//  ALComposeToolBar.m
//  ArcBlog
//
//  Created by Arclin on 15/12/27.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALComposeToolBar.h"

@implementation ALComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //添加子控件
        [self setUpAllChildView];
    
    }
    return self;
}

#pragma mark - 添加所有子控件
- (void)setUpAllChildView
{
    // 相册
    [self setUpButtonItemWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    // 提及
     [self setUpButtonItemWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    // 话题
     [self setUpButtonItemWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    // 表情
     [self setUpButtonItemWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    // 键盘
     [self setUpButtonItemWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] target:self action:@selector(btnClick:)];
}

- (void)setUpButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}

- (void)btnClick:(UIButton *)button
{
    // 点击工具条的时候
    

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(x,y,w,h);
    }
}
@end
