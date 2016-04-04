//
//  SerachRouteCell.h
//  Journe
//
//  Created by admin on 25/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SerachRouteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_bg;



@property (weak, nonatomic) IBOutlet UIButton *btn_book;


@property (weak, nonatomic) IBOutlet UILabel *lbl_source;

@property (weak, nonatomic) IBOutlet UILabel *lbl_desti;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Stiming;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Dtiming;
@property (weak, nonatomic) IBOutlet UILabel *lbl_cost;
@property (weak, nonatomic) IBOutlet UILabel *lbl_busNo;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Seat;
@property (weak, nonatomic) IBOutlet UILabel *lbl_busStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbl_via;
@property (weak, nonatomic) IBOutlet UILabel *lbl_busType;
@end
