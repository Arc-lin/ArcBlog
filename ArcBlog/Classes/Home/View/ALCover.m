//
//  ALCover.m
//  ArcBlog
//
//  Created by Arclin on 15/11/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALCover.h"

@implementation ALCover

//设置浅灰色蒙版
- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
    }
    
}
//显示蒙版
+ (instancetype)show
{
    ALCover *cover = [[ALCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    [ALKeyWindow addSubview:cover];
    
    return cover;
}

// 点击蒙版的时候做的事情
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    // 移除蒙版
    [self removeFromSuperview];
    
    // 通知代理移除菜单
    if([_delegate respondsToSelector:@selector(coverDidClickCover:)]){
       
        [_delegate coverDidClickCover:self];
    
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
