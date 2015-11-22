//
//  ALNewFeatureCell.m
//  ArcBlog
//
//  Created by Arclin on 15/11/22.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALNewFeatureCell.h"

@interface ALNewFeatureCell()

@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation ALNewFeatureCell

- (UIImageView *)imageView{

    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
    
        // 注意：一定要加载contentView
        [self.contentView addSubview:imageV];
    }
    
    return _imageView;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

- (void)setImage:(UIImage *)image{

    _image = image;
    
    self.imageView.image = _image;
}
@end
