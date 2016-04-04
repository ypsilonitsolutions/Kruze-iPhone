//
//  HistoryTVCell.h
//  Journe_Driver
//
//  Created by admin on 24/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface  CurrentCell: UITableViewCell
@property(weak, nonatomic) IBOutlet UITextField *txtSourceAdd;
@property(weak, nonatomic)IBOutlet UITextField *txtDestinationAdd;
 @property(weak, nonatomic) IBOutlet UILabel *lblSourceTime;
@property(weak, nonatomic) IBOutlet UILabel *lblDestinationTime;
@property(weak, nonatomic) IBOutlet UILabel *lblBusnumber;

@property (weak, nonatomic) IBOutlet UILabel *lblCancelled;

@property(weak, nonatomic) IBOutlet UIView *vwShow;
@property(weak, nonatomic) IBOutlet UILabel *lbl_date;
@end
