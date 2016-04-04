//
//  Dashboard_cell.m
//  Journe
//
//  Created by admin on 21/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "Dashboard_cell.h"

@implementation Dashboard_cell
@synthesize btn_reach;
- (void)awakeFromNib
{
    btn_reach.layer.cornerRadius=8;
    btn_reach.layer.masksToBounds=YES;
    btn_reach.layer.borderColor=[[UIColor greenColor]CGColor];
    btn_reach.layer.borderWidth=1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
