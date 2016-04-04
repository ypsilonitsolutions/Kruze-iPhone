//
//  StopListingVC.h
//  Journe
//
//  Created by admin on 12/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface StopListingVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int to,from;
    BOOL b_to,b_from;
    NSString *S_Id,*D_Id,*S_time,*D_Time;
    NSString *selectedSource,*selectedDestination;
    NSMutableArray *localStopArray;
    IBOutlet UITableView *tbStop;
    IBOutlet UILabel *lblSource;
    IBOutlet UILabel *lblDesti;
    NSString *cell_nib;
    MBProgressHUD *HUD;
    NSUserDefaults *def;
    NSString *tripId,*FromId,*ToId;
    NSMutableArray *StopArray,*CellArray,*statusArray;
    IBOutlet UILabel *lbl_busNO;
}
@end
