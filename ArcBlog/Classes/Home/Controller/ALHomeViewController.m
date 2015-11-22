//
//  ALHomeViewController.m
//  ArcBlog
//
//  Created by Arclin on 15/11/18.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALHomeViewController.h"
#import "ALOneViewController.h"
#import "UIBarButtonItem+Item.h"
#import "ALOneViewController.h"
#import "ALTitleButton.h"
#import "ALCover.h"
#import "ALPopMenu.h"
@interface ALHomeViewController ()<ALCoverDelegate>

@property (nonatomic,weak) ALTitleButton *titleButton;

@property (nonatomic,strong) ALOneViewController *one;

@end

@implementation ALHomeViewController

- (ALOneViewController *)one{

    if (_one == nil){
        _one = [[ALOneViewController alloc] init];
    }
    
    return _one;
}

// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// ios7之后，会把tabBar上和导航条上的按钮渲染
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置。

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setUpNavigationBar];
}

#pragma mark - 设置导航条
- (void)setUpNavigationBar{
    
    // 左边
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
   // titleView
    ALTitleButton *titleButton = [ALTitleButton buttonWithType:UIButtonTypeCustom];
    
    _titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = YES;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
    
}

// 以后只要显示在最前面的控件，一般都加在主窗口
// 点击标题按钮
- (void)titleClick:(UIButton *)button{
    
    button.selected = !button.selected;
    
    // 弹出蒙版
    ALCover *cover = [ALCover show];
    cover.delegate = self;
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    
    ALPopMenu *menu = [ALPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
    
}

// 点击蒙版的时候调用
- (void)coverDidClickCover:(ALCover *)cover
{
    //隐藏pop菜单
    [ALPopMenu hide];
    
    _titleButton.selected = NO;
}
- (void)friendsearch
{
    //    NSLog(@"%s",__func__);
}
- (void)pop
{
    // 创建one控制器
    // 1.首先去寻找有没有ALOneView.xib
    // 2.寻找ALOneViewController.xib
    // 3.默认创建几乎透明的view
    // init 方法底层调用 initWithNibName: bundle:
    ALOneViewController *one = [[ALOneViewController alloc] init];
    
    // 当push的时候就会隐藏底部条
    // 前提条件：只会隐藏系统自带的tabBar
    one.hidesBottomBarWhenPushed = YES;
    // 跳转到另外一个控制器
    [self.navigationController pushViewController:one animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
