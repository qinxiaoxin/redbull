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

@property (nonatomic,retain) NSString *documentsDirectory;
@property (nonatomic,retain) NSString *userHeadPicPath;

@end

@implementation LeftViewController

@synthesize portraitImageView;
extern int isLogin;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set view color
    self.view.backgroundColor = [UIColor colorWithRed:33 / 255.f green:33 / 255.f blue:35 / 255.f alpha:1.f];
    
    //portrait 圆角
    portraitImageView.layer.cornerRadius = 40.f;
    portraitImageView.layer.masksToBounds = YES;
    
    /**获取Document 文件夹地址*/
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory =[paths objectAtIndex:0];
    
    /**有用户头像文件则显示头像*/
    if([self checkIsHaveUserPic]){
        NSLog(@"有头像");
        [portraitImageView setImage: [UIImage imageWithContentsOfFile:[_documentsDirectory stringByAppendingPathComponent:@"UserHeadPic.png"]]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**判断是否有用户头像图片*/
-(BOOL)checkIsHaveUserPic{
    NSFileManager *fileManager =   [[NSFileManager alloc] init];
//   _userHeadPicPath  = [[NSString alloc]  initWithFormat:@"%@%@",_documentsDirectory,@"UserHeadPic.png"];
    NSURL *sandBoxURL = [NSURL fileURLWithPath:[_documentsDirectory stringByAppendingPathComponent:@"UserHeadPic.png"]];
    return [fileManager fileExistsAtPath:sandBoxURL.path];
}

/**设置头像*/
-(void)setPortraitImage:(UIImage*)image{
    [portraitImageView setImage:image];
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

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"name"];
    [userDefaults removeObjectForKey:@"password"];
    [userDefaults synchronize];
    
    //清除用户头像图片
    if([self checkIsHaveUserPic]){
        NSFileManager *fileManager =  [[NSFileManager alloc] init];
        [fileManager removeItemAtPath: _userHeadPicPath error:nil];
    }
    
    isLogin = 0;
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    [menuController showRootController:YES];
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
