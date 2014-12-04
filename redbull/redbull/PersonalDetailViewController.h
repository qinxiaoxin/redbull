//
//  PersonalDetailViewController.h
//  redbull
//
//  Created by Xin Qin on 12/4/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *webURL;

@property (strong, nonatomic) NSString *navigationBarTitle;

@end
