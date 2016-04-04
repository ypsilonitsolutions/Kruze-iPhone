//
//  Dvr_Daily_ListVC.h
//  Journe_Driver
//
//  Created by admin on 18/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface Dvr_Daily_ListVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *ArrayList;
        NSString *cellNib;
    MBProgressHUD *HUD;
    NSUserDefaults *def;
    NSString *driverID,*currentDate;
    NSMutableDictionary *driverDict;
    IBOutlet UILabel *lbl_date;
    IBOutlet UIView *shadowView;
    IBOutlet UIDatePicker *dataPicker;
    IBOutlet UIView *dataPickerView;
    NSDictionary *selected_dict;
}
@property (weak, nonatomic) IBOutlet UITableView *tblDailyList;


@end
