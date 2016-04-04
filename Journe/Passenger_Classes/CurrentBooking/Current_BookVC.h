//
//  Current_BookVC.h
//  Journe_Driver
//
//  Created by admin on 23/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "CurrentCell.h"

@interface Current_BookVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tbBookings;
     NSString *CellNib;
    NSUserDefaults *def;
    MBProgressHUD *HUD;
    NSString *User_Id;
    NSMutableArray *respArray;
}
@end
