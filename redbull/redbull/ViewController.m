//
//  ViewController.m
//  redbull
//
//  Created by Xin Qin on 11/26/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "ViewController.h"
#import "RightShareViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (strong, nonatomic) UIButton *shareButton;

@property (strong, nonatomic) RightShareViewController *rsvc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //加载URL
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:HTML5_APP_URL]];
    request.timeoutInterval = 15.f;
    [_webView loadRequest:request];
    
    _webView.delegate = self;
    
    //去掉边界滑动
    _webView.scrollView.bounces = NO;
    
    //滑动加速
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    //add share button
//    _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 0, 100, 100)];
//    [_shareButton addTarget:self action:@selector(slideViewRSVC:) forControlEvents:UIControlEventTouchUpInside];
//    [self.webView addSubview:_shareButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)slideViewRSVC:(id)sender
//{
//    UIButton *button = (UIButton *)sender;
//    
//    if(!button.selected){
//        button.selected = YES;
//        [self showRightViewController];
//    }else{
//        button.selected = NO;
//        [self hideRightViewController];
//    }
//}

//- (void)showRightViewController
//{
//    
//    CGRect frame = self.view.bounds;
//    frame.origin.x = -kMenuDisplayedWidth; //240
//    [UIView animateWithDuration:kMenuSlideDuration animations:^{
//        self.view.frame = frame;
//    } completion:^(BOOL finished) {
//        
//    }];
//}
//
//- (void)hideRightViewController
//{
//    CGRect frame = self.view.bounds;
//    frame.origin.x = 0;
//    [UIView animateWithDuration:kMenuSlideDuration animations:^{
//        self.view.frame = frame;
//    } completion:^(BOOL finished) {
//        
//    }];
//}

#pragma mark - UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_indicator stopAnimating];
    
    //去掉webView长按列表时的复制事件
    [_webView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
    
    //禁用用户选择
    [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_indicator stopAnimating];
    
    NSLog(@"error = %@",error);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"url:%@",request.URL);
    return YES;
}

@end
