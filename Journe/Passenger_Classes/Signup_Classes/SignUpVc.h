//
//  SignUpVc.h
//  Journe
//
//  Created by admin on 19/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface SignUpVc : UIViewController<UIAlertViewDelegate>
{
    
    int imageflag;
    NSData *imagedata;
    NSString *imageName;
    BOOL infoTap;
    IBOutlet UIButton *btnSubmit;
    IBOutlet UIButton *btnterms_check;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPwd;
    IBOutlet UITextField *txtConfirmPwd;
    IBOutlet UITextField *txtTelephone;
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtComapnyName;
    IBOutlet UIScrollView *scrollView;
    BOOL terms_check;
    IBOutlet UIView *shadow_view;
    IBOutlet UIWebView *web_view;
    IBOutlet UIButton *btn_terms_cancel;
    NSUserDefaults *nsud;
    int termsConditionsStatus;
    NSString *resp_Check,*user_ID,*signUpTypeCheck;
    MBProgressHUD *HUD;
    IBOutlet UIImageView *img_user;
    IBOutlet UIButton *btnCompany;
    IBOutlet UIButton *btnSingle;
    IBOutlet UITextField *txtempId;
    IBOutlet UILabel *lblCompany;
    IBOutlet UILabel *lblEmpid;
    IBOutlet UITableView *tb_company;
    NSMutableArray *companyArray;
    NSString *companyId;
    IBOutlet UIButton *btnTapCompany;
    IBOutlet UIImageView *imgTick;
    IBOutlet UITextField *txtReferCode;
}

@end
