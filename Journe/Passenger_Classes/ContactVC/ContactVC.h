//
//  Dvr_ContactVC.h
//  Journe_Driver
//
//  Created by admin on 11/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface ContactVC : UIViewController<UITextViewDelegate,UIAlertViewDelegate>
{
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPhone;
    IBOutlet UITextView *tvMessage;
    MBProgressHUD *HUD;
    NSUserDefaults *def;
    NSString *User_Id;
    IBOutlet UIButton *lblhelpline;
    IBOutlet UIButton *lblMail;
    IBOutlet UIButton *lblLoc;
}

@end
