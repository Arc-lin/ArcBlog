//
//  ALPhotosView.m
//  ArcBlog
//
//  Created by Arclin on 15/12/23.
//  Copyright © 2015年 sziit. All rights reserved.
//  

#import "ALPhotosView.h"
#import "ALPhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@implementation ALPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 添加9个子控件
        [self setUpAllChildView];

    }
    return self;
}

// 添加9个子控件
- (void)setUpAllChildView
{
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪图片，超出控件的部分裁减掉
        imageView.clipsToBounds = YES;
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        
        // 添加敲击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
}

#pragma mark - 点击图片的时候调用
- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = (UIImageView *)tap.view;

    // ALPhoto -> MJPhoto
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (ALPhoto *photo in _pic_urls) {
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    // MJPhoto
    browser.photos = arrM;
    browser.currentPhotoIndex = tapView.tag;
    [browser show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    int count = (int)self.subviews.count;
    for (int i = 0; i < count; i++) {
        
        UIImageView *imageView = self.subviews[i];
        
        if (i < _pic_urls.count) { // 显示
            
            imageView.hidden =NO;
            
            // 获取
            ALPhoto *photo = _pic_urls[i];
            
            // 赋值
            [imageView sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

        }else{
            imageView.hidden = YES;
        }
    }
}

// 计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count == 4 ? 2 : 3;
    // 计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageView = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageView.frame  = CGRectMake(x, y, w, h);
        
    }
}
@end
