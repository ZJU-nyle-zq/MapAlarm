//
//  AddEventViewController.m
//  MapAlarm
//
//  Created by Bran on 12/13/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//

#import "AddEventViewController.h"
#import "DIDatepicker.h"
#import "Util.h"

@interface AddEventViewController ()
@property (weak, nonatomic) IBOutlet DIDatepicker *datepicker;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateLabel;
@property (strong, nonatomic) IBOutlet UITextField *Event;
@property (strong, nonatomic) IBOutlet UITextField *TimeChoose;
@property (strong,nonatomic) UIDatePicker* ScheduleDatePicker;
@property BOOL alert;
@end

@implementation AddEventViewController
@synthesize Year,Month,alert;
@synthesize Event=_Event;
@synthesize TimeChoose=_TimeChoose;
@synthesize ScheduleDatePicker=_ScheduleDatePicker;
@synthesize alertButton = _alertButton;
@synthesize addEventMap = _addEventMap, locationLable = _locationLable;
@synthesize _tmpAnnotation = _tmpAnnotation, _destinationAnnotation = _destinationAnnotation;
@synthesize _alarm = _alarm;
@synthesize longitude=_longitude,latitude=_latitude;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    _ScheduleDatePicker=[[UIDatePicker alloc]init];
    _ScheduleDatePicker.datePickerMode = UIDatePickerModeTime;
    _TimeChoose.inputView = _ScheduleDatePicker;
    // 建立一个UIToolbar
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    // 选取日期完成按钮
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                          action:@selector(cancelPicker)];
    // 把按鈕加進 UIToolbar
    toolBar.items = [NSArray arrayWithObject:right];
    //加上按钮
    _TimeChoose.inputAccessoryView = toolBar;
    
    [self.datepicker addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];
    [self.datepicker fillDatesFromCurrentDate:365];
    
    //[self.datepicker fillCurrentWeek];
    //[self.datepicker fillCurrentMonth];
    //[self.datepicker fillCurrentYear];
    [self.datepicker selectDateAtIndex:0];
    [self initMap];
    alert=true;
    [self renderAlarm];
    self.App=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    //self.coreManager = [[CoreDataManager alloc] init];
}

// render alarm if alarm exist
- (void) renderAlarm
{
    int offset=0;
    if (_alarm != nil)
    {
        _Event.text = _alarm.event;
        _TimeChoose.text = _alarm.time;
        _locationLable.text = _alarm.locationName;
        //scheduleDate=[formatter dateFromString:_alarm.date];
        //[scheduleDate setYear:2014];
        NSLog(@"Schedule Date:%@",_alarm.timestamp);
        NSLog(@"Current Date:%@",self.datepicker.selectedDate);
        offset=(int)([_alarm.timestamp timeIntervalSince1970]/(24*3600))-(int)([self.datepicker.selectedDate timeIntervalSince1970]/(24*3600));
        NSLog(@"Here%d",offset);
        NSLog(@"alert%d",_alarm.alert);
        [_alertButton setTitle:_alarm.alert ? @"On" : @"Off" forState:UIControlStateNormal];
        
        // render annotation
        CLLocationCoordinate2D mapCoordinate;
        mapCoordinate.latitude = _alarm.latitude;
        mapCoordinate.longitude = _alarm.longitude;
        
        _destinationAnnotation = [[CustomAnnotation alloc] initWithCoordinate:mapCoordinate];
        [_addEventMap addAnnotation:_destinationAnnotation];
        if (offset>0)
            [self.datepicker selectDateAtIndex:offset];
    }
}

- (void)initMap
{
    _addEventMap.delegate = self;
    _addEventMap.showsUserLocation = YES;
    _addEventMap.mapType = MKMapTypeStandard;
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake([Util getLatitude],[Util getLongtitude]);
    float zoomLevel = 0.2;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [_addEventMap setRegion:region animated:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddEventMap:)];
    [_addEventMap addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapAddEventMap:(UIGestureRecognizer*)gestureRecognizer
{
    
    CGPoint touchPoint = [gestureRecognizer locationInView:_addEventMap];// 这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate =
    [_addEventMap convertPoint:touchPoint toCoordinateFromView:_addEventMap];// 这里touchMapCoordinate就是该点的经纬度了
    _longitude=touchMapCoordinate.longitude;
    _latitude=touchMapCoordinate.latitude;
    NSString *astring = [[NSString alloc] initWithString:[NSString stringWithFormat:@"destination: %f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude]];
    
    _tmpAnnotation = [[CustomAnnotation alloc] initWithCoordinate:touchMapCoordinate];
    
    UIAlertView *alertVIew = [[UIAlertView alloc] initWithTitle:@"Sure change destination?"
                                                    message:astring
                                                   delegate:self
                                          cancelButtonTitle:@"Cancle"
                                          otherButtonTitles:@"Ok" ,nil];
    
    alertVIew.tag = 1;
    alertVIew.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertVIew textFieldAtIndex:0];
    textField.placeholder = @"  Input the name of destination";
    [alertVIew show];
}

- (void)alertView:(UIAlertView*) alertView clickedButtonAtIndex:(NSInteger)buttonIndex
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
            
            _locationLable.text = destinationName;
            if (_destinationAnnotation != nil)
            {
                [_addEventMap removeAnnotation : _destinationAnnotation];
            }
            
            _destinationAnnotation = _tmpAnnotation;
            _destinationAnnotation.destinationName = destinationName;
            [_addEventMap addAnnotation:_destinationAnnotation];
        }
    }
    
    else if (alertView.tag == 2)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)updateSelectedDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *Yformat= [[NSDateFormatter alloc] init];
    NSDateFormatter *Mformat=[[NSDateFormatter alloc] init];
    Yformat.dateFormat=[NSDateFormatter dateFormatFromTemplate:@"YYYY" options:0 locale:nil];
    Mformat.dateFormat=[NSDateFormatter dateFormatFromTemplate:@"MMMM" options:0 locale:nil];
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEddMMM" options:0 locale:nil];
    Year.text=[Yformat stringFromDate:self.datepicker.selectedDate];
    Month.text=[Mformat stringFromDate:self.datepicker.selectedDate];
    self.selectedDateLabel.text = [formatter stringFromDate:self.datepicker.selectedDate];
}

- (void)cancelPicker
{
    if ([self.view endEditing:NO]) {
        //格式化输出选择结果
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        // 添入日期结果
        _TimeChoose.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_ScheduleDatePicker.date]];
    }
}

- (IBAction)isClick:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"On"]){
        //[sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"Off" forState:UIControlStateNormal];
    } else{
        //[sender setBackgroundImage:[UIImage imageNamed:@"cardback"]  forState:UIControlStateNormal];
        [sender setTitle:@"On" forState:UIControlStateNormal];
    }
}

- (IBAction)Save:(UIButton *)sender
{
    NSString *event = _Event.text;
    if (event == nil || [event isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please Input Event"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil ,nil];
        alertView.tag = 3;
        [alertView show];
        return;
    }
    
    NSString *time = _TimeChoose.text;
    if (time == nil || [time isEqualToString:@"选择时间"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please Choose Time"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil ,nil];
        alertView.tag = 3;
        [alertView show];
        return;
    }
    
    NSString *locationName = _locationLable.text;
    if (locationName == nil || [locationName isEqualToString:@"choose on map"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please Choose location"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil ,nil];
        alertView.tag = 3;
        [alertView show];
        return;
    }
    
    NSString* sdate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEddMMM" options:0 locale:nil];
    sdate=[formatter stringFromDate:self.datepicker.selectedDate];
    //    //增
    if (_alarm){
        [self.App.coreManager deleteOneSchedule:_alarm.date atTime:_alarm.time];
    }
    if ([_alertButton.currentTitle isEqualToString:@"On"])
        alert = true;
    else
        alert = false;
    
    [self.App.coreManager insertCoreData:event atDate:sdate atTime:time atLocation:locationName atLongitude:_longitude atLatitude:_latitude atTimestamp:self.datepicker.selectedDate isAlert:alert];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add Event Successful"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil ,nil];
    alertView.tag = 2;
    [alertView show];

}

- (IBAction)Select:(UIButton *)sender
{
    NSMutableArray *ans;
    ans=[self.App.coreManager selectData];
}

- (IBAction)Delete:(UIButton *)sender
{
    [self.App.coreManager deleteData];
}

- (IBAction)returnBack:(id)sender
{
        [self dismissViewControllerAnimated:YES completion:nil];
}

// hide textField when click "return"
- (IBAction)TextField_DidEndOnExit:(id)sender
{
    [sender resignFirstResponder];
}

@end
