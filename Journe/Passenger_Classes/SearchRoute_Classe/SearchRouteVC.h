//
//  SearchRouteVC.h
//  Journe
//
//  Created by admin on 25/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface SearchRouteVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
     NSString *cell_nib,*tableview_type,*tapCheck,*RouteID,*SearchType;
    NSUserDefaults *def;
    NSString *source,*destination;
    MBProgressHUD *HUD;
    NSMutableArray *TripArray,*landmarkArray,*searchArray;
    IBOutlet UITextField *txtSource;
 IBOutlet UITextField *txtDesti;
    IBOutlet UITableView *cityTable;
    NSString *cityId;
    NSString *searchTxt;
    IBOutlet UILabel *lblNoResult;
}
@property (weak, nonatomic) IBOutlet UITableView *Table;
@end
