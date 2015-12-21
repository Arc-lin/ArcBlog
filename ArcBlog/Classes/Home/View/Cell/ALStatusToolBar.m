//
//  ALStatusToolBar.m
//  ArcBlog
//
//  Created by Arclin on 15/12/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALStatusToolBar.h"

@implementation ALStatusToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildView];
        
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
    
}

// 添加所有子控件
- (void)setUpAllChildView{
    

}
@end
