//
//  ALTabBarController.m
//  ArcBlog
//
//  Created by Arclin on 15/11/17.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALTabBarController.h"
#import "ALTabBar.h"
#import "ALNavigationController.h"
#import "ALHomeViewController.h"
#import "ALDiscoverViewController.h"
#import "ALMessageViewController.h"
#import "ALProfileViewController.h"
#import "ALUserTool.h"
#import "ALUserResult.h"
#import "ALComposeViewController.h"

@interface ALTabBarController ()<ALTabBarDelegate>

@property (nonatomic,strong) NSMutableArray *items;

@property (nonatomic,weak) ALHomeViewController *home;

@property (nonatomic,weak) ALMessageViewController *message;

@property (nonatomic,weak) ALProfileViewController *profile;

@end

@implementation ALTabBarController

// 什么时候调用：程序一启动的时候就会把所有的类加载进内存
// 作用：加载类的时候调用
// appearance 只要一个类遵守UIAppearance 就能获取到全局的外观，UIView
/*
    + (void)load{

        //获取所有的tabBarItem外观标识
    //    UITabBarItem *item  = [UITabBarItem appearance];
        //获取当前这个类下面的所有tabBarItem
        UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
        NSMutableDictionary *att = [NSMutableDictionary dictionary];
        att[NSForegroundColorAttributeName] = [UIColor orangeColor];
        //同下
        //[att setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
        [item setTitleTextAttributes:att forState:UIControlStateSelected];

    }

    // 当第一次使用这个类或者子类的时候调用
    // 作用：初始化类
    + (void)initialize{
       // NSLog(@"%s",__func__);
    }
*/
- (NSMutableArray *)items{
    
    if(_items == nil){

        _items = [NSMutableArray array];
    
    }
    
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    [self setUpAllChildViewController];
    
    // 自定义tabBar
    [self setUpTabBar];
    
    // 每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
    //ALTabBar *tabBar =[[ALTabBar alloc] initWithFrame:self.tabBar.frame];
    
    // 利用KVC把readOnly的属性改
    // 把类从UITabBar改为自定义的ALTabBar
    // [self setValue:tabBar forKeyPath:@"tabBar"];
    // objc_msgSend(self,@selector(setTabBar:),tabBar);
  

}
// 请求未读数
- (void)requestUnread{
    
    [ALUserTool unreadWithSuccess:^(ALUserResult *result) {
       
        // 设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        // 设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        // 设置应用程序所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark - 设置tabBar
- (void)setUpTabBar{

    //自定义tabBar
    ALTabBar *tabBar = [[ALTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;

    // 在系统自带的tabBar上添加自定义tabBar
    [self.tabBar addSubview:tabBar];
    
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(ALTabBar *)tabBar didClickButton:(NSInteger)index
{
//    self.selectedIndex 当前的页面   index 点下去的页面的索引
//    只有当点击首页，并且不是从别的页面跳来首页的时候才进行刷新操作
    if(index == 0 && self.selectedIndex == index){ // 点击首页，刷新
        [_home refresh];
    }
    self.selectedIndex = index;
}

// 点击加号按钮的时候调用
- (void)tabBarDidClickPlusButton:(ALTabBar *)tabBar{
    
    // 创建发送微博控制器
    ALComposeViewController *composeVc = [[ALComposeViewController alloc] init];
    ALNavigationController *nav = [[ALNavigationController alloc] initWithRootViewController:composeVc];
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}
// Item: 就是苹果的模型命名规范
// tabBarItem: 决定着tabBars上按钮的内容
// 如果通过模型设置控件的文字颜色，只能通过文本属性（富文本：颜色，字体，空心，阴影,图文混排）

// 在ios7之后，默认会把UITabbar上面的按钮图片渲染成蓝色

#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController{
    // 首页
    ALHomeViewController *home = [[ALHomeViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
     _home = home;
    
    // 消息
    ALMessageViewController *message = [[ALMessageViewController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    _message = message;
    
    // 发现
    ALDiscoverViewController *discover = [[ALDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    
    // 我
    ALProfileViewController *profile = [[ALProfileViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];

    _profile = profile;
}
#pragma mark - 添加一个子控件
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    //保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    // initWithRootViewController底层会调用导航控制器的push，把根控制器压入栈
    ALNavigationController *nav = [[ALNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}
@end
