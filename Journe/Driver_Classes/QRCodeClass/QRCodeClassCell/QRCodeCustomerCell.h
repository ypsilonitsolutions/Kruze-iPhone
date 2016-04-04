//
//  QRCodeCustomerCell.h
//  Journe
//
//  Created by admin on 11/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeCustomerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *QR_Code;
@property (weak, nonatomic) IBOutlet UIImageView *verify_Image;
@property (weak, nonatomic) IBOutlet UILabel *lbl_qrcode;
@property (weak, nonatomic) IBOutlet UILabel *ticket_number;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDestination;
@property (weak, nonatomic) IBOutlet UILabel *lblSource;
@end
