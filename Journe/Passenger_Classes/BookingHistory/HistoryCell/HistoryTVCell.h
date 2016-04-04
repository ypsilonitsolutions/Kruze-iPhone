//
//  HistoryTVCell.h
//  Journe_Driver
//
//  Created by admin on 24/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface HistoryTVCell : UITableViewCell
@property(weak, nonatomic) IBOutlet UILabel *LblSourceAdd;
@property(weak, nonatomic)IBOutlet UILabel *LblDestinationAdd;
 @property(weak, nonatomic) IBOutlet UILabel *lblSourceTime;
@property(weak, nonatomic) IBOutlet UILabel *lblDestinationTime;
@property(weak, nonatomic) IBOutlet UILabel *lblBusnumber;

@property (weak, nonatomic) IBOutlet UILabel *lblCancelled;
@property(weak, nonatomic) IBOutlet UILabel *lbl_date;
@end
