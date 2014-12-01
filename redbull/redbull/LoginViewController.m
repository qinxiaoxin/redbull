//
//  LoginViewController.m
//  redbull
//
//  Created by LC on 14/12/1.
//  Copyright (c) 2014年 Xin Qin. All rights reserved.
//

#import "LoginViewController.h"

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
    self.view.backgroundColor = hll_color(190, 190, 190, 1);

    UIView *logView = [[UIView alloc] initWithFrame:CGRectMake(5, FSystenVersion>=7.0?64:44, ScreenWidth - 10, 300)];
    logView.backgroundColor = hll_color(240, 240, 240, 1);
    [self.view addSubview:logView];
    
        UIView *redline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, logView.width, 3)];
        redline.backgroundColor = [UIColor redColor];
        [logView addSubview:redline];
    
        UIImageView *titleImage = [[UIImageView alloc] init];
        titleImage.frame = CGRectMake(logView.width/2-30, redline.bottom+5, 15, 15);
        titleImage.backgroundColor = [UIColor clearColor];
        titleImage.image = [UIImage imageNamed:@""];
        [logView addSubview:titleImage];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleImage.right+5, titleImage.top+3, 40, 10)];
        titleLabel.text = @"用户登录";
        titleLabel.textColor = hll_color(222, 46, 43, 1);
        [logView addSubview:titleLabel];
        
        _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, titleLabel.bottom +20, logView.width-40, 30)];
        _usernameTextField.placeholder = @" 登录名";
        _usernameTextField.backgroundColor = hll_color(190, 190, 190, 1);
        [logView addSubview:_usernameTextField];
        
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, _usernameTextField.bottom +15, logView.width-40, 30)];
        _passwordTextField.placeholder = @" ******";
        _passwordTextField.backgroundColor = hll_color(190, 190, 190, 1);
        [logView addSubview:_passwordTextField];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setBackgroundColor:[UIColor yellowColor]];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
}

@end
