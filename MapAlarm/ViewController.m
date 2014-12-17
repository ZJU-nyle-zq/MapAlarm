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
#import "Util.h"
#import <math.h>

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

@synthesize sheduleMap = _sheduleMap;
@synthesize _locationManager;

@synthesize _scopeBtn, _destinationName,_pickerView, _pickViewHolder, startBusAlarmBtn = _startBusAlarmBtn, startBusAlarmBtnBackground = _startBusAlarmBtnBackground;
@synthesize _pickerArray, _scopeArray,ifBusAlarmOn = _ifBusAlarmOn, _destinationAnnotation, _tmpAnnotation, _circle, _busAlarmScope;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pickerArray = [NSArray arrayWithObjects:@"100m", @"200m", @"300m", @"500m", @"1000m", @"2000m", @"5000m", nil];
    _scopeArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:100], [NSNumber numberWithInt:200], [NSNumber numberWithInt:300], [NSNumber numberWithInt:500], [NSNumber numberWithInt:1000], [NSNumber numberWithInt:2000], [NSNumber numberWithInt:5000], nil];
    
    status = STATUS_SCHEDULE;
    
    celsiusLable.font = [UIFont fontWithName:@"Avenir-LightOblique" size:21];
    locationLable.font = [UIFont fontWithName:@"Baskerville-Italic" size:16];
    [self renderWeekDayFont:@"STHeitiSC-Medium"];
    [self renderDate];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(renderDate) userInfo:nil repeats:YES];
    
    mySheduleHolder.hidden = false;
    busAlarmCliockHolder.hidden = true;
    
    buttonLeft.userInteractionEnabled = true;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeftButton:)];
    [buttonLeft addGestureRecognizer:singleTap];
    
    buttonRight.userInteractionEnabled = true;
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightButton:)];
    [buttonRight addGestureRecognizer:singleTap2];
    
    [self getSheduleList];
    
    [self initMap];
    [self initBusAlertHolder];
}

- (void) initBusAlertHolder
{
    _ifBusAlarmOn = false;
    [_scopeBtn addTarget:self action:@selector(ClickScopeChooseBtn) forControlEvents:UIControlEventTouchUpInside];
    [_startBusAlarmBtn addTarget:self action:@selector(clickStartBusAlarmBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void) initMap
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    
    _sheduleMap.delegate = self;
    
    _sheduleMap.showsUserLocation = YES;
    _sheduleMap.mapType = MKMapTypeStandard;

    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(39.949227,116.395555);
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [_sheduleMap setRegion:region animated:YES];
    

    _busAlarmMap.delegate = self;
    
    _busAlarmMap.showsUserLocation = YES;
    _busAlarmMap.mapType = MKMapTypeStandard;
    [_busAlarmMap setRegion:region animated:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBusAlarmMap:)];
    [_busAlarmMap addGestureRecognizer:tap];
}

// will do
// get the shedule list
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

// click "My Shedule"
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

// click "Bus alarm clock"
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

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    static BOOL isFirst = true;
    
    if (!_ifBusAlarmOn)
    {
        [_locationManager stopUpdatingLocation];
    }
    
    NSString *strLat1 = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.latitude];
    NSString *strLng1 = [NSString stringWithFormat:@"%.4f",newLocation.coordinate.longitude];
    NSLog(@"Lat: %@  Lng: %@", strLat1, strLng1);
    
    if (isFirst)
    {
        isFirst = false;
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(newLocation.coordinate.latitude,newLocation.coordinate.longitude);
        float zoomLevel = 0.09;
        MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
        [_sheduleMap setRegion:region animated:YES];
        [_busAlarmMap setRegion:region animated:YES];
    }
    
    [self busAlarmCheck:newLocation.coordinate.latitude longtitude:newLocation.coordinate.longitude];
}

- (void) busAlarmCheck: (float) nowLatitude longtitude: (float) nowLongtitude
{
    if (!_ifBusAlarmOn || _destinationAnnotation == nil || _busAlarmScope == 0)
    {
        return;
    }
    
    NSLog(@"%f, %f",_destinationAnnotation.coordinate.latitude, _destinationAnnotation.coordinate.longitude);
    double distance = [Util getDistance:nowLatitude longtitude1:nowLongtitude :_destinationAnnotation.coordinate.latitude :_destinationAnnotation.coordinate.longitude];
    
    NSLog(@"%f", distance);
    
    if (distance <= _busAlarmScope)
    {
        NSLog(@"闹铃");
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locError:%@", error);
 }

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.row != _sheduleShowList.count)
        {
            [_sheduleShowList removeObjectAtIndex:[indexPath row]];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _sheduleShowList.count + 1;
}

// render table view cell
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

// will do
// click table view cell
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击%ld", (long)indexPath.row);
    [_locationManager startUpdatingLocation];
}

- (void) ClickScopeChooseBtn
{
    [self showPickerView];
}

- (void) clickStartBusAlarmBtn
{
    if (![[_scopeBtn titleLabel].text isEqualToString:@"Please Choose"] && _destinationAnnotation != nil)
    {
        if (_ifBusAlarmOn)
        {
            [_startBusAlarmBtnBackground setBackgroundColor:[self colorWithHex:0xcccccc alpha:0.4]];
            [_startBusAlarmBtn setTitle:@"Start" forState:UIControlStateNormal];
            _ifBusAlarmOn = !_ifBusAlarmOn;
        }
        else
        {
            [_startBusAlarmBtnBackground setBackgroundColor:[self colorWithHex:0xFF0033 alpha:0.8]];
            [_startBusAlarmBtn setTitle:@"Stop" forState:UIControlStateNormal];
            _ifBusAlarmOn = !_ifBusAlarmOn;
            
            
            NSInteger row = [_pickerView selectedRowInComponent:0];
            NSNumber *number = [_scopeArray objectAtIndex:row];
            _busAlarmScope = [number intValue];

            [_locationManager startUpdatingLocation];
        }
    }
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Need Perfect information"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancle"
                                              otherButtonTitles:nil ,nil];
        [alert show];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerArray count];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_pickerArray objectAtIndex:row];
}

- (void)tapBusAlarmMap:(UIGestureRecognizer*)gestureRecognizer
{
    
    CGPoint touchPoint = [gestureRecognizer locationInView:_busAlarmMap];// 这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate =
    [_busAlarmMap convertPoint:touchPoint toCoordinateFromView:_busAlarmMap];// 这里touchMapCoordinate就是该点的经纬度了
    
    NSString *astring = [[NSString alloc] initWithString:[NSString stringWithFormat:@"destination: %f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude]];
    
    _tmpAnnotation = [[CustomAnnotation alloc] initWithCoordinate:touchMapCoordinate];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sure change destination?"
                                                    message:astring
                                                   delegate:self
                                          cancelButtonTitle:@"Cancle"
                                          otherButtonTitles:@"Ok" ,nil];
    
    alert.tag = 1;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.placeholder = @"  Input the name of destination";
    [alert show];

}

- (void) alertView:(UIAlertView*) alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        if (buttonIndex == 0)
        {
            // click "Cancle"
        }
        else
        {
            // click "Ok"
            UITextField *textField = [alertView textFieldAtIndex:0];
            NSString *destinationName = textField.text;
            
            destinationName = [destinationName isEqualToString:@""]? @"default" : destinationName;
            _destinationName.text = destinationName;
            if (_destinationAnnotation != nil)
            {
                [_busAlarmMap removeAnnotation : _destinationAnnotation];
            }
            
            _destinationAnnotation = _tmpAnnotation;
            _destinationAnnotation.destinationName = destinationName;
            [_busAlarmMap addAnnotation:_destinationAnnotation];
            
            [self showDestinantionCircle];
        }
    }
}

- (void) showDestinantionCircle
{
    if (![[_scopeBtn titleLabel].text isEqualToString:@"Please Choose"] && _destinationAnnotation != nil)
    {
        NSInteger row = [_pickerView selectedRowInComponent:0];
        NSNumber *number = [_scopeArray objectAtIndex:row];
        int scope = [number intValue];
        _busAlarmScope = scope;
        
        if (_circle != nil)
        {
            [_busAlarmMap removeOverlay:_circle];
        }
        _circle = [MKCircle circleWithCenterCoordinate:_destinationAnnotation.coordinate radius:scope];
        [_busAlarmMap addOverlay:_circle];
    }
}

- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    circleView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    return circleView;
}

- (IBAction)clickCanclePickerView:(id)sender
{
    [self hidePickerView];
}

- (IBAction)clickChooseCancle:(id)sender
{
    [self hidePickerView];
     NSInteger row = [_pickerView selectedRowInComponent:0];
    [_scopeBtn setTitle:[_pickerArray objectAtIndex:row] forState:UIControlStateNormal];
    [_scopeBtn titleLabel].text = [_pickerArray objectAtIndex:row];
    [_scopeBtn setTitleColor:[self colorWithHex:0xffffff alpha:1] forState:UIControlStateNormal];
    
    [self showDestinantionCircle];
}

- (void) hidePickerView
{
    _pickViewHolder.hidden = true;
}

- (void) showPickerView
{
    _pickViewHolder.hidden = false;
}
@end
