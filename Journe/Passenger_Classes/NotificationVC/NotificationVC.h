//
//  NotificationVC.h
//  Journe_Driver
//
//  Created by admin on 17/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationTVCell.h"
#import "Constant.h"

@interface NotificationVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *cellNib;
    MBProgressHUD *HUD;
    NSMutableArray *respArray;
    NSString *User_Id;
    NSUserDefaults *def;
}

@end
