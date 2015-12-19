//
//  ALStatusCell.m
//  ArcBlog
//
//  Created by Arclin on 15/12/18.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALStatusCell.h"
#import "ALOriginalView.h"
#import "ALRetweetView.h"
#import "ALStatusToolBar.h"
#import "ALStatusFrame.h"

@interface ALStatusCell()

@property (nonatomic,weak) ALOriginalView *originalView;

@property (nonatomic,weak) ALRetweetView *retweetView;

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
    ALRetweetView *retweetView = [[ALRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    // 工具条
    ALStatusToolBar *toolbar = [[ALStatusToolBar alloc] init];
    [self addSubview:toolbar];
    _toolbar = toolbar;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

/**
 *  1. cell的高度应该提前计算出来
    2. cell的高度必须要先计算出每个子控件的frame，才能确定
    3. 如果在cell的setStatus方法计算子控件的位置，会比较耗性能
 *
 *  解决：MVVM思想
     M:模型
     V:视图
     VM:视图模型（模型包装视图模型，模型+模型对应视图的frame）
 */
- (void)setStatusF:(ALStatusFrame *)statusF{
    _statusF = statusF;
    
    // 设置原创微博的frame
    _originalView.frame = statusF.originalViewFrame;
    _originalView.statusF = statusF;
    
    // 设置原创微博frame
    _retweetView.frame = statusF.retweetViewFrame;
    _retweetView.statusF = statusF;
    
    // 赋值 
    _toolbar.frame = statusF.toolBarFrame;
}
@end
