//
//  WebFailView.m
//  redbull
//
//  Created by LC on 14/12/10.
//  Copyright (c) 2014年 Xin Qin. All rights reserved.
//

#import "WebFailView.h"

@implementation WebFailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView
{
    self.backgroundColor = hll_color(243, 243, 243, 1);
    
    _wifiImageView = [[UIImageView alloc] init];
    _wifiImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_wifiImageView];
    
    _cusTitleLabel = [[UILabel alloc] init];
    _cusTitleLabel.font = [UIFont systemFontOfSize:20];
    _cusTitleLabel.textColor = hll_color(63, 63, 63, 1);
    [self addSubview:_cusTitleLabel];
    
    _cusSubTitLabel = [[UILabel alloc] init];
    _cusSubTitLabel.font = [UIFont systemFontOfSize:18];
    _cusSubTitLabel.textColor = hll_color(170, 170, 170, 1);
    [self addSubview:_cusSubTitLabel];
    
    _reClick = [UIButton buttonWithType:UIButtonTypeCustom];
    _reClick.backgroundColor = [UIColor clearColor];
    [_reClick setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_reClick setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    [_reClick addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reClick];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _wifiImageView.frame = CGRectMake(ScreenWidth/2-60, 30, 120, 100);
    _wifiImageView.image = [UIImage imageNamed:@"wifi_pic.png"];
    
    _cusTitleLabel.frame = CGRectMake(_wifiImageView.left, _wifiImageView.bottom+80, _wifiImageView.width, 20);
    _cusTitleLabel.text = @"网络无法连接";
    
    _cusSubTitLabel.frame = CGRectMake(ScreenWidth/2 - 100, _cusTitleLabel.bottom+40, 200, 18);
    _cusSubTitLabel.text = @"请检查你的手机是否联网";
    
    _reClick.frame = CGRectMake(ScreenWidth/2-50, _cusSubTitLabel.bottom+100, 100, 24);
    [_reClick setTitle:@"再试一次" forState:UIControlStateNormal];
    
}

+ (id)reSetWithTarget:(id)target
               action:(SEL)action
{
    WebFailView *failView = [[WebFailView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [failView setTarget:target withAction:action];
    
    return failView;
}

- (void)setTarget:(id)target withAction:(SEL)action
{
    [_reClick addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end

