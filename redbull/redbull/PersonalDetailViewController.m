//
//  PersonalDetailViewController.m
//  redbull
//
//  Created by Xin Qin on 12/4/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "PersonalDetailViewController.h"

#import "Navbar.h"

#import "AFNetworking.h"
#import "SBJson.h"
#import "Masonry.h"

#import "DDMenuController.h"

#import "LoginViewController.h"

#import "WebFailView.h"

@interface PersonalDetailViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) WebFailView *webFailView;

@end

@implementation PersonalDetailViewController

extern int isLogin;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _navigationBar.backgroundColor = [UIColor colorWithRed:47 / 255.f green:47 / 255.f blue:49 / 255.f alpha:1.f];

    _titleLabel.text = self.navigationBarTitle;
    
    self.view.backgroundColor = hll_color(243, 243, 243, 1);
    
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backAction:(id)sender
{
    self.webURL = nil;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
    
    NSLog(@"webView.request.URL.absoluteString = %@",webView.request.URL.absoluteString);
    
    if (![webView.request.URL.absoluteString hasPrefix:INDEX_PAGE]) {
        _webFailView = [WebFailView reSetWithTarget:self action:@selector(backAction:)];
        _webFailView.frame = CGRectMake(0, 44, ScreenWidth, ScreenHeight - 44);
        [_webFailView.reClick removeFromSuperview];
        [self.view addSubview:_webFailView];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString =====> %@",requestString);
    NSString *indexPage = [NSString stringWithFormat:@"%@/",INDEX_PAGE];
    if ([requestString isEqualToString:HTML5_APP_URL]||[requestString isEqualToString:indexPage]||[requestString isEqualToString:WHAT_LOGIN_INDEX] || [requestString isEqualToString:HTML5_APP_URL_1] || [requestString isEqualToString:SAVE_ADDRESS] || [requestString isEqualToString:EXCHANGE_PAGE]){
        
        self.webURL = nil;
       
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    if([requestString hasPrefix:(LOGIN_WEIBO_SUCCESS)]){
        isLogin = 1;
    }
    
    return YES;
}

- (void)ProfileGet
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    [httpClient getPath:PROFILE_URL
             parameters:NULL
                success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"返回结果:%@",responseStr);
         SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
         NSError *error = nil;
         NSDictionary *dic=[[NSDictionary alloc]init];
         dic = [jsonParser objectWithString:responseStr error:&error];
         NSLog(@"请求成功---->%@",dic);
         NSLog(@"%@",[dic objectForKey:@"errordesc"]);
         
    }
                failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"message:@"网络错误"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
         [alert show];
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
