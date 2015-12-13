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
#import "ALAccount.h"
#import "ALStatus.h"
#import "ALUser.h"
#import "ALAccountTool.h"
#import "AFHTTPRequestOperationManager.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ALHttpTool.h"
#import "ALStatusTool.h"
@interface ALHomeViewController ()<ALCoverDelegate>

@property (nonatomic,weak) ALTitleButton *titleButton;

@property (nonatomic,strong) ALOneViewController *one;

@property (nonatomic,strong) NSMutableArray *statuses;

@end

@implementation ALHomeViewController

- (NSMutableArray *)statuses{
    
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    
    return _statuses;
}

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
    
    // 请求最新的微博数据
    [self loadNewStatus];
    
    // 添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];

    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    // 添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
}

#pragma mark - 请求更多旧的微博数据
- (void)loadMoreStatus{
    
    NSString *maxIdStr = nil;
    if (self.statuses.count) { // 有微博数据，才需要下拉刷新
        long long maxId = [[[self.statuses lastObject] idstr] longLongValue] -1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    // 请求更多的微博数据
    [ALStatusTool moreStautsWithMaxId:maxIdStr success:^(NSArray *statuses) {
        
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
       
        // 把数组中的元素添加进去
        [self.statuses addObjectsFromArray:statuses];
        
        // 刷新表格
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        
    }];

}
// {:json 字典 [:json数组]
/**
 * 获取服务器数据步骤
 *   1.向服务器发送请求 -> 阅读接口文档，参照接口文档跟服务器打交道，接口文档（1.请求的url；2.发送什么样子的请求（get,post);3.返回数据格式）
 *   2.服务器相应数据-> 解析数据，参照接口文档设计模型 -> 返回数据转换成模型
 *   3.把数据展示到界面
 */


#pragma mark - 请求最新的微博
- (void)loadNewStatus
{
    NSString *sinceId = nil;
    if(self.statuses.count){  // 有微博数据才需要下拉刷新
        sinceId = [self.statuses[0] idstr];
    }
    [ALStatusTool newStautsWithSinceId:sinceId success:^(NSArray *statuses) { // 请求成功的block
        
        // 结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        // 把最新的微博数据插入到最前面
        [self.statuses insertObjects:statuses atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    

    /*
     block做参数，原理解释如下
     
     void (^success)(id) = ^(id responseObject) { // HttpTool请求成功的回调
     // 请求成功代码先保存
     
     // 结束下拉刷新
     [self.tableView headerEndRefreshing];
     
     // 获取到微博数据 转换成模型
     // 获取微博字典数组
     NSArray *dictArr = responseObject[@"statuses"];
     // 把字典数组转换成模型数组
     NSArray *statuses = (NSMutableArray *)[CZStatus objectArrayWithKeyValuesArray:dictArr];
     
     NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
     // 把最新的微博数插入到最前面
     [self.statuses insertObjects:statuses atIndexes:indexSet];
     
     // 刷新表格
     [self.tableView reloadData];
     
     
     };
     
     [ALHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:success failure:^(NSError *error) {
     
     }];
     
     */
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.statuses.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //获取status模型
    ALStatus *status = self.statuses[indexPath.row];
    // 用户昵称
    cell.textLabel.text = status.user.name;
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    cell.detailTextLabel.text = status.text;
    
    return cell;
}

@end
