//
//  LeftViewController.m
//  redbull
//
//  Created by Xin Qin on 12/2/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "LeftViewController.h"
#import "PortraitBGView.h"

@interface LeftViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set view color
    self.view.backgroundColor = [UIColor colorWithRed:33 / 255.f green:33 / 255.f blue:35 / 255.f alpha:1.f];
    
    //set portrait bg color
//    self.portraitBGView.backgroundColor = [UIColor colorWithRed:47 / 255.f green:47 / 255.f blue:49 / 255.f alpha:1.f];
    
    //portrait 圆角
    _portraitImageView.layer.borderColor = [UIColor colorWithRed:47 / 255.f green:47 / 255.f blue:49 / 255.f alpha:1.f].CGColor;
    _portraitImageView.layer.cornerRadius = 40.f;
    _portraitImageView.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
