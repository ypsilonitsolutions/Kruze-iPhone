//
//  MemberIdentificationVC.h
//  Journe
//
//  Created by admin on 28/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <MessageUI/MessageUI.h>
@interface MemberIdentificationVC : UIViewController<MFMailComposeViewControllerDelegate>
{
    
    IBOutlet UILabel *lbl_name;
    IBOutlet UILabel *lbl_mail;
    IBOutlet UILabel *lbl_comapny;
    IBOutlet UIImageView *img_user;
    NSUserDefaults *nsud;
    NSMutableDictionary *userDict;
    IBOutlet UIImageView *imgQRCode;
    MBProgressHUD *HUD;
    IBOutlet UILabel *lblHelp;
    IBOutlet UILabel *mail;
    IBOutlet UILabel *website;
    
    
}
@end
