//
//  Dvr_Expense_ListVC.h
//  Journe_Driver
//
//  Created by admin on 01/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface Dvr_Expense_ListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    NSString *cellNib;
    NSMutableArray *expArray;
   IBOutlet UITableView *tableExpense;
    NSMutableDictionary *driverDict;
    NSString *driverID;
    NSUserDefaults *def;
    MBProgressHUD *HUD;
    NSString *currentDate;
    IBOutlet UILabel *lblDate;
    IBOutlet UIView *shadowView;
    //IBOutlet UIDatePicker *dataPicker;
    IBOutlet UIView *dataPickerView;
    
    
    NSString *dateStatus;
    UIDatePicker *datePicker;
    UIView *darkView1;
    UIToolbar *toolBar1;
}
@end
