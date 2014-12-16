//
//  CustomAnnotation.m
//  ModalEditor
//
//  Created by 邓永辉 on 14/12/8.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomAnnotation.h"

@implementation CustomAnnotation
@synthesize coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate
{
    if(self =[super init])
    {
        coordinate =aCoordinate;
    }
    return self;
}

-(CLLocationCoordinate2D)coordinate
{
    return coordinate;
}

//注解标题
-(NSString *)title
{
    return _destinationName == nil ? @"" : _destinationName;
}

@end