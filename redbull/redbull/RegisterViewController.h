//
//  RegisterViewController.h
//  redbull
//
//  Created by Xin Qin on 12/6/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"

@interface RegisterViewController : UIViewController{
    UIKeyboardViewController *_keyBoardController;
    NSThread* timerThread;
}

@property (weak, nonatomic) IBOutlet UIButton *sendValidationButton;
@property (nonatomic,retain) NSThread* timerThread;

@end
