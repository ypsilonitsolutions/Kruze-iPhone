//
//  BookingDetailsVC.h
//  Journe
//
//  Created by admin on 06/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface BookingDetailsVC : UIViewController<UIAlertViewDelegate>
{
    IBOutlet UILabel *lblBusNo;
    NSUserDefaults *def;
    IBOutlet UILabel *lblSource;
    IBOutlet UILabel *lblDesti;
    IBOutlet UILabel *lbl_SourceTime;
    IBOutlet UILabel *lbl_DestiTime;
    IBOutlet UILabel *lblSeatCost;
    IBOutlet UILabel *lblRideFare;
    IBOutlet UILabel *lblSeatId;
    IBOutlet UILabel *lblBusType;
    MBProgressHUD *HUD;
    NSString *userID,*rideSubmit;
    int freeRides,selectedSeatCount;
    NSString *finaSeatPrice;
    
}
@end
