//
//  ALComposePhotosView.m
//  ArcBlog
//
//  Created by Arclin on 16/1/3.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import "ALComposePhotosView.h"

@implementation ALComposePhotosView

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

// 每添加一个子控件的时候也会调用，如果在viewDidLoad添加子控件，就不会调用layoutSubViews
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat margin = 10;
    CGFloat wh = (self.width - (cols - 1) * margin) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageV = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (margin + wh);
        y = row * (margin + wh);
        imageV.frame = CGRectMake(x, y, wh, wh);
    }
    
}

@end
