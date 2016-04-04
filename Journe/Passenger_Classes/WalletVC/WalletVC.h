//
//  WalletVC.h
//  Journe_Driver
//
//  Created by admin on 20/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface WalletVC : UIViewController
{
    IBOutlet UIView *vWWallet;
    IBOutlet UITextField *txtAddFunds;
    IBOutlet UILabel *lblJournePrice;
    MBProgressHUD *HUD;
    NSUserDefaults *def;
    NSString *User_Id;
    IBOutlet UILabel *lblPoints;
  IBOutlet  UILabel *lblTrip;
}

@end
