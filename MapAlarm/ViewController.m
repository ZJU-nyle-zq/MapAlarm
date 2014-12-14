//
//  ViewController.m
//  MapAlarm
//
//  Created by 邓永辉 on 14/12/10.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize celsiusLable, locationLable, segmentedControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    celsiusLable.font = [UIFont fontWithName:@"Avenir-LightOblique" size:21];
    locationLable.font = [UIFont fontWithName:@"Baskerville-Italic" size:16];
    
     [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
}

-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index)
    {
        case 0:
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
            break;
        case 1:
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"weather_cloud"]];
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
