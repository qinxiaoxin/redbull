//
//  VITabBarController.m
//  Vinoli
//
//  Created by Nicolas Goles on 5/16/14.
//  Copyright (c) 2014 Goles. All rights reserved.
//

#import "GGTabBarController.h"
#import "GGTabBar.h"
#import "AFNetworking.h"

#import "FirstViewController.h"
#import "AskAnswerViewController.h"
#import "ExchangeViewController.h"
#import "TurnTableViewController.h"

#import "Navbar.h"

#import "LoginViewController.h"

#import "DDMenuController.h"
#import "BounceSheet.h"

@interface GGTabBarController () <GGTabBarDelegate ,BounceSheetDelegate>{
    BounceSheet *bounceSheet1;
    BounceSheet *bounceSheet2;
}
@property (nonatomic, strong) UIView *presentationView;
@property (nonatomic, strong) GGTabBar *tabBarView;
@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic,retain) NSString *documentsDirectory;

@property (nonatomic, strong) NSArray *jsonArrayAsk;
@property (nonatomic, strong) NSArray *jsonArrayTurn;

@end

@implementation GGTabBarController

//unlogin = 0
int isLogin = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = [[UIScreen mainScreen] bounds];
    
    /**获取Document 文件夹地址*/
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory =[paths objectAtIndex:0];

    _tabBarView = [[GGTabBar alloc] initWithFrame:CGRectZero viewControllers:_viewControllers appearance:_tabBarAppearanceSettings];
    _tabBarView.delegate = self;
 
    _presentationView = [[UIView alloc] init];
    _presentationView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_tabBarView];
    [self.view addSubview:_presentationView];
    
    //Fetch json data
    [self requestJsonTabData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self layoutTabBarView];
    [_tabBarView needsUpdateConstraints];

    if (_debug) {
        [self startDebugMode];
        [_tabBarView startDebugMode];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    NSParameterAssert(_viewControllers.count > 0);

    // Select first view controller on first Launch.
    if (!_isFirstAppear) {
        _isFirstAppear = YES;
        [self selectViewController:[_viewControllers firstObject]];
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if (name == nil) {
        isLogin = 0;
    }else{
        isLogin = 1;
    }
}

/**
 *  Fetch tab json data
 */
- (void)requestJsonTabData
{
    //创建一个线程获取Tab json数据
    dispatch_queue_t fetchQ = dispatch_queue_create("json fetch", NULL);
    dispatch_async(fetchQ, ^{
        NSURL *url = [NSURL URLWithString:JSON_TAB];
        NSMutableURLRequest *mrequest = [NSMutableURLRequest requestWithURL:url];
        mrequest.timeoutInterval = 15.f;
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:mrequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            NSDictionary *jsonDictionary = (NSDictionary *)JSON;
            self.jsonArrayAsk = [jsonDictionary objectForKey:@"pageConfig1"];
            NSLog(@"self.jsonArray = %@",self.jsonArrayAsk);
            self.jsonArrayTurn = [jsonDictionary objectForKey:@"pageConfig2"];
            NSLog(@"self.jsonArrayTurn = %@",self.jsonArrayTurn);
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"json error = %@",error);
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"message:@"网络错误"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            
        }];
        
        [operation start];
    });
}


#pragma mark - Delegation

- (void)tabBar:(GGTabBar *)tabBar didPressButton:(UIButton *)button atIndex:(NSUInteger)tabIndex
{
    if (tabIndex == 1) {
        bounceSheet1 = [[BounceSheet alloc] initWithDelegate:self X:ScreenWidth/4];
        
        __block GGTabBarController *ggVC = self;
        
        for(int i = 0;i < self.jsonArrayAsk.count;i++){
            NSDictionary *dic = [self.jsonArrayAsk objectAtIndex:i];
            NSString *string = [dic objectForKeyedSubscript:@"title"];
            NSString *url = [dic objectForKeyedSubscript:@"url"];
            NSLog(@"ask tab string = %@",string);
            NSLog(@"ask tab string = %@",url);
            [bounceSheet1 addButtonWithTitle:string actionBlock:^{
                [ggVC jumpToTabAtIndexNum:tabIndex withStrUrl:url];
                
            }];
        }
        
        [bounceSheet1 show];
        
    }else if (tabIndex == 3) {
        bounceSheet2 = [[BounceSheet alloc] initWithDelegate:self X:3*ScreenWidth/4];
        
        __block GGTabBarController *ggVC = self;
        
        for(int i = 0;i < self.jsonArrayTurn.count;i++){
            NSDictionary *dic = [self.jsonArrayTurn objectAtIndex:i];
            NSString *string = [dic objectForKeyedSubscript:@"title"];
            NSString *url = [dic objectForKey:@"url"];
            NSLog(@"turn tab title = %@",string);
            NSLog(@"turn tab url = %@",url);
            [bounceSheet2 addButtonWithTitle:string actionBlock:^{
                [ggVC jumpToTabAtIndexNum:tabIndex withStrUrl:url];
            }];
        }
        
        [bounceSheet2 show];
        
    }else {
        UIViewController *selectedViewController = _viewControllers[tabIndex];
        
        if ([_delegate respondsToSelector:@selector(ggTabBarController:shouldSelectViewController:)]) {
            if ([_delegate ggTabBarController:self shouldSelectViewController:selectedViewController]) {
                [self selectViewController:selectedViewController withButton:button];
            }
        }
        [self selectViewController:selectedViewController withButton:button];
    }
}

/**跳转到指定Tab*/
-(void)jumpToTabAtIndexNum:(NSInteger)tabIndex withStrUrl:(NSString*)url{
    UIViewController *selectedViewController = _viewControllers[tabIndex];
    if(url != nil){
        [selectedViewController setValue:url forKey:@"bingStrUrl"];
    }
    if ([_delegate respondsToSelector:@selector(ggTabBarController:shouldSelectViewController:)]) {
        if ([_delegate ggTabBarController:self shouldSelectViewController:selectedViewController]) {
            [self selectViewController:selectedViewController withButton:[_tabBarView  getButtonAtIndex:tabIndex]];
        }
    }
    
    [self selectViewController:selectedViewController withButton:[_tabBarView  getButtonAtIndex:tabIndex]];
}

#pragma mark - BounceSheet Delegate
- (void)actionSheetCancel:(BounceSheet *)actionSheet
{
    if (bounceSheet1) {
        [bounceSheet1 removeFromSuperview];
        bounceSheet1 = nil;
    }else if(bounceSheet2) {
        [bounceSheet2 removeFromSuperview];
        bounceSheet2 = nil;
    }

}

- (void)actionSheet:(BounceSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (bounceSheet1) {
        [bounceSheet1 removeFromSuperview];
        bounceSheet1 = nil;
    }else if(bounceSheet2) {
        [bounceSheet2 removeFromSuperview];
        bounceSheet2 = nil;
    }

}

# pragma mark - View Controller Selection

- (void)selectViewController:(UIViewController *)viewController withButton:(UIButton *)button
{
    [_tabBarView setSelectedButton:button];
    [self selectViewController:viewController];

}

- (void)selectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[FirstViewController class]]) {
        [self.navigationItem setNewTitle:@"红牛能量部落"];
        /**有用户头像文件则显示头像*/
        if([self checkIsHaveUserPic]){
             [self.navigationItem setLeftItemWithTarget:self action:@selector(loginClick:) image:[UIImage imageWithContentsOfFile:[_documentsDirectory stringByAppendingPathComponent:@"UserHeadPic.png"]]];
        }else{
             [self.navigationItem setLeftItemWithTarget:self action:@selector(loginClick:) image:@"face"];
        }
        [self.navigationItem setRightItemWithTarget:self action:@selector(shareClick:) image:@"share"];
        self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:25 / 255.f green:29 / 255.f blue:30 / 255.f alpha:1.f];
    }else if ([viewController isKindOfClass:[AskAnswerViewController class]]){
        self.navigationItem.leftBarButtonItem = nil;
        [self.navigationItem setNewTitle:@"有问有答"];
        [self.navigationItem setRightItemWithTarget:self action:@selector(shareClick:)  image:@"share_white"];
        self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
        
    }else if ([viewController isKindOfClass:[ExchangeViewController class]]){
        self.navigationItem.leftBarButtonItem = nil;
        [self.navigationItem setNewTitle:@"能量值兑换"];
        [self.navigationItem setRightItemWithTarget:self action:@selector(shareClick:)  image:@"share"];
        self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:25 / 255.f green:29 / 255.f blue:30 / 255.f alpha:1.f];
    }else if ([viewController isKindOfClass:[TurnTableViewController class]]){
        [self.navigationItem setNewTitle:@"红牛能量部落"];
        /**有用户头像文件则显示头像*/
        if([self checkIsHaveUserPic]){
            [self.navigationItem setLeftItemWithTarget:self action:@selector(loginClick:) image:[UIImage imageWithContentsOfFile:[_documentsDirectory stringByAppendingPathComponent:@"UserHeadPic.png"]]];
        }else{
            [self.navigationItem setLeftItemWithTarget:self action:@selector(loginClick:) image:@"face"];
        }
        [self.navigationItem setRightItemWithTarget:self action:@selector(shareClick:)  image:@"share"];
        self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:25 / 255.f green:29 / 255.f blue:30 / 255.f alpha:1.f];
    }
    
    UIView *presentedView = [_presentationView.subviews firstObject];
    
    if (presentedView) {
        [presentedView removeFromSuperview];
    }
    
    viewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_presentationView addSubview:viewController.view];
    [self fitView:viewController.view intoView:_presentationView];
}

/**设置头像图片*/
-(void)setNavigationImageWithUrl:(NSString*)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse*response, UIImage *image) {
        [self.navigationItem setLeftItemWithTarget:self action:@selector(loginClick:) image:image];
        [self writeUserHeadPicToDocuments:image];
       
        DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
        [menuController setLeftViewPortraitImage:image];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Error %@",error);
        [self.navigationItem setLeftItemWithTarget:self action:@selector(loginClick:) image:@"face"];
    }];
    
    [operation start];
}

/**将用户头像写入本地*/
-(void)writeUserHeadPicToDocuments:(UIImage*)image{
    
    /**获取Document 文件夹地址*/
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath =[paths objectAtIndex:0];
//    [UIImagePNGRepresentation(image) writeToFile:[[NSString alloc] initWithFormat:@"%@%@",documentPath,@"UserHeadPic.png"] atomically:YES];
    NSURL *sandBoxURL = [NSURL fileURLWithPath:[documentPath stringByAppendingPathComponent:@"UserHeadPic.png"]];
    [UIImagePNGRepresentation(image) writeToFile:[sandBoxURL path] atomically:YES];
}


#pragma mark - Action

- (void)loginClick:(id)sender
{
    //是否已经登陆

    if (isLogin) {
        DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
        [menuController showLeftController:YES];
    }else{
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [loginViewController setValue:self forKey:@"mTabBarController"];
        loginViewController.modalPresentationStyle =UIModalPresentationOverCurrentContext;
        [self presentViewController:loginViewController animated:YES completion:^{
            
        }];
    }
}

- (void)shareClick:(id)sender
{
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).menuControler;
    [menuController showRightController:YES];
}


#pragma mark - Layout

- (void)layoutTabBarView
{
    NSDictionary *viewsDictionary = @{@"tabbar_view" : _tabBarView,@"presentation_view" : _presentationView};

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[presentation_view]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[presentation_view][tabbar_view]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tabbar_view]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];

}

- (void)fitView:(UIView *)toPresentView intoView:(UIView *)containerView
{
    NSDictionary *viewsDictioanry = @{@"presented_view" : toPresentView};

    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[presented_view]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictioanry]];

    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[presented_view]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewsDictioanry]];
}

/**判断是否有用户头像图片*/
-(BOOL)checkIsHaveUserPic{
    NSFileManager *fileManager =   [[NSFileManager alloc] init];
    return [fileManager fileExistsAtPath:[[NSString alloc]  initWithFormat:@"%@%@",_documentsDirectory,@"UserHeadPic.png"]];
}


#pragma mark - Debug

- (void)startDebugMode
{
    _presentationView.backgroundColor = [UIColor yellowColor];
}

@end

