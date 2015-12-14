//
//  ALOAuthViewController.m
//  ArcBlog
//
//  Created by Arclin on 15/11/23.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "ALAccount.h"
#import "ALRootTool.h"
#import "ALAccountTool.h"


@interface ALOAuthViewController ()<UIWebViewDelegate>

@end

@implementation ALOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 展示登陆的网页 -》 UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    // 加载网页
    // 一个完整的URL: 基本URL + 参数
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"2012167609";
    NSString *redirect_uri = @"http://www.baidu.com";
    
    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 加载请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 加载请求
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;

}

#pragma mark - UIWebVie代理
- (void)webViewDidStartLoad:(UIWebView *)webView{
    // 提示用户正在加载……
    [MBProgressHUD showMessage:@"正在加载..."];
    
}
// webView 加载完成的时候使用
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}
// webView 加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}
// 拦截webView请求
// 当WebView需要加载一个请求的时候，就会调用这个方法，询问下是否请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    // 获取code（RequestToken）
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) { // 有"code="字符串出现的才截取开始截取
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        // 换取accessToken
        [self accessTokenWithCode:code];
        
        // 不加载回调界面
        return NO;
    }
    // NSLog(@"%@",urlStr);
    return YES;
}

//client_id	true	string	申请应用时分配的AppKey。
//client_secret	true	string	申请应用时分配的AppSecret。
//grant_type	true	string	请求的类型，填写authorization_code

//grant_type为authorization_code时
//必选	类型及范围	说明
//code	true	string	调用authorize获得的code值。
//redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。



#pragma mark - 换取accessToken
// access_token:表示哪个用户在哪个软件下的标识符，获取access_token就可以得到新浪微博的数据
// uid：用户的唯一标识符
- (void) accessTokenWithCode:(NSString *)code{
    
    [ALAccountTool accessTokenWithCode:code success:^{
        // 进入主页或者新特性，选择窗口的根控制器
        [ALRootTool chooseRootViewController:ALKeyWindow];
    } failure:^(NSError *error) {
        
    }];
    
    
    
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
