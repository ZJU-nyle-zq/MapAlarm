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
@end

@implementation AddEventViewController
@synthesize Year,Month;
@synthesize Event=_Event;
@synthesize TimeChoose=_TimeChoose;
@synthesize ScheduleDatePicker=_ScheduleDatePicker;
@synthesize addEventMap = _addEventMap, locationLable = _locationLable;
@synthesize _tmpAnnotation = _tmpAnnotation, _destinationAnnotation = _destinationAnnotation;
@synthesize _alarm = _alarm;

- (void)viewDidLoad {
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
    
    //    [self.datepicker fillCurrentWeek];
    //    [self.datepicker fillCurrentMonth];
    //[self.datepicker fillCurrentYear];
    [self.datepicker selectDateAtIndex:0];
    
    [self initMap];
    
    [self renderAlarm];
}

// will do
// render alarm if alarm exist
- (void) renderAlarm
{
    if (_alarm != nil)
    {
        
    }
}

- (void) initMap
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

-(void) cancelPicker
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

- (IBAction)finishAddEvent:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Event Successful"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil ,nil];
    alert.tag = 2;
    [alert show];
}

- (IBAction)returnBack:(id)sender
{
        [self dismissViewControllerAnimated:YES completion:nil];
}
@end
