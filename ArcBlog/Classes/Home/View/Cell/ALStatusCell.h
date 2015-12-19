//
//  ALStatusCell.h
//  ArcBlog
//
//  Created by Arclin on 15/12/18.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALStatus;
@interface ALStatusCell : UITableViewCell

@property (nonatomic,strong) ALStatus *status;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
