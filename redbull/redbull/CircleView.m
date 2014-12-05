//
//  CircleView.m
//  redbull
//
//  Created by Xin Qin on 12/5/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return  self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context =  UIGraphicsGetCurrentContext();
    /*画圆*/
    //边框圆
    CGContextSetRGBStrokeColor(context, 47 / 255.f, 47 / 255.f, 49 / 255.f, 1.0);//画笔线的颜色
//    CGContextSetRGBStrokeColor(context, 1.f, 1.f, 1.f, 1.f);
    CGContextSetLineWidth(context, 10.f);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, self.frame.size.width / 2, self.frame.size.height / 2, self.frame.size.width / 2 - 5, 0, 2 * PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
}


@end
