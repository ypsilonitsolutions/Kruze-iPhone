//
//  Dvr_HelpVC.h
//  Journe_Driver
//
//  Created by admin on 05/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface Dvr_HelpVC : UIViewController<UITextViewDelegate>
{
    
    IBOutlet UITextView *tvDescription;
    
    IBOutlet UIView *bgView;
    
    NSUserDefaults *def;
    
    NSMutableDictionary *driverDict;
    
    NSString *driverID;
    
}

@end
