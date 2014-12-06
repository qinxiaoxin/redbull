//
//  FirstViewController.m
//  redbull
//
//  Created by Xin Qin on 11/27/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "FirstViewController.h"
#import "LoginViewController.h"

@interface FirstViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation FirstViewController

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
    [_indicator stopAnimating];
}

@end
