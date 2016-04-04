//
//  LoginVC.h
//  Journe
//
//  Created by admin on 19/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface Dvr_LoginVC :UIViewController
{
   
    IBOutlet UIButton *btnLogin;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPwd;
    IBOutlet UIScrollView *scrollView;
    MBProgressHUD *HUD;
    NSUserDefaults *nsud;
    NSString *usertype;
      
    
    
    
}

@end
