//
//  History_BookVC.h
//  Journe_Driver
//
//  Created by admin on 24/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "HistoryTVCell.h"


@interface History_BookVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblHistory;
    NSString *CellNib;
    NSUserDefaults *def;
    MBProgressHUD *HUD;
    NSString *User_Id;
    NSMutableArray *respArray;
}

@end
