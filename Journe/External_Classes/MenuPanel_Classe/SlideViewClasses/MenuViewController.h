//
//  MenuViewController.h
//  ECSlidingViewController
//
//  Created by Administrator on 28/02/15.
//  Copyright (c) 2014 MaheshDhakad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface MenuViewController : UIViewController<UIAlertViewDelegate>
{
    IBOutlet UIScrollView *scroll_view;
    NSUserDefaults *nsud;
    NSMutableDictionary *userDict;
    IBOutlet UILabel *lbl_name;
    IBOutlet UILabel *lbl_mail;
    IBOutlet UIButton *BtnQRCode;
    MBProgressHUD *HUD;
    IBOutlet UILabel *lblPoints;
    NSString *User_Id;

}
@end
