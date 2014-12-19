//
//  RightViewController.m
//  redbull
//
//  Created by Xin Qin on 12/2/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "RightViewController.h"

#import "DDMenuController.h"

#import "WXApi.h"

#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>

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
//    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
//    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
//    sdvc.webURL = SHARE_WEIBO;
//    [menuController presentViewController:sdvc animated:YES completion:^{
//        
//    }];
     NSString* string = [SHARE_WEIBO stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

- (IBAction)shareTecent:(id)sender
{
    if(![self checkQQ]) return;
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"login_qq.jpg"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    NSURL* url = [NSURL URLWithString:APP_ID];
    
    QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:@"能量部落，你的能量超乎你想象" description:@"" previewImageData:data];
    
    SendMessageToQQReq * msg = [SendMessageToQQReq reqWithContent:img];
    QQApiSendResultCode sent = [QQApiInterface sendReq:msg];
    NSLog(@"%d",sent);
}

- (BOOL)checkQQ
{
    if(![QQApi isQQInstalled])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机未安装QQ应用" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    
    if(![QQApi isQQSupportApi])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"warning" message:@"Open API is not supported by current QQ" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    
    return YES;
}

- (IBAction)shareWeChat:(id)sender
{
    WXMediaMessage *message = [WXMediaMessage message];
    //设置分享标题信息
    message.title = @"能量部落，你的能量超乎你想象";
    
    //设置分享内容信息
//    message.description = @"能量部落，你的能量超乎你想象";
    
    [message setThumbImage:[UIImage imageNamed:@"face"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    
    //设置分享链接地址信息
    ext.webpageUrl = APP_ID;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

- (IBAction)shareRenren:(id)sender
{
//    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
//    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
//    sdvc.webURL = SHARE_RENREN;
//    [menuController presentViewController:sdvc animated:YES completion:^{
//        
//    }];
     NSString *string = [SHARE_RENREN stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

- (IBAction)shareDouban:(id)sender
{
//    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
//    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
//    sdvc.webURL = SHARE_DOUBAN;
//    [menuController presentViewController:sdvc animated:YES completion:^{
//        
//    }];
    NSString *string = [SHARE_DOUBAN stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

- (IBAction)shareQQzone:(id)sender
{
//    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
//    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
//    sdvc.webURL = SHARE_QQZONE;
//    [menuController presentViewController:sdvc animated:YES completion:^{
//        
//    }];
    NSString *string = [SHARE_QQZONE stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

- (IBAction)shareKaixin:(id)sender
{
//    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
//    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
//    sdvc.webURL = SHARE_KAIXIN;
//    [menuController presentViewController:sdvc animated:YES completion:^{
//        
//    }];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SHARE_KAIXIN]];
}

- (IBAction)shareTaobao:(id)sender
{
//    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
//    ShareDetailViewController *sdvc = [[ShareDetailViewController alloc] init];
//    sdvc.webURL = SHARE_TAOBAO;
//    [menuController presentViewController:sdvc animated:YES completion:^{
//        
//    }];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SHARE_TAOBAO]];
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
