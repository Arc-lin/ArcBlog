//
//  ALNewFeatureCell.m
//  ArcBlog
//
//  Created by Arclin on 15/11/22.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALNewFeatureCell.h"
#import "ALTabBarController.h"
@interface ALNewFeatureCell()

@property (nonatomic,weak) UIImageView *imageView;

@property (nonatomic,weak) UIButton *shareButton;

@property (nonatomic,weak) UIButton *startButton;

@end

@implementation ALNewFeatureCell

- (UIButton *)shareButton{

    if (_shareButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        
        [self.contentView addSubview:btn];
        _shareButton = btn;
    }
    return _shareButton;
}

- (UIButton *)startButton{
    
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
        
    }
    return _startButton;
}
- (UIImageView *)imageView{

    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
    
        // 注意：一定要加载contentView
        [self.contentView addSubview:imageV];
    }
    
    return _imageView;
}

// 布局子控件的frame
- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    // 分享按钮
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    
    // 开始按钮
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
    
}

- (void)setImage:(UIImage *)image{

    _image = image;
    
    self.imageView.image = _image;
}

//判断当前cell是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count{
    
    if (indexPath.row == count - 1 ) { //最后一页，显示分享和开始按钮
      
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    
    }else{  //非最后一页，隐藏分享和开始按钮
    
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    
    }
}

// 点击开始微博时调用
- (void)start{
    // 进入tabBarVc
    ALTabBarController *tabBarVc = [[ALTabBarController alloc] init];
    
    // 切换根控制器
    ALKeyWindow.rootViewController = tabBarVc;
}
@end
