//
//  ALPhotoView.m
//  ArcBlog
//
//  Created by Arclin on 15/12/26.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALPhotoView.h"
#import "UIImageView+WebCache.h"
#import "ALPhoto.h"

@interface ALPhotoView ()

@property (nonatomic,weak) UIImageView *gifView;

@end

@implementation ALPhotoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪图片，超出控件的部分裁减掉
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}
- (void)setPhoto:(ALPhoto *)photo{
    
    _photo = photo;
    // 赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 判断下是否为gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}
@end
