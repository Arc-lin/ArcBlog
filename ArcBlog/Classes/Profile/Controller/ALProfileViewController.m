//
//  ALProfileViewController.m
//  ArcBlog
//
//  Created by Arclin on 15/11/20.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALProfileViewController.h"
#import "UIImageView+WebCache.h"

@interface ALProfileViewController ()

@end

@implementation ALProfileViewController

static NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = setting;
}

#pragma mark - 点击设置的时候调用
- (void)setting{
    ALLog(@"test---setting");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = @"清空图片缓存";
    
    // 获取sdwebImage的缓存,单位：bite
    NSString *title = nil;
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    if (size > 1024 * 1024) { // 大于1M
        CGFloat floatSize = size / 1024.0 / 1024.0;
        title = [NSString stringWithFormat:@"%.fM",floatSize];
    }else if(size > 1024){
        CGFloat floatSize = size / 1024.0;
        title = [NSString stringWithFormat:@"%.fKb",floatSize];
    }else if(size > 0){
        title = [NSString stringWithFormat:@"%ldb",size];
    }
    
    cell.detailTextLabel.text = title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SDImageCache sharedImageCache] clearDisk];
    
    [self.tableView reloadData];
}

@end
