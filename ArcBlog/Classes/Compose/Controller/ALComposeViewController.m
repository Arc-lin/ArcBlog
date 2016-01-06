//
//  ALComposeViewController.m
//  ArcBlog
//
//  Created by Arclin on 15/12/26.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALComposeViewController.h"
#import "ALTextView.h"
#import "ALComposeToolBar.h"
#import "ALComposePhotosView.h"
#import "ALComposeTool.h"
#import "MBProgressHUD+MJ.h"

@interface ALComposeViewController ()<UITextViewDelegate,ALComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak) ALTextView *textView;
@property (nonatomic,weak) ALComposeToolBar *toolBar;
@property (nonatomic,weak) ALComposePhotosView *photosView;
@property (nonatomic,strong) UIBarButtonItem *rightItem;

@property (nonatomic,strong) NSMutableArray *images;

@end

@implementation ALComposeViewController

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条
    [self setUpNavgationBar];
    
    // 添加textView
    [self setUpTextView];
    
    // 添加工具条
    [self setUpToolBar];
    
    // 监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

    // 添加相册视图
    [self setUpPhotosView];
}

- (void)setUpPhotosView
{
    ALComposePhotosView *photosView = [[ALComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    _photosView = photosView;
    
    [_textView addSubview:photosView];
}

#pragma mark - 键盘的frame改变的时候调用
- (void)keyboardFrameChange:(NSNotification *)note
{
    // 键盘弹出所花的时间
    CGFloat durtion = [note.userInfo [UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y == self.view.height) { // 没有弹出键盘
        // 恢复原来的样子
        _toolBar.transform = CGAffineTransformIdentity;
    }else { // 弹出键盘
        // 工具条往上移动258
        [UIView animateWithDuration:durtion animations:^{
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
        
    }
}
- (void)setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    ALComposeToolBar *toolBar = [[ALComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}

#pragma mark - 点击工具条 按钮的时候调用
- (void)composeToolBar:(ALComposeToolBar *)toolBar didClickBtn:(NSInteger)index
{
    if (index == 0) { // 点击相册
        // 弹出系统的相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 设置相册类型，相册集
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark = 选择照片完成的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 获取选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    _photosView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _rightItem.enabled = YES;
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
        _rightItem.enabled = YES;
    }else{
        _textView.hidePlaceHolder = NO;
        _rightItem.enabled = NO;
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
    
    // 监听按钮的点击
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = YES;
    self.navigationItem.rightBarButtonItem = rightItem;
    _rightItem = rightItem;
    
}

// 发送微博
- (void)compose
{
    // 新浪上传： 文字不能为空，分享图片
    // 二进制数据不能拼接url的参数，只能使用formdata
    // 判断下有没有图片
    if (self.images.count) {
        // 发送图片
        [self sendPicture];
    }else{
        // 发送文字
        [self sendTitle];
    }
  
}

#pragma mark - 发送图片
- (void)sendPicture
{
    UIImage *image = self.images[0];
    
    NSString *status = _textView.text.length?_textView.text:@"分享图片";
    
    _rightItem.enabled = YES;
    // 我引用你，你引用我
    [ALComposeTool composeWithStatus:status image:image success:^{
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送图片成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        _rightItem.enabled = YES;
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error.description);
        [MBProgressHUD showSuccess:@"发送图片失败"];
        _rightItem.enabled = YES;
        
    }];
}

#pragma mark - 发送文字
- (void)sendTitle
{
    [ALComposeTool composeWithStatus:_textView.text success:^{
        
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
