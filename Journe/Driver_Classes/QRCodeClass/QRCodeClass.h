//
//  QRCodeClass.h
//  Journe
//
//  Created by admin on 11/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Constant.h"
#import "QRCodeCustomerCell.h"
#import "QRCheckSeatCell.h"

@interface QRCodeClass : UIViewController<AVCaptureMetadataOutputObjectsDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    NSMutableArray *customersArray,*passengerArray,*seatsArray,*verifidUsers,*absentUsers,*mainArray;
   IBOutlet UIView *_highlightView;
    NSString *_label,*cell_nib,*seat_cell_nib;
    NSUserDefaults *def;
    IBOutlet UIButton *BtnProceed;
    int absentCount,verifiedCount;
    NSUInteger verfyingIndex;
    MBProgressHUD *HUD;
    BOOL isBackgroundHidden;
    IBOutlet UIView *verifyBgView;
    IBOutlet UIView *verifyInnerView;
    IBOutlet UITextField *txtPassengerNumber;
    IBOutlet UIButton *BtnVerfyUserNumber;
    NSString *passenger_mobile;
    IBOutlet UITableView *seatsTable;
    IBOutlet UILabel *lblTicketPassengerName;
    IBOutlet UIButton *seatCheckDoneBtn;
    NSMutableDictionary *dict,*dict1;
    IBOutlet UIView *seatCheckBgView;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
