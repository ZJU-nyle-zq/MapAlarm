//
//  ViewController.m
//  MapAlarm
//
//  Created by 邓永辉 on 14/12/10.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#import "ViewController.h"
#define STATUS_SCHEDULE 0
#define STATUS_BUS_ALARM 1

@interface ViewController ()

@end

@implementation ViewController

@synthesize celsiusLable, locationLable, buttonLeft, buttonRight, busAlarmCliockHolder, mySheduleHolder ,images, status, scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    status = STATUS_SCHEDULE;
    
    celsiusLable.font = [UIFont fontWithName:@"Avenir-LightOblique" size:21];
    locationLable.font = [UIFont fontWithName:@"Baskerville-Italic" size:16];
    
    mySheduleHolder.hidden = false;
    busAlarmCliockHolder.hidden = true;
    
    buttonLeft.userInteractionEnabled = true;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeftButton:)];
    [buttonLeft addGestureRecognizer:singleTap];
    
    buttonRight.userInteractionEnabled = true;
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightButton:)];
    [buttonRight addGestureRecognizer:singleTap2];
    
    scrollView.contentSize = CGSizeMake(320, 300);
    
    UIImage * image1 = [UIImage imageNamed:@"shedule_button_pressed.png"];
    UIImage * image2 = [UIImage imageNamed:@"bus_alarm_button_normal.png"];
    images = [[NSArray alloc] initWithObjects:image1, image2, nil];
}

- (void)clickLeftButton:(UIGestureRecognizer *)gestureRecognizer
{
    if (status == STATUS_BUS_ALARM) {
        status = STATUS_SCHEDULE;
        [buttonLeft setImage:[UIImage imageNamed:@"shedule_button_pressed.png"]];
        [buttonRight setImage:[UIImage imageNamed:@"bus_alarm_button_normal.png"]];
        mySheduleHolder.hidden = false;
        busAlarmCliockHolder.hidden = true;
    }
}

- (void)clickRightButton:(UIGestureRecognizer *)gestureRecognizer
{
    if (status == STATUS_SCHEDULE) {
        status = STATUS_BUS_ALARM;
        [buttonLeft setImage:[UIImage imageNamed:@"shedule_button_normal.png"]];
        [buttonRight setImage:[UIImage imageNamed:@"bus_alarm_button_pressed.png"]];
        mySheduleHolder.hidden = true;
        busAlarmCliockHolder.hidden = false;
    }
}

-(UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                            green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
