//
//  Detail_CBookVC.h
//  Journe_Driver
//
//  Created by admin on 24/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface Detail_CBookVC : UIViewController<UIAlertViewDelegate,UITextViewDelegate>
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
    IBOutlet UIImageView *imgCancel;
    IBOutlet UIButton *btnCancel;
    MBProgressHUD *HUD;
    NSString *User_Id,*bId;
    IBOutlet UIButton *btntrackride;
    IBOutlet UIView *shadow;
    IBOutlet UITextView *txtView;
    
    
}
@end
