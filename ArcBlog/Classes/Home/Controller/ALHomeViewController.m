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
#import "ALUserTool.h"
#import "ALStatus.h"
#import "ALUser.h"
#import "ALAccount.h"
#import "ALAccountTool.h"
#import "AFHTTPRequestOperationManager.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ALHttpTool.h"
#import "ALStatusTool.h"
#import "ALStatusCell.h"
#import "ALStatusFrame.h"
@interface ALHomeViewController ()<ALCoverDelegate>

@property (nonatomic,weak) ALTitleButton *titleButton;

@property (nonatomic,strong) ALOneViewController *one;
/**
 *  ViewModel:ALStatusFrame
 */
@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation ALHomeViewController

- (NSMutableArray *)statusFrames{
    
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    
    return _statusFrames;
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
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    
    // 一开始展示之前的微博名称，然后再发送用户信息请求，直接赋值
    
    // 请求当前用户的昵称
    [ALUserTool userInfoWithSuccess:^(ALUser *user) {
        // 请求当前账号的用户信息
        // 设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        // 获取当前的账号
        ALAccount *account = [ALAccountTool account];
        account.name = user.name;
        // 保存用户的名称
        
    } failure:^(NSError *error) {
            
    }];
}


#pragma mark - 刷新最新的微博
- (void)refresh{
    
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
}


#pragma mark - 请求更多旧的微博数据
- (void)loadMoreStatus{
    
    NSString *maxIdStr = nil;
    if (self.statusFrames.count) {
        ALStatus *s = [[self.statusFrames lastObject] status];
        long long maxId = [s.idstr longLongValue] -1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    // 请求更多的微博数据
    [ALStatusTool moreStautsWithMaxId:maxIdStr success:^(NSArray *statuses) {
        
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
       
        // 模型转换视图模型 ALStatus -> ALStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (ALStatus *status in statuses) {
            ALStatusFrame *statusF = [[ALStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }

        // 把数组中的元素添加进去
        [self.statusFrames addObjectsFromArray:statusFrames];
        
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
    if (self.statusFrames.count) { // 有微博数据，才需要下拉刷新
        ALStatus *s = [self.statusFrames[0] status];
        sinceId = s.idstr;
    }
    
    [ALStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) { // 请求成功的Block
        
        // 展示最新的微博数
        [self showNewStatusCount:statuses.count];
        
        // 结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        // 模型转换视图模型 CZStatus -> CZStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (ALStatus *status in statuses) {
            ALStatusFrame *statusF = [[ALStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        // 把最新的微博数插入到最前面
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
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
#pragma mark - 展示最新的微博数
- (void)showNewStatusCount:(int)count{
    
    if (count == 0) {
        return;
    }
    // 展示最新的微博数
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    
    CGFloat x = 0;
    CGFloat w = self.view.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"最新微博数%d",count];
    
    label.textAlignment =NSTextAlignmentCenter;
    
    // 插入到导航控制器的导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 动画往下面平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        
        // 往上面平移
        [UIView animateWithDuration:0.25 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
            // 还原
            label.transform = CGAffineTransformIdentity;
        
        } completion:^(BOOL finished) {
            [label removeFromSuperview];

        }];
    }];
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
    NSString *title = [ALAccountTool account].name?:@"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
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

    return self.statusFrames.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 创建cell
    ALStatusCell *cell = [ALStatusCell cellWithTableView:tableView];
    //获取status模型
    ALStatusFrame *statusF = self.statusFrames[indexPath.row];

    // 给cell传递模型
    cell.statusF = statusF;
    
    // 用户昵称
//    cell.textLabel.text = status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;
    
    return cell;
}

// 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //获取status模型
    ALStatusFrame *statusF = self.statusFrames[indexPath.row];
    return statusF.cellHeight;

}
@end
