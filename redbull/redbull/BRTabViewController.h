//
//  BRTabViewController.h
//  redbull
//
//  Created by Magic on 14/12/7.
//  Copyright (c) 2014年 Xin Qin. All rights reserved.
//

#import "ViewController.h"
#import "GGTabBarController.h"

@interface BRTabViewController : ViewController{
    GGTabBarController *_mTabBarController;
    NSString *_bingStrUrl;
}

@property (retain,nonatomic) NSString *bingStrUrl;
@property (retain,nonatomic) GGTabBarController *mTabBarController;
-(void)setTabBarController:(GGTabBarController*)tabBarController;

@end
