//
//  NotificationTVCell.h
//  Journe_Driver
//
//  Created by admin on 17/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationTVCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel *lblTime;
@property (weak,nonatomic) IBOutlet UILabel *lblBookDetail;
@property (weak,nonatomic) IBOutlet UIView *vwNotification;

@property (weak,nonatomic) IBOutlet UILabel *lblheader;

@end
