//
//  AddEventViewController.m
//  MapAlarm
//
//  Created by Bran on 12/13/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//

#import "AddEventViewController.h"
#import "DIDatepicker.h"

@interface AddEventViewController ()
@property (weak, nonatomic) IBOutlet DIDatepicker *datepicker;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateLabel;

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    // Do any additional setup after loading the view.
    [self.datepicker addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];
    
    //    [self.datepicker fillDatesFromCurrentDate:14];
    //    [self.datepicker fillCurrentWeek];
    //    [self.datepicker fillCurrentMonth];
    [self.datepicker fillCurrentYear];
    [self.datepicker selectDateAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateSelectedDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEEddMMMM" options:0 locale:nil];
    
    self.selectedDateLabel.text = [formatter stringFromDate:self.datepicker.selectedDate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
