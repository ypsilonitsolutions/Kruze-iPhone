//
//  Sugest_RoutVC.h
//  Journe_Driver
//
//  Created by admin on 12/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Constant.h"

@interface Sugest_RoutVC : UIViewController
{

    NSUserDefaults *def;
    BOOL shouldProceed;
    MBProgressHUD *HUD;
    IBOutlet UITextField *txtTimes;
    IBOutlet UITextField *ToTime;
    IBOutlet UITextField *FromTime;
    IBOutlet UIView *shadowView;
    IBOutlet UIDatePicker *dataPicker;
    IBOutlet UIView *dataPickerView;
    NSString *SelectdDate;
    NSString *tap;
    
    IBOutlet UIScrollView *Scrollview;
}

@end
