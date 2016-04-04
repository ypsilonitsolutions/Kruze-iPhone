//
//  FeedbackVC.h
//  Journe
//
//  Created by admin on 29/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface FeedbackVC : UIViewController<UIAlertViewDelegate>
{
    NSString *FeedbackTxt,*User_Id;
    MBProgressHUD *HUD;
    NSUserDefaults *def;
    
}
@end
