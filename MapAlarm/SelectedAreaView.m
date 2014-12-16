//
//  SelectedAreaView.m
//  MapAlarm
//
//  Created by Bran on 12/14/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//

#import "SelectedAreaView.h"

@implementation SelectedAreaView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] set];
    CGContextFillEllipseInRect(context, rect);
    
    [[UIColor colorWithRed:242./255. green:0./255. blue:0./255. alpha:0.6] set];
    CGContextFillEllipseInRect(context, rect);
    CGContextStrokePath(context);
    
}
@end
