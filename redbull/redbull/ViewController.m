//
//  ViewController.m
//  redbull
//
//  Created by Xin Qin on 11/26/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.redbullclub.cn/index.php?s=M"]]];
    
    _webView.scrollView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
