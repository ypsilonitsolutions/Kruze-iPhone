//
//  HistoryTVCell.m
//  Journe_Driver
//
//  Created by admin on 24/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "CurrentCell.h"
#import "Constant.h"
@implementation CurrentCell

- (void)awakeFromNib {
    // Initialization code
    _lblBusnumber.layer.cornerRadius = _lblBusnumber.frame.size.height/2;
    _lblBusnumber.layer.borderWidth = 2;
    _lblBusnumber.layer.borderColor = [UIColor whiteColor].CGColor;
    _vwShow.layer.cornerRadius = 4;
    
    UIColor *color = [UIColor whiteColor];
    
    _txtSourceAdd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Sun City, Selector 54, Gurgaon" attributes:@{NSForegroundColorAttributeName: color}];
    
     _txtDestinationAdd.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Vatika City Point" attributes:@{NSForegroundColorAttributeName: color}];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
