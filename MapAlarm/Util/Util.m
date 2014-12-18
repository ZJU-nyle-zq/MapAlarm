//
//  Util.m
//  MapAlarm
//
//  Created by 邓永辉 on 14/12/15.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#import "Util.h"
#import <math.h>

@implementation Util

static double _latitude;
static double _longtigutde;

+ (double) getDistance :(double) latitude1 longtitude1: (double) longitude1 : (double) latitude2 : (double) longitude2
{
    double radLat1 = [self rad:latitude1];
    double radLat2 = [self rad:latitude2];
    double a = radLat1 - radLat2;
    double b = [self rad:longitude1] - [self rad:longitude2];
    
    double s = 2 * asin( sqrt( pow(sin(a/2),2) + cos(radLat1) * cos(radLat2) * pow( sin(b / 2), 2)));
    s = s * EARTH_RADIUS;
    s = round(s * 10000) / 10000;
    return s * 1000;
}

+ (double) rad : (double) d
{
     return d * M_PI / 180.0;
}

+ (double) getLatitude
{
    return _latitude;
}

+ (double) getLongtitude
{
    return _longtigutde;
}

+ (void) setLatitude:(double)latitude
{
    _latitude = latitude;
}

+ (void) setLongtitude:(double)longtitude
{
    _longtigutde = longtitude;
}

@end
