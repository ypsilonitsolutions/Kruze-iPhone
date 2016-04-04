//
//  ExpenseListCell.h
//  Journe
//
//  Created by admin on 05/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblExpenseTitle;


@property (weak, nonatomic) IBOutlet UILabel *lblExpSubtitle;

@property (weak, nonatomic) IBOutlet UILabel *lblExpAmount;

@end
