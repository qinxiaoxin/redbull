//
//  LeftViewController.m
//  redbull
//
//  Created by Xin Qin on 12/2/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "LeftViewController.h"

#import "PersonalDetailViewController.h"

#import "DDMenuController.h"

#import "Navbar.h"

#import "CircleView.h"

@interface LeftViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set view color
    self.view.backgroundColor = [UIColor colorWithRed:33 / 255.f green:33 / 255.f blue:35 / 255.f alpha:1.f];
    
    //portrait 圆角
    _portraitImageView.layer.cornerRadius = 40.f;
    _portraitImageView.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action & Target

- (IBAction)editData:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    PersonalDetailViewController *pdvc = [[PersonalDetailViewController alloc] init];
    pdvc.webURL = PROFILE_URL;
    pdvc.navigationBarTitle = PROFILE_NAV;
//    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[Navbar class] toolbarClass:nil];
//    navController.viewControllers = @[pdvc];
//    [menuController setRootController:navController animated:YES];
    [menuController presentViewController:pdvc animated:YES completion:^{
        
    }];
}
- (IBAction)modifyCode:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    PersonalDetailViewController *pdvc = [[PersonalDetailViewController alloc] init];
    pdvc.webURL = PASSWORD_URL;
    pdvc.navigationBarTitle = PASSWORD_NAV;
//    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[Navbar class] toolbarClass:nil];
//    navController.viewControllers = @[pdvc];
//    [menuController setRootController:navController animated:YES];
    [menuController presentViewController:pdvc animated:YES completion:^{
        
    }];
}
- (IBAction)receiveAddressManage:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    PersonalDetailViewController *pdvc = [[PersonalDetailViewController alloc] init];
    pdvc.webURL = ADDRESS_URL;
    pdvc.navigationBarTitle = ADDRESS_NAV;
//    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[Navbar class] toolbarClass:nil];
//    navController.viewControllers = @[pdvc];
//    [menuController setRootController:navController animated:YES];
    [menuController presentViewController:pdvc animated:YES completion:^{
        
    }];
}
- (IBAction)myPower:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    PersonalDetailViewController *pdvc = [[PersonalDetailViewController alloc] init];
    pdvc.webURL = SCORE_URL;
    pdvc.navigationBarTitle = SCORE_NAV;
//    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[Navbar class] toolbarClass:nil];
//    navController.viewControllers = @[pdvc];
//    [menuController setRootController:navController animated:YES];
    [menuController presentViewController:pdvc animated:YES completion:^{
        
    }];
}
- (IBAction)exchangeGift:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    PersonalDetailViewController *pdvc = [[PersonalDetailViewController alloc] init];
    pdvc.webURL = PRESENT_URL;
    pdvc.navigationBarTitle = PRESENT_NAV;
//    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[Navbar class] toolbarClass:nil];
//    navController.viewControllers = @[pdvc];
//    [menuController setRootController:navController animated:YES];
    [menuController presentViewController:pdvc animated:YES completion:^{
        
    }];
}
- (IBAction)signOut:(id)sender
{
    NSLog(@"退出登录");
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
