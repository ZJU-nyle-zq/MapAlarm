//
//  ViewController.m
//  MapAlarm
//
//  Created by 邓永辉 on 14/12/10.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#import "ViewController.h"
#import "SheduleCell.h"
#import "Alarm.h"

#define STATUS_SCHEDULE 0
#define STATUS_BUS_ALARM 1

@interface ViewController ()

@end

@implementation ViewController

@synthesize celsiusLable, locationLable, buttonLeft, buttonRight, busAlarmCliockHolder, mySheduleHolder, status , _timer, _tableview;

@synthesize yearShow, monthShow, dayShow, timeShow;
@synthesize week1, week2, week3, week4, week5, week6, week7;
@synthesize day1, day2, day3, day4, day5, day6, day7;

@synthesize _sheduleShowList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    status = STATUS_SCHEDULE;
    
    celsiusLable.font = [UIFont fontWithName:@"Avenir-LightOblique" size:21];
    locationLable.font = [UIFont fontWithName:@"Baskerville-Italic" size:16];
    [self renderWeekDayFont:@"STHeitiSC-Medium"];
    [self renderDate];
    
    [self getSheduleList];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(renderDate) userInfo:nil repeats:YES];
    
    mySheduleHolder.hidden = false;
    busAlarmCliockHolder.hidden = true;
    
    buttonLeft.userInteractionEnabled = true;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeftButton:)];
    [buttonLeft addGestureRecognizer:singleTap];
    
    buttonRight.userInteractionEnabled = true;
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightButton:)];
    [buttonRight addGestureRecognizer:singleTap2];
}

- (void) getSheduleList
{
    _sheduleShowList = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i ++)
    {
        Alarm * alarm = [[Alarm alloc] init];
        alarm.event = [[NSString alloc] initWithString:[NSString stringWithFormat:@"Meeting with Dobe%i", i]];
        [_sheduleShowList addObject:alarm];
    }
    
    [_tableview reloadData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sheduleShowList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SheduleCellIdentifier = @"sheduleCell";
    static NSString *ShedukeAddCellIdentifier = @"sheduleAddCell";

    if (indexPath.row == _sheduleShowList.count)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             ShedukeAddCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShedukeAddCellIdentifier];
        }
        UILabel *addEventLable = (UILabel *)[cell viewWithTag:213];
        addEventLable.font = [UIFont fontWithName:@"Arial-ItalicMT" size:13];
        return cell;
    }
    else
    {
        SheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SheduleCellIdentifier];
        if (cell == nil)
        {
            cell = [[SheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SheduleCellIdentifier];
        }
        
        Alarm *alarm = _sheduleShowList[indexPath.row];
        cell.eventLable.text = alarm.event;
        return cell;
    }
}

- ( NSInteger )numberOfSectionsInTableView:( UITableView  *)tableView
{
    return 1;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击%ld", (long)indexPath.row);
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

-(void)renderDate
{
    
    NSArray * arrMonth=[NSArray arrayWithObjects:@"January", @"February" ,@"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear|
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    long year=[comps year];
    long month = [comps month];
    long day = [comps day];
    long hour = [comps hour];
    long minute = [comps minute];
    
    yearShow.text = [NSString stringWithFormat:@"%4ld", year];
    monthShow.text = [NSString stringWithFormat:@"%@", [arrMonth objectAtIndex:(month-1)]];
    dayShow.text = [NSString stringWithFormat:@"%2ld",day];
    
    if (hour >= 12)
    {
        NSString *tmp = hour - 12 > 9 ? @"" : @"0";
        tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%ld:", hour - 12]];
        if (minute <= 9) {
            tmp = [tmp stringByAppendingString:@"0"];
        }
        tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%ld PM", minute]];
        
        timeShow.text = tmp;
    }
    else
    {
        NSString *tmp = hour > 9 ? @"" : @"0";
        tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%ld:", hour]];
        if (minute <= 9) {
            tmp = [tmp stringByAppendingString:@"0"];
        }
        tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%ld PM", minute]];
        timeShow.text = [NSString stringWithFormat:@"%ld:%ld AM", hour, minute];
    }
    
    [self setWeekDayInfo:week1 :day1 :[calendar components:unitFlags fromDate:[date dateByAddingTimeInterval:+0*3600*24]]];
    [self setWeekDayInfo:week2 :day2 :[calendar components:unitFlags fromDate:[date dateByAddingTimeInterval:+1*3600*24]]];
    [self setWeekDayInfo:week3 :day3 :[calendar components:unitFlags fromDate:[date dateByAddingTimeInterval:+2*3600*24]]];
    [self setWeekDayInfo:week4 :day4 :[calendar components:unitFlags fromDate:[date dateByAddingTimeInterval:+3*3600*24]]];
    [self setWeekDayInfo:week5 :day5 :[calendar components:unitFlags fromDate:[date dateByAddingTimeInterval:+4*3600*24]]];
    [self setWeekDayInfo:week6 :day6 :[calendar components:unitFlags fromDate:[date dateByAddingTimeInterval:+2*3600*24]]];
    [self setWeekDayInfo:week7 :day7 :[calendar components:unitFlags fromDate:[date dateByAddingTimeInterval:+3*3600*24]]];
}

-(void)setWeekDayInfo:(UILabel*)weekShow :(UILabel*)dayShowLable :(NSDateComponents *)comps
{
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat", nil];
    long week = [comps weekday];
    long day = [comps day];
    weekShow.text = [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week%7]];
    if(day <= 9)
    {
        dayShowLable.text = [NSString stringWithFormat:@"0%ld",day];
    }
    else
    {
        dayShowLable.text = [NSString stringWithFormat:@"%2ld",day];
    }

}

//render weekDay Font
-(void)renderWeekDayFont:(NSString*)font
{
    int size = 14;
    week1.font = [UIFont fontWithName:font size:size];
    week2.font = [UIFont fontWithName:font size:size];
    week3.font = [UIFont fontWithName:font size:size];
    week4.font = [UIFont fontWithName:font size:size];
    week5.font = [UIFont fontWithName:font size:size];
    week6.font = [UIFont fontWithName:font size:size];
    week7.font = [UIFont fontWithName:font size:size];
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
