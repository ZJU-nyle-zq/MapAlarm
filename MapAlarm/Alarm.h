//
//  Alarm.h
//  MapAlarm
//
//  Created by 邓永辉 on 14/12/11.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#define REPEAT_TYPE_NO_REPEAT 0


@interface Alarm : NSObject

@property NSString* event;
@property int timeStart, timeEnd;
@property int repeat;
@property BOOL alert;
@property NSString* locationName;
@property float latitude, longitude;

@end
