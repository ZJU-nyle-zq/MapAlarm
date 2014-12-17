//
//  AddEventViewController.h
//  MapAlarm
//
//  Created by Bran on 12/13/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import <CoreData/CoreData.h>
//#import "Schedule.h"
@interface AddEventViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *Year;
@property (strong, nonatomic) IBOutlet UILabel *Month;
@property AppDelegate *App;
//@property (strong, nonatomic) IBOutlet UIPickerView *TimePicker;
//@property NSArray * TimepickerArray;
@end
