//
//  ExchangeViewController.m
//  redbull
//
//  Created by Xin Qin on 11/27/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "ExchangeViewController.h"
#import "LoginViewController.h"
#import "WebFailView.h"

@interface ExchangeViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) UIView *webFailView;

@end

@implementation ExchangeViewController

extern int isLogin;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[UIImage imageNamed:@"03.jpg"]
                                                selectedImage:[UIImage imageNamed:@"03-1.jpg"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //
    _webView.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if(_bingStrUrl != nil){
        //加载传递来的URL
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_bingStrUrl]]];
    }else{
        //加载URL
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:EXCHANGE_PAGE]]];
    }
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
    
    //将携带来的url置空
    _bingStrUrl = nil;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_indicator stopAnimating];
    
    NSLog(@"exchange:webView.request.URL.absoluteString = %@",webView.request.URL.absoluteString);
    
    if (![webView.request.URL.absoluteString hasPrefix:EXCHANGE_PAGE]) {
        _webFailView = [WebFailView reSetWithTarget:self action:@selector(viewWillAppear:)];
        [self.view addSubview:_webFailView];
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"EXCHANGE请求地址:%@",request.URL.absoluteString);
    
    if (_webFailView) {
        [_webFailView removeFromSuperview];
    }
    
    if ([request.URL.absoluteString hasPrefix:BAIDU_OPEN_API]) {
        return NO;
    }
    
    if([request.URL.absoluteString hasPrefix:LOGIN_INDEX]){
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [loginViewController setValue:[self  mTabBarController] forKey:@"mTabBarController"];
        loginViewController.modalPresentationStyle =UIModalPresentationOverCurrentContext;
        [_mTabBarController presentViewController:loginViewController animated:YES completion:^{
            
        }];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:EXCHANGE_PAGE]]];
        
        return NO;
        
    }
    
    return YES;
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
