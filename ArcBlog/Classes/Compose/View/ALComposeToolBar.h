//
//  ALComposeToolBar.h
//  ArcBlog
//
//  Created by Arclin on 15/12/27.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALComposeToolBar;
@protocol ALComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(ALComposeToolBar *)toolBar didClickBtn:(NSInteger)index;

@end

@interface ALComposeToolBar : UIView

@property (nonatomic,weak) id<ALComposeToolBarDelegate> delegate;

@end
