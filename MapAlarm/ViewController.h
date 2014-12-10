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
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property NSArray *images;
@property long status;
@end

