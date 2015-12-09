//
//  ALNavigationController.m
//  ArcBlog
//
//  Created by Arclin on 15/11/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALNavigationController.h"
#import "UIBarButtonItem+Item.h"
@interface ALNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) id popDelegate;

@end

@implementation ALNavigationController

+ (void)initialize{
    
    //获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName]  = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //设置非根控制器
    if (self.viewControllers.count) {
        
        // 设置导航条左边按钮和右边按钮
        // 如果把导航条上的返回按钮覆盖，滑动返回功能就没有
        // 左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        // 右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [super pushViewController:viewController animated:animated];
}

// 导航控制器即将显示新的控制器时调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 获取主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    // 获取tableBarVc rootViewController
    UITabBarController *tabBarVc = (UITabBarController *) keyWindow.rootViewController;
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

// 导航控制器跳转完成时调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    ALLog(@"%@",self.viewControllers[0]); // 根控制器是NavigationController的第一个子控制器
    if (viewController == self.viewControllers[0]) { // 显示根控制器
        
        // 还原滑动返回手势的代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
               
    }else{ // 不是显示根控制器
        
        // 实现滑动返回功能
        // 清空滑动返回手势的代理，就能实现滑动功能
        self.interactivePopGestureRecognizer.delegate = nil;
    
    }
}

- (void)backToPre{
    [self popViewControllerAnimated:YES];
}
- (void)backToRoot{
    // 回到根控制器
    [self popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _popDelegate = self.interactivePopGestureRecognizer.delegate;

    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
