//
//  WebFailView.h
//  redbull
//
//  Created by LC on 14/12/10.
//  Copyright (c) 2014年 Xin Qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebFailView : UIView {
@private
    UIImageView *_wifiImageView;
    UILabel *_cusTitleLabel;/**< 网络无法连接*/
    UILabel *_cusSubTitLabel;/**< 请检查你的手机是否联网*/
//    UIButton *_reClick;
}


@property (nonatomic ,strong)UIWebView *webView;

@property (nonatomic, strong) UIButton *reClick;

+ (id)reSetWithTarget:(id)target
               action:(SEL)action;

@end
