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

/**
 *  复杂界面开发步骤
    1. 按照业务逻辑划分界面结构（原创，转发，工具条）
    2. 每一个结构，都自定义控件
    3. 在控件上先把所有画风的结构界面添加上去
    4. 计算每个控件的位置，如果以后碰见空间的内容是根据模型决定的，马上就搞个ViewModel模型（模型+控件的frame）
    5. 模型转视图模型
    6. 给控件赋值视图模型
    7. 调节界面（文字大小和颜色）
    8. 一个结构一个结构处理
 */
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
        self.backgroundColor = [UIColor clearColor];
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
    
    // 设置工具条frame
    _toolbar.frame = statusF.toolBarFrame;
    _toolbar.status = statusF.status;
}
@end
