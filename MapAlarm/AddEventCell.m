//
//  AddEventCell.m
//  MapAlarm
//
//  Created by Bran on 12/15/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//

#import "AddEventCell.h"

@implementation AddEventCell

@synthesize timeLable;
@synthesize eventLable;
@synthesize locationLable;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted == YES)
    {
        //        NSLog(@"这个地方是按下时会调到得地方");
        //        self.textLabel.textColor = Selected_Frame_Color;
        [self.textLabel setHighlighted:YES];
        [self.imageView setHighlighted:YES];
    }else{
        //        NSLog(@"这个地方是抬起手指时会调到得地方");
        //        self.textLabel.textColor = [UIColor whiteColor];
        [self.textLabel setHighlighted:NO];
        [self.imageView setHighlighted:NO];
    }
}


@end
