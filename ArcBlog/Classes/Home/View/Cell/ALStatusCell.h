//
//  ALStatusCell.h
//  ArcBlog
//
//  Created by Arclin on 15/12/18.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALStatusFrame;
@interface ALStatusCell : UITableViewCell

@property (nonatomic,strong) ALStatusFrame *statusF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
