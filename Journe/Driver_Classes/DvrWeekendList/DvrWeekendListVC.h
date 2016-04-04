//
//  DvrWeekendListVC.h
//  Journe_Driver
//
//  Created by admin on 15/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "Dvr_KiloMTVCell.h"
@interface DvrWeekendListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *userdict;
    NSString *DriverId;
    NSUserDefaults *nsud;
    MBProgressHUD *HUD;
    NSString *cellNib;
    IBOutlet UIButton *addMoreBtn;
}
@property (strong, nonatomic)  IBOutlet UITableView *tblWeekend;
@property (strong, nonatomic) NSMutableArray *arryList;
@property (strong, nonatomic) NSMutableDictionary *dictionaryRide;

@end
