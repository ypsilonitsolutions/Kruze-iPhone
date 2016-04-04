//
//  BookCarVC.h
//  Journe_Driver
//
//  Created by admin on 18/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface BookCarVC : UIViewController<UITextViewDelegate,UIAlertViewDelegate>
{
    
    NSString *currentDate,*User_Id,*Typeselected,*carImageA,*busImageA,*PlaneImageA,*carImageI,*busImageI,*PlaneImageI;
    IBOutlet UIView *shadowView;
    IBOutlet UIDatePicker *dataPicker;
    IBOutlet UIView *dataPickerView;
    int tag;
    IBOutlet UITextField *txtTo;
    IBOutlet UITextField *txtFrom;
    IBOutlet UITextField *txtDate;
    IBOutlet UITextView *txtvMesage;
    MBProgressHUD *HUD;
    NSUserDefaults *def;
    IBOutlet UIButton *btnCar;
    IBOutlet UIButton *btnBus;
    IBOutlet UIButton *btnPlane;
    NSString *planeSelection;
    
    
}
@end
