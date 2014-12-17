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
    alert=true;
    self.App=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    //self.coreManager = [[CoreDataManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void) cancelPicker {
    if ([self.view endEditing:NO]) {
        //格式化输出选择结果
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        // 添入日期结果
        _TimeChoose.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_ScheduleDatePicker.date]];
    }
}
- (IBAction)isClick:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"On"]){
        //[sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"Off" forState:UIControlStateNormal];
        alert=false;
    } else{
        //[sender setBackgroundImage:[UIImage imageNamed:@"cardback"]  forState:UIControlStateNormal];
        [sender setTitle:@"On" forState:UIControlStateNormal];
        alert=true;
    }
}
- (IBAction)Save:(UIButton *)sender {
    NSLog(@"Run here");
    //    //增
    [self.App.coreManager insertCoreData:_Event.text atDate:self.datepicker.selectedDate atTime:_TimeChoose.text isAlert:alert];
    /*NSManagedObjectContext *context = [self managedObjectContext];
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Schedule" inManagedObjectContext:context];
    [newDevice setValue:self.Event.text forKey:@"event"];
    [newDevice setValue:self.TimeChoose.text forKey:@"time"];
    //[newDevice setValue:self.versionTextField.text forKey:@"version"];
    //[newDevice setValue:self.companyTextField.text forKey:@"company"];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];*/
}
- (IBAction)Select:(UIButton *)sender {
    /*NSMutableArray *ans;
    ans=[self.App.coreManager selectData];*/
}
- (IBAction)Delete:(UIButton *)sender {
    [self.App.coreManager deleteData];
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
