//
//  ALTitleButton.m
//  ArcBlog
//
//  Created by Arclin on 15/11/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALTitleButton.h"

@implementation ALTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage imageWithStretchableName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.currentImage == nil) {
        return;
    }
    
    // title
    self.titleLabel.x  = self.imageView.x;
    
    // image
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}

// 重写setTitle方法，扩展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    
    [super setTitle:title forState:state];
    [self sizeToFit];

}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
