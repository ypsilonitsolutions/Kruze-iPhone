//
//  Dvr_KiloMetrVC.h
//  Journe_Driver
//
//  Created by admin on 01/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface Dvr_KiloMetrVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
  NSString *countCheck;
   NSString *Kms,*KmsType;
    NSUserDefaults *def;
    NSMutableDictionary *driverDict,*kmDict;
    NSString *DriverId;
    IBOutlet UIButton *btn_timing;
    int flag;
    NSString *start_km,*end_km;
}

@property (strong, nonatomic ) IBOutlet UITableView *tblDaily;
@property (strong, nonatomic)   NSMutableArray *mArrayRide;

@end
