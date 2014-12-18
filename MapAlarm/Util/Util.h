//
//  Util.h
//  MapAlarm
//
//  Created by 邓永辉 on 14/12/15.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EARTH_RADIUS 6378.137

@interface Util : NSObject

+ (double) getDistance:(double) latitude1 longtitude1: (double) longitude1 : (double) latitude2 : (double) longitude2;

+ (double) rad : (double) d;

+ (double) getLongtitude;
+ (double) getLatitude;
+ (void) setLatitude : (double) latitude;
+ (void) setLongtitude : (double) longtitude;

@end
