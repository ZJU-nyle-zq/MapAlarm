//
//  Schedule.h
//  MapAlarm
//
//  Created by Bran on 12/18/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSNumber * alert;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * event;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * locationname;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSNumber * latitude;

@end
