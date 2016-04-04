//
//  Dvr_KmWeekendVC.h
//  Journe_Driver
//
//  Created by admin on 06/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface Dvr_KmWeekendVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    IBOutlet UITextField *txtVehicle;
    IBOutlet  UIButton *btnStatus;
    IBOutlet UITextField *txtDutyH;
    IBOutlet UITextField *txtTotalKm;
    IBOutlet UITextField *txtClosingKm;
    IBOutlet UITextField *txtOpeningKm;
    IBOutlet UITextField *txtEndTime;
    IBOutlet UITextField *txtStartTiime;
    IBOutlet UITextField *txtEndLocation;
    IBOutlet UITextField *txtStartLocation;
    IBOutlet UITextField *txtVehiclType;
    IBOutlet UIScrollView *ScrolView;
    NSString *currentDate;
    IBOutlet UIButton *btnSave;
    NSArray *arryList;
    IBOutlet UILabel *lblDate;
    IBOutlet UITableView *tableStatus;
    IBOutlet UIImageView *imgArrow;
    BOOL infoTap;
    NSString *stausSelected;
    NSUserDefaults *def;
    NSMutableDictionary *driverDict;
    NSString *driverId,*timetapped;
    IBOutlet UIView *shadowView;
    IBOutlet UIDatePicker *dataPicker;
    IBOutlet UIView *dataPickerView;
    NSString *SelectdDate,*companyID;
    BOOL isCompanyShow;
    UIView *bgView;
    UITableView *table;
    NSMutableArray *companyArray;
    IBOutlet UILabel *lbl_company;
}
@property (weak, nonatomic) IBOutlet UIButton *companyName;




@end
