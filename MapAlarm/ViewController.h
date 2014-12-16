//
//  ViewController.h
//  MapAlarm
//
//  Created by 邓永辉 on 14/12/10.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CustomAnnotation.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *celsiusLable;
@property (strong, nonatomic) IBOutlet UILabel *locationLable;
@property (strong, nonatomic) IBOutlet UIImageView *buttonLeft;
@property (strong, nonatomic) IBOutlet UIImageView *buttonRight;
@property (strong, nonatomic) IBOutlet UIView *mySheduleHolder;
@property (strong, nonatomic) IBOutlet UIView *busAlarmCliockHolder;

// my shedule
@property (strong, nonatomic) IBOutlet UILabel *yearShow;
@property (strong, nonatomic) IBOutlet UILabel *monthShow;
@property (strong, nonatomic) IBOutlet UILabel *dayShow;
@property (strong, nonatomic) IBOutlet UILabel *timeShow; 

@property (strong, nonatomic) IBOutlet UITableView * _tableview;
@property (strong, nonatomic) IBOutlet MKMapView *sheduleMap;

// bus alarm
@property (strong, nonatomic) IBOutlet UIButton *_scopeBtn;
@property (strong, nonatomic) IBOutlet UILabel *_destinationName;
@property (strong, nonatomic) IBOutlet UIButton *startBusAlarmBtn;
@property (strong, nonatomic) IBOutlet UIView *startBusAlarmBtnBackground;
@property (strong, nonatomic) IBOutlet MKMapView *busAlarmMap;
@property (strong, nonatomic) IBOutlet UIPickerView *_pickerView;
@property (strong, nonatomic) IBOutlet UIView *_pickViewHolder;


@property (strong, nonatomic) CLLocationManager *_locationManager;
@property NSMutableArray * _sheduleShowList;
@property NSTimer * _timer;
@property long status;

@property NSArray * _pickerArray;
@property NSArray * _scopeArray;
@property Boolean ifBusAlarmOn;
@property int _busAlarmScope;
@property CustomAnnotation *_destinationAnnotation;
@property CustomAnnotation *_tmpAnnotation;
@property MKCircle *_circle;

- (IBAction)clickCanclePickerView:(id)sender;
- (IBAction)clickChooseCancle:(id)sender;

@end

