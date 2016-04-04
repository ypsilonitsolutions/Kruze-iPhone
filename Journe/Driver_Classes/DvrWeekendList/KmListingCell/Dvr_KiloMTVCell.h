//
//  Dvr_KiloMTVCell.h
//  Journe_Driver
//
//  Created by admin on 16/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dvr_KiloMTVCell : UITableViewCell{

}


@property (weak,nonatomic) IBOutlet UILabel *lblClosingKm;
@property (weak,nonatomic) IBOutlet UILabel *lblOpeningKm;
@property (weak,nonatomic) IBOutlet UILabel *lblEndTime;
@property (weak,nonatomic) IBOutlet UILabel *lblStartTiime;
@property (weak,nonatomic) IBOutlet UILabel *lblEndLocation;
@property (weak,nonatomic) IBOutlet UILabel *lblStartLocation;

    @end
