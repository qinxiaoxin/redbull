//
//  LoginViewController.h
//  redbull
//
//  Created by LC on 14/12/1.
//  Copyright (c) 2014年 Xin Qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
#import "GGTabBarController.h"

@interface LoginViewController : UIViewController <UIKeyboardViewControllerDelegate> {
    UIKeyboardViewController *_keyBoardController;
    UITextField *_usernameTextField;
    UITextField *_passwordTextField;
    GGTabBarController *_mTabBarController;

}
@property (retain,nonatomic) GGTabBarController *mTabBarController;
@end
