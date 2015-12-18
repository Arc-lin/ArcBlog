//
//  ALReweetView.m
//  ArcBlog
//
//  Created by Arclin on 15/12/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALReweetView.h"
@interface ALReweetView()

@property (nonatomic,weak) UILabel *nameView; // 昵称

@property (nonatomic,weak) UILabel *textView; // 正文

@end

@implementation ALReweetView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildView];
        
    }
    
    return self;
    
}

// 添加所有子控件
- (void)setUpAllChildView{

    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    [self addSubview:nameView];
    _nameView = nameView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    [self addSubview:textView];
    _textView = textView;
    
}
@end
