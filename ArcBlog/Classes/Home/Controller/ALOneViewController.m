//
//  ALOneViewController.m
//  ArcBlog
//
//  Created by Arclin on 15/11/19.
//  Copyright © 2015年 sziit. All rights reserved.
//

#import "ALOneViewController.h"
#import "ALTwoViewController.h"

@interface ALOneViewController ()

@end

@implementation ALOneViewController

//init 底层调用initWithNibName
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    //ALLog(@"init 实现就是调用这个方法 ： %s",__func__);
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (IBAction)jump2two:(id)sender {
    ALTwoViewController *two = [[ALTwoViewController alloc] init];
    [self.navigationController pushViewController:two animated:YES];
}

- (void)viewDidLoad {
    
    // Do any additional setup after loading the view.
    
}


@end
