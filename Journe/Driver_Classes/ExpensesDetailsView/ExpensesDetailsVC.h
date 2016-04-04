//
//  ExpensesDetailsView.h
//  Journe
//
//  Created by admin on 10/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface ExpensesDetailsVC : UIViewController
{
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *lblExpense;
    IBOutlet UILabel *lblDate;
    IBOutlet UILabel *lblKm;
    IBOutlet UILabel *lblCost;
    IBOutlet UIView *ImagebackGroundView;
    NSUserDefaults *def;
    IBOutlet UITextView *txtDesc;
    IBOutlet UILabel *today;
}
@end
