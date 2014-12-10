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

#import "RegisterViewController.h"

@interface LoginViewController ()
@end

@implementation LoginViewController
@synthesize mTabBarController  = _mTabBarController;
extern int isLogin;

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
    self.view.backgroundColor = hll_color(1, 1, 1, 0.7);
    UIView *logView = [[UIView alloc] initWithFrame:CGRectMake(15, FSystenVersion>=7.0?64:44, ScreenWidth - 30, 230)];
    logView.backgroundColor = hll_color(240, 240, 240, 1);
    [self.view addSubview:logView];
    
    UIView *redline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, logView.width, 3)];
    redline.backgroundColor = hll_color(252, 74, 57, 1);
    [logView addSubview:redline];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(redline.right - 17, redline.top + 33, 60, 60);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    UIImageView *titleImage = [[UIImageView alloc] init];
    titleImage.frame = CGRectMake(logView.width/2-50, redline.bottom+5, 15, 15);
    titleImage.backgroundColor = [UIColor clearColor];
    titleImage.image = [UIImage imageNamed:@""];
    [logView addSubview:titleImage];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(redline.width / 2 - 35, redline.top + 15, 90, 10)];
    titleLabel.text = @"用户登录";
    titleLabel.textColor = hll_color(210, 40, 39, 1);
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [logView addSubview:titleLabel];
    
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, titleLabel.bottom +20, logView.width-40, 30)];
    _usernameTextField.placeholder = @" 登录名";
    _usernameTextField.font = [UIFont systemFontOfSize:12.0f];
    _usernameTextField.backgroundColor = hll_color(210, 210, 210, 1);
    UILabel * leftView1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView1.backgroundColor = [UIColor clearColor];
    _usernameTextField.leftView = leftView1;
    _usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    _usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [logView addSubview:_usernameTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, _usernameTextField.bottom +15, logView.width-40, 30)];
    _passwordTextField.placeholder = @" 密码";
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.font = [UIFont systemFontOfSize:12.0f];
    _passwordTextField.backgroundColor = hll_color(210, 210, 210, 1);
    UILabel * leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView2.backgroundColor = [UIColor clearColor];
    _passwordTextField.leftView = leftView2;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [logView addSubview:_passwordTextField];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(_passwordTextField.left, _passwordTextField.bottom+20, _passwordTextField.width/2-10, 30);
    [registerBtn setBackgroundColor:hll_color(253, 185, 61, 1)];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [logView addSubview:registerBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(logView.width/2+10, _passwordTextField.bottom+20, _passwordTextField.width/2-10, 30);
    [loginBtn setBackgroundColor:hll_color(252, 74, 57, 1)];
    [loginBtn setTitle:@"登 陆" forState:UIControlStateNormal];
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
        [self post];
    }
}

- (void)registerClick:(id)sender
{
    RegisterViewController *rvc = [[RegisterViewController alloc] init];
    [self presentViewController:rvc animated:YES completion:^{
        
    }];
}

- (void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:username forKey:@"username"];
    [params setObject:password forKey:@"password"];
    
  
    [httpClient getPath:LOGIN_POSTPATH
              parameters:params
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
         
         int loginCode = 0;
         NSDictionary  *resultDataString = [dic objectForKey:@"data"];
         if(resultDataString != NULL  &&  ![@""  isEqualToString:resultDataString]){
             NSString *codeStr = [[resultDataString objectForKey:@"status"]  stringValue];
             if([@"1" isEqualToString:codeStr]){
                 loginCode = 1;
             }
         }
         
         if (loginCode == 1) {
             NSLog(@"登陆成功---->%@",[dic objectForKey:@"status"]);

             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
             [userDefaults setObject:username forKey:@"name"];
             [userDefaults setObject:password forKey:@"password"];
             [userDefaults synchronize];
             
             isLogin = 1;
             if(nil != [resultDataString objectForKey:@"largeUrl"]){
                 [_mTabBarController setNavigationImageWithUrl:[resultDataString objectForKey:@"largeUrl"]];
             }
             
             [self dismissViewControllerAnimated:YES completion:nil];
         }else {
             NSLog(@"登陆失败---->%@",[dic objectForKey:@"status"]);

             UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"message:[dic objectForKey:@"errordesc"] delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil];
             [alert show];

         }
     }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"message:@"网络错误"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
         [alert show];
     }];
}


@end
