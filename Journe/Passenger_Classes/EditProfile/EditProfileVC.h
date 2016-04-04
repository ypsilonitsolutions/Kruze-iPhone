//
//  ProfileVC.h
//  Journe
//
//  Created by admin on 04/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface EditProfileVC : UIViewController
{
    int imageflag;
    NSData *imagedata;
    NSString *imageName;
    IBOutlet UIImageView *imgUser;
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtMAil;
    IBOutlet UITextField *txtCompany;
    IBOutlet UITextField *txtNo;
    IBOutlet UITextField *txtEmergencyNo;
    IBOutlet UITextField *txtReferalCode;
    IBOutlet UITextField *txtWorkLoc;
    IBOutlet UITextField *txtHomeLoc;
    IBOutlet UIButton *btnMale;
    IBOutlet UIButton *btnFemale;
    IBOutlet UIScrollView *ScrollView;
    IBOutlet UIView *InfoView;
    IBOutlet UIButton *btnDob;
    NSUserDefaults *def;
    NSString *User_Id;
    BOOL infoTap;
    NSString *userGender;
    IBOutlet UIImageView *imgAddInfo;
   IBOutlet UIView *shadowView;
    IBOutlet UIDatePicker *dataPicker;
    IBOutlet UIView *dataPickerView;
    NSString *SelectdDate;
    MBProgressHUD *HUD;
    IBOutlet UIButton *btnEdit;
   
    
}
@end
