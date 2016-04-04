//
//  RewardsHistoryVC.h
//  Journe
//
//  Created by admin on 21/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "RewardHistoryCell.h"

@interface RewardsHistoryVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString *cellNib;
       IBOutlet UITableView *TB;
    NSMutableArray *respArray;
    NSUserDefaults *def;
    NSString *User_Id;
    MBProgressHUD *HUD;
    int ReedemRidePoints,ReedemPassPoints,totalRewardsPoints,a;
    
    IBOutlet UIView *shadow;
    IBOutlet UIView *backView;
    IBOutlet UILabel *lblDes;
    IBOutlet UITextField *txtReedemRide;
    
}

@end
