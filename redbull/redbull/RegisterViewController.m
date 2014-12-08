//
//  RegisterViewController.m
//  redbull
//
//  Created by Xin Qin on 12/6/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"

#import "AFNetworking.h"
#import "SBJson.h"

@interface RegisterViewController ()

//@property (nonatomic ,strong) UIImageView *register_mail;
//@property (nonatomic ,strong) UIImageView *register_phone;
//@property (nonatomic ,strong) UIImageView *register_validation;
//@property (nonatomic ,strong) UIImageView *register_password;
//@property (nonatomic ,strong) UIImageView *register_password2;

@property (weak, nonatomic) IBOutlet UITextField *mailTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *vdalidationTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *password2TextFiled;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    _register_mail = [[UIImageView alloc] initWithFrame:CGRectMake(_mailTextFiled.frame.size.width, _mailTextFiled.frame.origin.y + 10, 20, 20)];
//    _register_mail.image = [UIImage imageNamed:@"register_mail"];
//    [self.view addSubview:_register_mail];
    _registerButton.backgroundColor = hll_color(253, 185, 61, 1);
    _loginButton.backgroundColor = hll_color(252, 74, 57, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//回到登录
- (IBAction)loginAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//立即注册
- (IBAction)registerAction:(id)sender
{
    NSString *mail = _mailTextFiled.text;
    NSString *phone = _phoneTextFiled.text;
    NSString *validation = _vdalidationTextField.text;
    NSString *password = _passwordTextFiled.text;
    NSString *password2 = _password2TextFiled.text;

    /**********正则判断*************/
//    if ([mail isEqualToString:@""]||[phone isEqualToString:@""] || [validation isEqualToString:@""] || password || password2) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"注册信息不能为空"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }else {
//        [self post];
//    }
    
    if ([mail isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"邮箱不能为空"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if (![mail isEqualToString:REGEX_EMAIL]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"邮箱格式不正确"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if ([phone isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"电话号不能为空"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if (![phone isEqualToString:REGEX_PHONE]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"电话号格式不正确"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if ([validation isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"验证码不能为空"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if (![validation isEqualToString:@""]){//正确的验证码
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"手机验证码错误"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if ([password isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"密码不能为空"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if (![password isEqualToString:REGEX_PASSWORD]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"密码应为6~20位"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if (![password2 isEqualToString:password]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"两次密码不一致"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        [self registerPost];
    }
}

- (void)registerPost
{
    NSString *mail = _mailTextFiled.text;
    NSString *phone = _phoneTextFiled.text;
    NSString *validation = _vdalidationTextField.text;
    NSString *password = _passwordTextFiled.text;
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:mail forKey:@"email"];
    [params setObject:phone forKey:@"mobile"];
    [params setObject:validation forKey:@"vcode"];
    [params setObject:password forKey:@"password"];
    
    [httpClient getPath:REGISTER_POSTPATH
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
         
         int registerCode = 0;
         NSDictionary  *resultDataString = [dic objectForKey:@"data"];
         if(resultDataString != NULL  &&  ![@""  isEqualToString:resultDataString]){
             NSString *codeStr = [[resultDataString objectForKey:@"status"]  stringValue];
             if([@"1" isEqualToString:codeStr]){
                 registerCode = 1;
             }
         }
         
         if (registerCode == 1) {
             NSLog(@"注册成功---->%@",[dic objectForKey:@"status"]);
             
//             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//             [userDefaults setObject:username forKey:@"name"];
//             [userDefaults setObject:password forKey:@"password"];
//             [userDefaults synchronize];
             
//             isLogin = 1;
//             [_mTabBarController setNavigationImageWithUrl:@"http://b.hiphotos.baidu.com/image/pic/item/d1160924ab18972ba5cd58cbe4cd7b899e510a3f.jpg"];
//             [self dismissViewControllerAnimated:YES completion:nil];
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"注册成功"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alert show];
         }else {
             NSLog(@"注册失败---->%@",[dic objectForKey:@"status"]);
             
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

//向手机发送验证码
- (IBAction)sendValidation:(id)sender
{
    NSString *mobile = _phoneTextFiled.text;
    
    if ([mobile isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"电话号不能为空"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else if ([mobile isEqualToString:REGEX_PHONE]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示"message:@"电话号格式不正确"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        [self sendValidationCodePost];
    }
}

- (void)sendValidationCodePost
{
    NSString *mobile = _phoneTextFiled.text;
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:mobile forKey:@"mobile"];
    
    
    [httpClient getPath:VALIDATION_POSTPATH
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
         
         int sendCode = 0;
         NSDictionary  *resultDataString = [dic objectForKey:@"data"];
         if(resultDataString != NULL  &&  ![@""  isEqualToString:resultDataString]){
             NSString *codeStr = [[resultDataString objectForKey:@"status"]  stringValue];
             if([@"1" isEqualToString:codeStr]){
                 sendCode = 1;
             }
         }
         
         if (sendCode == 1) {
             NSLog(@"发送验证码成功---->%@",[dic objectForKey:@"status"]);
             
             //             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
             //             [userDefaults setObject:username forKey:@"name"];
             //             [userDefaults setObject:password forKey:@"password"];
             //             [userDefaults synchronize];
             UIAlertView*alert = [[UIAlertView alloc]initWithTitle:nil message:@"发送成功" delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil];
             [alert show];
             
             sendCode = 1;
         }else {
             NSLog(@"发送验证码失败---->%@",[dic objectForKey:@"status"]);
             
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
