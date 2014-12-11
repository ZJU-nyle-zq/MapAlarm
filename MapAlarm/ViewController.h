//
//  ViewController.h
//  MapAlarm
//
//  Created by 邓永辉 on 14/12/10.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *celsiusLable;
@property (strong, nonatomic) IBOutlet UILabel *locationLable;
@property (strong, nonatomic) IBOutlet UIImageView *buttonLeft;
@property (strong, nonatomic) IBOutlet UIImageView *buttonRight;
@property (strong, nonatomic) IBOutlet UIView *mySheduleHolder;
@property (strong, nonatomic) IBOutlet UIView *busAlarmCliockHolder;

@property (strong, nonatomic) IBOutlet UILabel *yearShow;
@property (strong, nonatomic) IBOutlet UILabel *monthShow;
@property (strong, nonatomic) IBOutlet UILabel *dayShow;
@property (strong, nonatomic) IBOutlet UILabel *timeShow;

@property (strong, nonatomic) IBOutlet UILabel *week1;
@property (strong, nonatomic) IBOutlet UILabel *week2;
@property (strong, nonatomic) IBOutlet UILabel *week3;
@property (strong, nonatomic) IBOutlet UILabel *week4;
@property (strong, nonatomic) IBOutlet UILabel *week5;
@property (strong, nonatomic) IBOutlet UILabel *week6;
@property (strong, nonatomic) IBOutlet UILabel *week7;

@property (strong, nonatomic) IBOutlet UILabel *day1;
@property (strong, nonatomic) IBOutlet UILabel *day2;
@property (strong, nonatomic) IBOutlet UILabel *day3;
@property (strong, nonatomic) IBOutlet UILabel *day4;
@property (strong, nonatomic) IBOutlet UILabel *day5;
@property (strong, nonatomic) IBOutlet UILabel *day6;
@property (strong, nonatomic) IBOutlet UILabel *day7;

@property NSTimer * _timer;
@property long status;
@end

