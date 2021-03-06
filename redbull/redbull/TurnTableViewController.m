//
//  TurnTableViewController.m
//  redbull
//
//  Created by Xin Qin on 11/27/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "TurnTableViewController.h"

#import "LoginViewController.h"
#import "WebFailView.h"

#import "StatementView.h"

@interface TurnTableViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) UIView *webFailView;

@end

@implementation TurnTableViewController

extern int isLogin;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[UIImage imageNamed:@"04.jpg"]
                                                selectedImage:[UIImage imageNamed:@"04-1.jpg"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //
    _webView.delegate = self;
    
    NSLog(@"%f",self.view.frame.size.width);
    
    StatementView *sv = [[StatementView alloc] initWithFrame:CGRectMake(60, self.view.center.y - 250, 200, 300)];
    sv.layer.masksToBounds = YES;
    sv.layer.cornerRadius = 5.f;
    [self.view addSubview:sv];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if(_bingStrUrl != nil){
        //加载传递来的URL
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_bingStrUrl]]];
    }else{
        //加载URL
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:TURNTABLE_PAGE]]];
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
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_indicator stopAnimating];
    
    NSLog(@"turn:webView.request.URL.absoluteString = %@",webView.request.URL.absoluteString);
    
    if (![webView.request.URL.absoluteString hasPrefix:TURNTABLE_PAGE]) {
        _webFailView = [WebFailView reSetWithTarget:self action:@selector(viewWillAppear:)];
        [self.view addSubview:_webFailView];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"TURN请求地址:%@",request.URL.absoluteString);
    
    if (_webFailView) {
        [_webFailView removeFromSuperview];
    }
    
    if ([request.URL.absoluteString hasPrefix:BAIDU_OPEN_API] || [request.URL.absoluteString hasPrefix:HTML5_APP_URL]) {
        return NO;
    }else if([request.URL.absoluteString hasPrefix:ASK_PAGE]) {
        [_mTabBarController  jumpToTabAtIndexNum:ASK_PAGE_INDEX withStrUrl:request.URL.absoluteString] ;
        return NO;
    }else if([request.URL.absoluteString hasPrefix:LOGIN_INDEX]){
        
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [loginViewController setValue:[self  mTabBarController] forKey:@"mTabBarController"];
        loginViewController.modalPresentationStyle = UIModalPresentationPageSheet;
        [_mTabBarController presentViewController:loginViewController animated:YES completion:^{
            
        }];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:TURNTABLE_PAGE]]];
        
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
