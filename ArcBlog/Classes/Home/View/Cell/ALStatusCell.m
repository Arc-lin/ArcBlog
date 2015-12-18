//
//  ALStatusCell.m
//  ArcBlog
//
//  Created by Arclin on 15/12/18.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALStatusCell.h"
#import "ALOriginalView.h"
#import "ALReweetView.h"
#import "ALStatusToolBar.h"

@interface ALStatusCell()

@property (nonatomic,weak) ALOriginalView *originalView;

@property (nonatomic,weak) ALReweetView *reweetView;

@property (nonatomic,weak) ALStatusToolBar *toolbar;

@end

@implementation ALStatusCell

// 注意:cell 是用initWithStyle 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加所有子控件
        [self setUpAllChildView];
    }
    
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView{
    
    // 原创微博
    ALOriginalView *originalView = [[ALOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    // 转发微博
    ALReweetView *reweetView = [[ALReweetView alloc] init];
    [self addSubview:reweetView];
    _reweetView = reweetView;
    
    // 工具条
    ALStatusToolBar *toolbar = [[ALStatusToolBar alloc] init];
    [self addSubview:toolbar];
    _toolbar = toolbar;
}
@end
