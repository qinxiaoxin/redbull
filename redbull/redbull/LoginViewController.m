//
//  LoginViewController.m
//  redbull
//
//  Created by LC on 14/12/1.
//  Copyright (c) 2014年 Xin Qin. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "SBJson.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [_keyBoardController addToolbarToKeyboard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI
- (void)_initView {
    self.view.backgroundColor = hll_color(200, 200, 200, 1);
    
    UIView *logView = [[UIView alloc] initWithFrame:CGRectMake(5, FSystenVersion>=7.0?64:44, ScreenWidth - 10, 230)];
    logView.backgroundColor = hll_color(240, 240, 240, 1);
    [self.view addSubview:logView];
    
    UIView *redline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, logView.width, 3)];
    redline.backgroundColor = hll_color(252, 74, 57, 1);
    [logView addSubview:redline];
    
    UIImageView *titleImage = [[UIImageView alloc] init];
    titleImage.frame = CGRectMake(logView.width/2-50, redline.bottom+5, 15, 15);
    titleImage.backgroundColor = [UIColor clearColor];
    titleImage.image = [UIImage imageNamed:@""];
    [logView addSubview:titleImage];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleImage.right+5, titleImage.top+3, 90, 10)];
    titleLabel.text = @"用户登录";
    titleLabel.textColor = hll_color(210, 40, 39, 1);
    [logView addSubview:titleLabel];
    
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, titleLabel.bottom +20, logView.width-40, 30)];
    _usernameTextField.placeholder = @" 登录名";
    _usernameTextField.font = [UIFont systemFontOfSize:12.0f];
    _usernameTextField.backgroundColor = hll_color(210, 210, 210, 1);
    [logView addSubview:_usernameTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, _usernameTextField.bottom +15, logView.width-40, 30)];
    _passwordTextField.placeholder = @" ******";
    _passwordTextField.font = [UIFont systemFontOfSize:12.0f];
    _passwordTextField.backgroundColor = hll_color(210, 210, 210, 1);
    [logView addSubview:_passwordTextField];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(_passwordTextField.left, _passwordTextField.bottom+20, _passwordTextField.width/2-10, 30);
    [registerBtn setBackgroundColor:hll_color(253, 185, 61, 1)];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [logView addSubview:registerBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(logView.width/2+10, _passwordTextField.bottom+20, _passwordTextField.width/2-10, 30);
    [loginBtn setBackgroundColor:hll_color(252, 74, 57, 1)];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [logView addSubview:loginBtn];
    
}

#pragma mark - action
- (void)loginClick
{
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    
    if ([username isEqualToString:@""]||[password isEqualToString:@""]) {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"账号密码不能为空"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else {
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        httpClient.parameterEncoding = AFJSONParameterEncoding;
        [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:username forKey:@"username"];
        [params setObject:password forKey:@"password"];
        
        [httpClient postPath:LOGIN_POSTPATH
                  parameters:params
                     success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
             NSError *error = nil;
             NSDictionary *dic=[[NSDictionary alloc]init];
             dic = [jsonParser objectWithString:responseStr error:&error];
             NSLog(@"请求成功---->%@",dic);
             NSLog(@"%@",[dic objectForKey:@"errordesc"]);
             
             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
             [userDefaults setObject:username forKey:@"name"];
             [userDefaults setObject:password forKey:@"password"];
             [userDefaults synchronize];
             
             //...
             
             
         }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"失败");
         }];
    }
}
@end
