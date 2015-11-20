//
//  ALTabBarController.m
//  ArcBlog
//
//  Created by Arclin on 15/11/17.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALTabBarController.h"
#import "ALTabBar.h"
#import "ALNavigationViewController.h"
#import "ALHomeViewController.h"
#import "ALDiscoverViewController.h"
#import "ALMessageViewController.h"
#import "ALProfileViewController.h"
@interface ALTabBarController ()<ALTabBarDelegate>

@property (nonatomic,strong) NSMutableArray *items;

@property (nonatomic,weak) ALHomeViewController *home;

@end

@implementation ALTabBarController

// 什么时候调用：程序一启动的时候就会把所有的类加载进内存
// 作用：加载类的时候调用
// appearance 只要一个类遵守UIAppearance 就能获取到全局的外观，UIView

//+ (void)load{
//
//    //获取所有的tabBarItem外观标识
////    UITabBarItem *item  = [UITabBarItem appearance];
//    //获取当前这个类下面的所有tabBarItem
//    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
//    NSMutableDictionary *att = [NSMutableDictionary dictionary];
//    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    //同下
//    //[att setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//    [item setTitleTextAttributes:att forState:UIControlStateSelected];
//
//}
//
//// 当第一次使用这个类或者子类的时候调用
//// 作用：初始化类
//+ (void)initialize{
//   // NSLog(@"%s",__func__);
//}

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
    
    //ALTabBar *tabBar =[[ALTabBar alloc] initWithFrame:self.tabBar.frame];

    // 利用KVC把readOnly的属性改
    // 把类从UITabBar改为自定义的ALTabBar
    // [self setValue:tabBar forKeyPath:@"tabBar"];
//    objc_msgSend(self,@selector(setTabBar:),tabBar);

}

#pragma mark - 设置tabBar
- (void)setUpTabBar{

    //自定义tabBar
    ALTabBar *tabBar = [[ALTabBar alloc] initWithFrame:self.tabBar.frame];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;

    // 添加自定义tabBar
    [self.view addSubview:tabBar];
    
    // 移除系统的tabBar
    [self.tabBar removeFromSuperview];
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(ALTabBar *)tabBar didClickButton:(NSInteger)index
{
    self.selectedIndex = index;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    
    // 发现
    ALDiscoverViewController *discover = [[ALDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    
    // 我
    ALProfileViewController *profile = [[ALProfileViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];

    
}
#pragma mark - 添加一个子控件
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{

    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    //保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    ALNavigationViewController *nav = [[ALNavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end
