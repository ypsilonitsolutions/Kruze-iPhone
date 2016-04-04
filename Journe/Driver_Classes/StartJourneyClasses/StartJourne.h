//
//  DashboardVC.h
//  Journe
//
//  Created by admin on 20/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "CancelView.h"
@interface StartJourne : UIViewController <UITableViewDataSource, UITableViewDelegate,UITextViewDelegate>
{
    
    NSUserDefaults *nsud;
    MBProgressHUD *HUD;
    NSMutableArray *arrayForBool,*ResponseArray,*StopArray,*StopNameArr,*reachStatus;
    NSString *cell_nib;
    int rowHieght;
    NSString *driverId;
    NSMutableDictionary *userDict;
    IBOutlet UILabel *lbl_date;
    int headerHieght;
    NSString *trip_id,*bus_id,*stop_id;
    NSString *current_trip_id,*current_stop_id;
    NSString *shouldShowNext;
    CancelView *cv;
}
@property (weak, nonatomic) IBOutlet UITableView *routeTable;
@property (strong, nonatomic) NSString *key;
@end
