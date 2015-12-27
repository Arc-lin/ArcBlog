//
//  ALTextView.m
//  ArcBlog
//
//  Created by Arclin on 15/12/27.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALTextView.h"

@interface ALTextView ()

@property (nonatomic,weak) UILabel *placeHolderLabel;

@end

@implementation ALTextView

- (UILabel *)placeHolderLabel
{
    if (_placeHolderLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        
        [self addSubview:label];
        
        _placeHolderLabel = label;
    }
    
    return _placeHolderLabel;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeHolderLabel.font = font;
    
    [self.placeHolderLabel sizeToFit];
}
- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
    // label的尺寸跟文字一样
    [self.placeHolderLabel sizeToFit];
    
}
- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder{
    
    _hidePlaceHolder = hidePlaceHolder;
    
    self.placeHolderLabel.hidden = hidePlaceHolder;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;

}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
}
@end
