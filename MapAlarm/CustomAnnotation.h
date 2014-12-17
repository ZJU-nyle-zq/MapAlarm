//
//  CustomAnnotation.h
//  ModalEditor
//
//  Created by 邓永辉 on 14/12/8.
//  Copyright (c) 2014年 邓永辉. All rights reserved.
//

#ifndef ModalEditor_CustomAnnotation_h
#define ModalEditor_CustomAnnotation_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation :NSObject<MKAnnotation>
{
}

@property(nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property NSString *destinationName;

-(id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate;

@end

#endif
