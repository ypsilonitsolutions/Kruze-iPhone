//
//  SerachRouteCell.m
//  Journe
//
//  Created by admin on 25/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "SerachRouteCell.h"

@implementation SerachRouteCell
@synthesize lbl_bg,lbl_busNo;

- (void)awakeFromNib
{
    lbl_bg.layer.cornerRadius=3;
    lbl_bg.layer.masksToBounds=YES;
    lbl_busNo.clipsToBounds = YES;
    lbl_busNo.layer.cornerRadius = lbl_busNo.frame.size.height/2.0f;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
