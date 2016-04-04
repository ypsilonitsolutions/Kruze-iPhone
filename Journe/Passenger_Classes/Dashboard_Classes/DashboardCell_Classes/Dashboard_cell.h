//
//  Dashboard_cell.h
//  Journe
//
//  Created by admin on 21/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dashboard_cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_location;
@property (weak, nonatomic) IBOutlet UILabel *lbl_location_name;
@property (weak, nonatomic) IBOutlet UIButton *btn_reach;
@end
