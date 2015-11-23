//
//  ALNewFeatureController.m
//  ArcBlog
//
//  Created by Arclin on 15/11/22.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALNewFeatureController.h"
#import "ALNewFeatureCell.h"
@interface ALNewFeatureController ()

@property (nonatomic, weak) UIPageControl *control;

@end

@implementation ALNewFeatureController

static NSString *ID = @"cell";

- (instancetype)init{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
   
    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 清空行距
    layout.minimumLineSpacing = 0;
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    return [super initWithCollectionViewLayout:layout];
}

// self.collection != self.view
// 注意：self.collectionView 是 self.view 的子控件

// 使用UICollectionViewController
// 1. 初始化的时候设置布局参数
// 2. collectionView必须要注册cell
// 3. 自定义cell
- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor blueColor];
    
    // 注册cell,默认会创建这个类型的cell
    [self.collectionView registerClass:[ALNewFeatureCell class] forCellWithReuseIdentifier:ID];
    
    // 分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;   //在第一页和最后一页的时候没有弹性
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 添加pageController
    [self setUpPageController];
}

// 添加pageController
- (void)setUpPageController{
    // 添加pageController，只需要设置位置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height);
    _control = control;
    [self.view addSubview:control];
}

#pragma mark - UIScrollView代理
// 只要一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    // 获取当前的漂移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _control.currentPage = page;
}
#pragma mark - UICollectionView 代理和数据源
// 返回有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
// 返回第session组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}


//返回cell长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // dequeueReusableCellWithReuseIdentifier
    // 1. 首先从缓存池中取cell
    // 2. 看下当前是否有注册cell，如果注册了cell，就帮你创建ell
    // 3. 没有注册，报错
    ALNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    // 给cell传值
    // 拼接图片名称 3.5寸屏幕 320*480
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    if (screenH > 480) { // 5 , 6 , 6 plus
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
    }
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath count:4];
    
    return cell;

}
@end
