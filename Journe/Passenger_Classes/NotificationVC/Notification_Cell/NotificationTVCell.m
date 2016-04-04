//
//  NotificationTVCell.m
//  Journe_Driver
//
//  Created by admin on 17/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "NotificationTVCell.h"

@implementation NotificationTVCell
@synthesize lblBookDetail,lblTime,vwNotification;

- (void)awakeFromNib {
    // Initialization code
    vwNotification.layer.borderWidth = 1;
    
    vwNotification.layer.cornerRadius = 3;
    vwNotification.layer.borderColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
