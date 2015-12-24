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
        // 裁剪图片
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
    }
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
