//
//  FirstViewController.m
//  redbull
//
//  Created by Xin Qin on 11/27/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "FirstViewController.h"
#import "LoginViewController.h"
#import "WebFailView.h"

@interface FirstViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) UIView *webFailView;


@end

@implementation FirstViewController

extern int isLogin;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[UIImage imageNamed:@"01.jpg"]
                                                selectedImage:[UIImage imageNamed:@"01-1.jpg"]];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //委托协议
    _webView.delegate = self;
    
    //加载URL
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:INDEX_PAGE]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"FirstView --->");
    //加载URL
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:INDEX_PAGE]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
    NSLog(@"webview error");
    
    [_indicator stopAnimating];
    
    NSLog(@"first:webView.request.URL.absoluteString = %@",webView.request.URL.absoluteString);
    
    if (![webView.request.URL.absoluteString hasPrefix:INDEX_PAGE]) {
        _webFailView = [WebFailView reSetWithTarget:self action:@selector(viewDidLoad)];
        [self.view addSubview:_webFailView];
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"INDEX请求地址:%@",request.URL.absoluteString);
    if (_webFailView) {
        [_webFailView removeFromSuperview];
    }
    
    if ([request.URL.absoluteString hasPrefix:BAIDU_OPEN_API]) {
        return NO;
    }
    
    if([request.URL.absoluteString hasPrefix:ASK_PAGE]) {
        [_mTabBarController  jumpToTabAtIndexNum:ASK_PAGE_INDEX withStrUrl:request.URL.absoluteString] ;
        return NO;
    }else if([request.URL.absoluteString hasPrefix:EXCHANGE_PAGE]) {
        [_mTabBarController  jumpToTabAtIndexNum:EXCHANGE_PAGE_INDEX withStrUrl:request.URL.absoluteString] ;
        return NO;
    }else if([request.URL.absoluteString hasPrefix:EXCHANGE_DETAIL_PAGE]) {
        [_mTabBarController  jumpToTabAtIndexNum:EXCHANGE_DETAIL_PAGE_INDEX withStrUrl:request.URL.absoluteString] ;
        return NO;
    }else if ([request.URL.absoluteString hasPrefix:HTML5_APP_URL]) {
        return NO;
    }
    
    return YES;
}

@end
