//
//  ALSearchBar.m
//  ArcBlog
//
//  Created by Arclin on 15/11/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALSearchBar.h"

@implementation ALSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:13];
        
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        // 设置左边的View
        // initWithImage:默认UIImageView的尺寸跟图片一样
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageV.width += 10;
        imageV.contentMode = UIViewContentModeCenter;
        self.leftView = imageV;
        // 一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
        // UITextFieldViewModeAlways 一直显示
        self.leftViewMode = UITextFieldViewModeAlways;

//        UITextFieldViewModeNever,　重不出现
//        UITextFieldViewModeWhileEditing, 编辑时出现
//        UITextFieldViewModeUnlessEditing,　除了编辑外都出现
//        UITextFieldViewModeAlways 　一直出现
        
    }
    return self;
}

@end
