//
//  SetSchedule.m
//  MapAlarm
//
//  Created by Bran on 12/16/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//

#import "SetSchedule.h"

@implementation SetSchedule
- (void)awakeFromNib
{
     self.bottomLineColor = [UIColor colorWithWhite:0.816 alpha:1.000];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return self;
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // draw bottom line
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
    CGContextSetLineWidth(context, .5);
    CGContextMoveToPoint(context, 0, rect.size.height - .5);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - .5);
    CGContextStrokePath(context);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
