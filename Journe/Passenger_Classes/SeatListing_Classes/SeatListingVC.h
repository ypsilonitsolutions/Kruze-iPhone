//
//  SeatListingVC.h
//  Journe
//
//  Created by admin on 02/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "SeatCell.h"

@interface SeatListingVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *HUD;
  IBOutlet  UITableView *tbSeat;
    NSMutableArray *SeatObjectsArr;
    NSUserDefaults *def;
    NSString *seat4nib,*seat5nib,*seat6nib,*seatStatus;
    NSMutableArray *mainArray,*SeatArray,*seatArr,*reserveArray,*selectedSeatId;
    NSMutableDictionary *maindict,*dictseat;
    NSString *availabelImg;
    NSString *selectedImg;
    NSString *reservedImg;
    int seatPrice,price;
    IBOutlet UILabel *lbl_count;
    IBOutlet UILabel *lbl_busNo;
    IBOutlet UILabel *lblTiming;
    IBOutlet UILabel *lblPrice;
    int count;
    NSString *finalPrice;
    IBOutlet UIButton *btnDone;
}
@end
