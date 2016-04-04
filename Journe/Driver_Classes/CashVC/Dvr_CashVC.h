//
//  Dvr_CashVC.h
//  Journe_Driver
//
//  Created by admin on 02/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface Dvr_CashVC : UIViewController
{
    NSString *cellNib;
    MBProgressHUD *HUD;
    NSString *dateStatus;
    UIDatePicker *datePicker;
    UIView *darkView1;
    UIToolbar *toolBar1;
    NSString *currentDate;
    IBOutlet UILabel *dateHeader;
}
@property (strong, nonatomic) NSMutableArray *mArrayCash;
@property (strong, nonatomic) NSMutableArray *mArayDetail;

@property (strong, nonatomic) NSMutableDictionary *DictCash;


@end
