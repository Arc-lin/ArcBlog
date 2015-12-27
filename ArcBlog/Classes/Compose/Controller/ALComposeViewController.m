//
//  ALComposeViewController.m
//  ArcBlog
//
//  Created by Arclin on 15/12/26.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALComposeViewController.h"
#import "ALTextView.h"

@interface ALComposeViewController ()<UITextViewDelegate>

@property (nonatomic,weak) ALTextView *textView;

@end

@implementation ALComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条
    [self setUpNavgationBar];
    
    // 添加textView
    [self setUpTextView];
}

#pragma mark - 添加textView
- (void)setUpTextView{
    
    ALTextView *textView = [[ALTextView alloc] initWithFrame:self.view.bounds];
    _textView = textView;
    // 设置占位符
    textView.placeHolder = @"在此输入微博";
    textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:textView];

    // 监听文本框的输入
    // Observe： 谁需要监听通知 name： 监听通知的名称 object： 监听谁发送的通知，nil：表示谁发送我都监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];

    // 监听拖拽
    _textView.delegate = self;
    // 默认允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    
}

#pragma mark - 开始拖拽textView的时候调用
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

// 监听textView的值得变化
- (void)textChange
{
    // 判断下textView有没有内容
    if (_textView.text.length) { // 有内容
        _textView.hidePlaceHolder = YES;
    }else{
        _textView.hidePlaceHolder = NO;
    }
}

// textView 出现的时候弹出键盘
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [_textView becomeFirstResponder];
}

//  移除监听
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpNavgationBar
{
    self.title = @"发微博";
    
    // left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    // right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit]; // 自动调整尺寸和位置（frame）
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

// 发送微博
- (void)compose
{
    
}
- (void)dismiss
{
    // 退出
    [self dismissViewControllerAnimated:YES completion:nil];
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
