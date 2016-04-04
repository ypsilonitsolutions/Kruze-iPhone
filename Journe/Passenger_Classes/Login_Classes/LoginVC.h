//
//  LoginVC.h
//  Journe
//
//  Created by admin on 19/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <GoogleSignIn/GoogleSignIn.h>

@interface LoginVC :UIViewController<GIDSignInDelegate,GIDSignInUIDelegate>
{
   
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnSignUp;
    IBOutlet UIButton *btnFb;
    IBOutlet UIButton *btnGplus;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPwd;
    IBOutlet UIScrollView *scrollView;
    MBProgressHUD *HUD;
    NSUserDefaults *nsud;
    NSString *usertype;
    IBOutlet UIView *shadowView;
    IBOutlet UITextField *txtForgetMail;
    
    
    
    
}

@end
