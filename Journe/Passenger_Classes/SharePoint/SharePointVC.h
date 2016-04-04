//
//  SharePointVC.h
//  Journe_Driver
//
//  Created by admin on 29/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface SharePointVC : UIViewController
{
    IBOutlet UIScrollView *scrolView;
    
    IBOutlet UITextField *txtMObile;
    IBOutlet UITextField *txtSharePonts;
    IBOutlet UITextField *txtOptional;
    IBOutlet UIButton *btnSharePoint;
     IBOutlet UILabel *LblPoints;
    NSUserDefaults *def;
    NSMutableDictionary *userDict;
    NSString *User_Id;
    MBProgressHUD *HUD;
    int totalPoints;
}

@end
