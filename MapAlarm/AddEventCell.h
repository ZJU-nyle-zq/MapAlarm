//
//  AddEventCell.h
//  MapAlarm
//
//  Created by Bran on 12/15/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventCell : UITableViewCell
@property (strong
           , nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@end
