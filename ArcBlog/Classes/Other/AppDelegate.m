//
//  AppDelegate.m
//  ArcBlog
//
//  Created by Arclin on 15/11/16.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "AppDelegate.h"
#import "ALOAuthViewController.h"
#import "ALAccountTool.h"
#import "ALRootTool.h"
#import "ALOAuthViewController.h"
#import "SDWebImageManager.h"
#import <AVFoundation/AVFoundation.h>
/*
 LaunchScreen: 代替之前的启动图片
 好处：
 1.可以展示更多的东西
 2.可以只需要出一个大尺寸的图片
 
 启动图片的优先级
 启动图片 < LaunchScreen.xib
 
 程序中碰见模拟器尺寸不对，去找启动图片，默认模拟器由启动图片决定。
 
 UITabBarController控制器的view在一创建控制器的时候就会加载view
 UIViewController的view 是懒加载（用到时才会加载）

 封装思想：相同功能抽取出一个类封装好
 抽方法：一般一个功能就抽一个方法

 偏好设置存储的好处
 1.不需要关心文件名
 2.快速进行键值对存储
 
 OAuth授权：让数据更加安全
 流程：让数据提供商提供一个登录网站，显示在第三方客户端上面。
 OAuth授权：1.需要获取第三方数据；2.第三方登录；3.第三方分享。
 注意：并不是所有软件都能OAuth授权，必须成为第三方开发者，才能OAuth授权。
 */

@interface AppDelegate ()

@property (nonatomic,strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册桌面图标通知未读消息数（用户要同意才能显示）
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // 选择根控制器
    // 判断下有没有授权
    // 进行授权
    
    if([ALAccountTool account]){ // 已经授权
        // 选择根控制器
        [ALRootTool chooseRootViewController:self.window];
       
    }else{ //进行授权
        ALOAuthViewController *oauthVc = [[ALOAuthViewController alloc] init];
        // 设置窗口的根控制器
        self.window.rootViewController = oauthVc;
    }
    
    
    //显示窗口
    [self.window makeKeyAndVisible];
    //makeKeyAndVisible底层实现
    //1 .self.window.hidden = NO;
    //2. application.keyWindow = self.window;   //设self.window为主窗口
    // =====》相当于
    //NSLog(@"%@",self.window);
    
    
    return YES;
}
// 接受到内存警告时调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    // 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}

// 失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    // 无限播放
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
}

//  程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 开启一个后台任务，时间不确定，优先级比较低，假如系统要关闭应用，首先就考虑关闭该应用
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        // 当后台任务接受用的时候调用
        [application endBackgroundTask:ID];
    }];
    
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    // 微博： 在程序即将失去焦点的时候播放静音音乐。
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.sziit.ArcBlog" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ArcBlog" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ArcBlog.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
