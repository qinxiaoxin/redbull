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
#import "PersonalDetailViewController.h"

@interface LoginViewController ()
@end

@implementation LoginViewController
@synthesize mTabBarController  = _mTabBarController;
extern int isLogin;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"Login viewWillAppear");
    if(isLogin == 1){
        [self ProfileGet];
        [self dismissLogin];
    }
    
    _keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [_keyBoardController addToolbarToKeyboard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissLogin) name:@"CLOSE_LOGIN" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UI
- (void)_initView {
    self.view.backgroundColor = hll_color(1, 1, 1, 0.7);
    UIView *logView = [[UIView alloc] initWithFrame:CGRectMake(15, FSystenVersion>=7.0?64:44, ScreenWidth - 30, 300)];
    logView.backgroundColor = hll_color(240, 240, 240, 1);
    [self.view addSubview:logView];
    
    UIView *redline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, logView.width, 3)];
    redline.backgroundColor = hll_color(252, 74, 57, 1);
    [logView addSubview:redline];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(redline.right -8, redline.top + 43, 40, 40);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, redline.top + 15, 90, 10)];
    titleLabel.text = @"用户登录";
    titleLabel.font = [UIFont systemFontOfSize:15.f];
    titleLabel.textColor = hll_color(210, 40, 39, 1);
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [logView addSubview:titleLabel];
    
    UIButton *forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPasswordBtn.frame = CGRectMake(logView.width-80, redline.top +15, 60, 15);
    forgetPasswordBtn.backgroundColor = hll_color(63, 63, 63, 1);
    forgetPasswordBtn.layer.cornerRadius = 8.f;
    forgetPasswordBtn.clipsToBounds = YES;
    forgetPasswordBtn.titleLabel.font = [UIFont boldSystemFontOfSize:10.f];
    [forgetPasswordBtn setTitle:@" 找回密码" forState:UIControlStateNormal];
    [forgetPasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetPasswordBtn setTitleColor:hll_color(255, 255, 255, 0.5) forState:UIControlStateHighlighted];
    [forgetPasswordBtn addTarget:self action:@selector(forgerClick) forControlEvents:UIControlEventTouchUpInside];
    [logView addSubview:forgetPasswordBtn];
    
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
    registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    [registerBtn setTitleColor:hll_color(255, 255, 255, 0.3) forState:UIControlStateHighlighted];
    [registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [logView addSubview:registerBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(logView.width/2+10, _passwordTextField.bottom+20, _passwordTextField.width/2-10, 30);
    [loginBtn setBackgroundColor:hll_color(252, 74, 57, 1)];
    [loginBtn setTitle:@"登 陆" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    [loginBtn setTitleColor:hll_color(255, 255, 255, 0.3) forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [logView addSubview:loginBtn];
    
    UILabel *otherTitle = [[UILabel alloc] initWithFrame:CGRectMake(logView.width / 2 - 65, loginBtn.bottom + 20, 140, 10)];
    otherTitle.text = @"使用其它账号登陆";
    otherTitle.textColor = hll_color(210, 40, 39, 1);
    otherTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [logView addSubview:otherTitle];
    
    UIButton *qqButton = [[UIButton alloc] initWithFrame:CGRectMake(registerBtn.center.x - 25, registerBtn.bottom + 50, 50, 50)];
    qqButton.backgroundColor = [UIColor clearColor];
    [qqButton setImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];
    [qqButton addTarget:self action:@selector(loginQQ:) forControlEvents:UIControlEventTouchUpInside];
    [logView addSubview:qqButton];
    
    UIButton *weiboButton = [[UIButton alloc] initWithFrame:CGRectMake(loginBtn.center.x - 25, loginBtn.bottom + 50, 50, 50)];
    weiboButton.backgroundColor = [UIColor clearColor];
    [weiboButton setImage:[UIImage imageNamed:@"login_weibo"] forState:UIControlStateNormal];
    [weiboButton addTarget:self action:@selector(loginWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [logView addSubview:weiboButton];
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

- (void)forgerClick
{
    PersonalDetailViewController *pdvc = [[PersonalDetailViewController alloc] init];
    pdvc.webURL = FORGETPASSWORD_URL;
    pdvc.navigationBarTitle = FORGET_NAV;
    [self presentViewController:pdvc animated:YES completion:nil];
}

-(void) dismissLogin{
    [self performSelectorOnMainThread:@selector(cancelBtnClick)withObject:nil waitUntilDone:YES];
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

- (void)loginQQ:(id)sender
{
    NSLog(@"login QQ");
    
    PersonalDetailViewController *pdvc = [[PersonalDetailViewController alloc] init];
    pdvc.webURL = LOGIN_QQ;
    pdvc.navigationBarTitle = QQLOGIN_NAV;

    [self presentViewController:pdvc animated:YES completion:nil];

}

- (void)loginWeibo:(id)sender
{
    NSLog(@"login weibo");
    
    PersonalDetailViewController *pdvc = [[PersonalDetailViewController alloc] init];
    pdvc.webURL = LOGIN_WEIBO;
    pdvc.navigationBarTitle = WEIBOLOGIN_NAV;
    
    [self presentViewController:pdvc animated:YES completion:nil];

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
        NSRange start =  [responseStr rangeOfString:@"<td class=\"td2\"><img src=\""];
         if(start.location>0){
             NSString *headPicUrl = [responseStr substringFromIndex:start.location+start.length];
             NSRange end = [headPicUrl rangeOfString:@"\""];
             headPicUrl =[headPicUrl substringToIndex:end.location] ;
             [_mTabBarController setNavigationImageWithUrl:headPicUrl];
             NSLog(@"headPicUrl :%@",headPicUrl);
         }
         
     }
                failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"message:@"网络错误"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
         [alert show];
     }];
}


@end
