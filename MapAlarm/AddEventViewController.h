//
//  AddEventViewController.h
//  MapAlarm
//
//  Created by Bran on 12/13/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "CustomAnnotation.h"
#import "Alarm.h"

@interface AddEventViewController : UIViewController<UITextFieldDelegate, MKMapViewDelegate>
#import "AppDelegate.h"
@property (strong, nonatomic) IBOutlet UILabel *Year;
@property (strong, nonatomic) IBOutlet MKMapView *addEventMap;
@property (strong, nonatomic) IBOutlet UILabel *Month;
@property (strong, nonatomic) IBOutlet UILabel *locationLable;
@property (strong, nonatomic) IBOutlet UIButton *alertButton;

@property ViewController *parentController;
@property CustomAnnotation *_destinationAnnotation;
@property CustomAnnotation *_tmpAnnotation;
- (IBAction)finishAddEvent:(id)sender;
- (IBAction)returnBack:(id)sender;

@property Alarm * _alarm;

@property AppDelegate *App;
@end
