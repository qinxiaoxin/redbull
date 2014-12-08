//
//  RightViewController.m
//  redbull
//
//  Created by Xin Qin on 12/2/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "RightViewController.h"

#import "ShareDetailViewController.h"

#import "DDMenuController.h"

@interface RightViewController ()

@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIImageView *drawLine;

- (void)setInitDrawLine;    //一键分享下方的横线

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set view color
    self.view.backgroundColor = [UIColor colorWithRed:33 / 255.f green:33 / 255.f blue:35 / 255.f alpha:1.f];
    
    self.navView.backgroundColor = [UIColor colorWithRed:47 / 255.f green:47 / 255.f blue:49 / 255.f alpha:1.f];
    
    [self setInitDrawLine];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setInitDrawLine
{
    //set draw line
    UIGraphicsBeginImageContext(_drawLine.frame.size);
    [_drawLine.image drawInRect:CGRectMake(0, 0, _drawLine.frame.size.width, _drawLine.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.5f);//线宽度
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 18 / 255.f, 18 / 255.f, 18 / 255.f, 1.f);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, _drawLine.frame.size.height / 2);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), _drawLine.frame.size.width, _drawLine.frame.size.height / 2);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    _drawLine.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (IBAction)shareWeibo:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
    sdvc.webURL = SHARE_WEIBO;
    [menuController presentViewController:sdvc animated:YES completion:^{
        
    }];
}

- (IBAction)shareTecent:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
    sdvc.webURL = SHARE_TECENT;
    [menuController presentViewController:sdvc animated:YES completion:^{
        
    }];
}

- (IBAction)shareRenren:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
    sdvc.webURL = SHARE_RENREN;
    [menuController presentViewController:sdvc animated:YES completion:^{
        
    }];
}

- (IBAction)shareDouban:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
    sdvc.webURL = SHARE_DOUBAN;
    [menuController presentViewController:sdvc animated:YES completion:^{
        
    }];
}

- (IBAction)shareQQzone:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
    sdvc.webURL = SHARE_QQZONE;
    [menuController presentViewController:sdvc animated:YES completion:^{
        
    }];
}

- (IBAction)shareKaixin:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
    sdvc.webURL = SHARE_KAIXIN;
    [menuController presentViewController:sdvc animated:YES completion:^{
        
    }];
}

- (IBAction)shareTaobao:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
    sdvc.webURL = SHARE_TAOBAO;
    [menuController presentViewController:sdvc animated:YES completion:^{
        
    }];
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
