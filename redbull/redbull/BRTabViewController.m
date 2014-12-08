//
//  BRTabViewController.m
//  redbull
//
//  Created by Magic on 14/12/7.
//  Copyright (c) 2014年 Xin Qin. All rights reserved.
//

#import "BRTabViewController.h"

@interface BRTabViewController ()
 
@end

@implementation BRTabViewController

@synthesize mTabBarController  = _mTabBarController;
@synthesize bingStrUrl = _bingStrUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**设置当前*/
-(void)setTabBarController:(GGTabBarController*)tabBarController{
    _mTabBarController  = tabBarController;
}


@end
