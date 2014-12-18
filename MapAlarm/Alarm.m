//
//  Alarm.m
//  MapAlarm
//
//  Created by 邓永辉 on 14/12/11.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#import "Alarm.h"

@implementation Alarm

@synthesize event, time,date, alert, latitude, longitude, locationName;

-(id)init
{
    if(self=[super init])
    {
        alert = false;
    }
    return self;
}

@end
