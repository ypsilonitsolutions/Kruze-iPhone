//
//  VerifyOtpVC.h
//  Journe
//
//  Created by admin on 20/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface VerifyOtpVC : UIViewController
{
    
    IBOutlet UIButton *btnResend;
    IBOutlet UIButton *btnSubmit;
    IBOutlet UITextField *txtOtp;
    IBOutlet UILabel *lbl_number;
    MBProgressHUD *HUD;
    NSUserDefaults *nsud;
    NSString *Mobile_No;
}
@end
