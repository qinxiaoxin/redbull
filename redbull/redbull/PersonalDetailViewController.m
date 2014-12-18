//
//  PersonalDetailViewController.m
//  redbull
//
//  Created by Xin Qin on 12/4/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "PersonalDetailViewController.h"

#import "Navbar.h"

#import "DDMenuController.h"

@interface PersonalDetailViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation PersonalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _navigationBar.backgroundColor = [UIColor colorWithRed:47 / 255.f green:47 / 255.f blue:49 / 255.f alpha:1.f];

    _titleLabel.text = self.navigationBarTitle;
    
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
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString =====> %@",requestString);
    NSString *indexPage = [NSString stringWithFormat:@"%@/",INDEX_PAGE];
    if ([requestString isEqualToString:HTML5_APP_URL]||[requestString isEqualToString:indexPage]||[requestString isEqualToString:WHAT_LOGIN_INDEX]){
        self.webURL = nil;
        
        [self dismissViewControllerAnimated:YES completion:nil];
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
