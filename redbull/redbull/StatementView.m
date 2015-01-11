//
//  StatementView.m
//  redbull
//
//  Created by Xin Qin on 1/11/15.
//  Copyright (c) 2015 Xin Qin. All rights reserved.
//

#import "StatementView.h"

@implementation StatementView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:33 / 255.f green:33 / 255.f blue:35 / 255.f alpha:1.f];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 30)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:20.f];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = STATEMENT_TITLE;
        
        UILabel *desLable = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLabel.bottom + 30, self.frame.size.width - 20, 100)];
        desLable.textAlignment = NSTextAlignmentLeft;
        desLable.font = [UIFont systemFontOfSize:15.f];
        desLable.textColor = [UIColor whiteColor];
        desLable.numberOfLines = 5.f;
        desLable.text = STATEMENT_DES;
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(50, desLable.bottom + 60, self.frame.size.width - 100, 50)];
        closeButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [closeButton setTitle:@"知道了" forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [closeButton setBackgroundColor:[UIColor redColor]];
        [closeButton addTarget:self action:@selector(closeStatementView:) forControlEvents:UIControlEventTouchUpInside];
        closeButton.layer.masksToBounds = YES;
        closeButton.layer.cornerRadius = 5.f;
        
        [self addSubview:titleLabel];
        [self addSubview:desLable];
        [self addSubview:closeButton];
    }
    
    return self;
}

- (void)closeStatementView:(id)sender
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
