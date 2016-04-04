//
//  HistoryDetails.h
//  Journe
//
//  Created by admin on 29/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface HistoryDetails : UIViewController
{
    IBOutlet UILabel *lblBusnumber;
    IBOutlet UILabel *lblSourceAdd;
    IBOutlet UILabel *lblDestinationAdd;
    IBOutlet UILabel *lblSourceTime;
    IBOutlet UILabel *lblDetinationTime;
    IBOutlet UILabel *lblBookingId;
    IBOutlet UILabel *lblSeatNo;
    IBOutlet UILabel *lblTotalCost;
    NSUserDefaults *def;
    MBProgressHUD *HUD;
    NSString *User_Id,*bId;
    IBOutlet UIButton *btnfeedback;
    
    
}
@end
