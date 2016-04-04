//
//  ThankYouVC.h
//  Journe_Driver
//
//  Created by admin on 12/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThankYouVC.h"
#import "Constant.h"

@interface ThankYouVC : UIViewController
{
    IBOutlet UITextField *txtSource;
    IBOutlet UITextField *txtDestination;
    NSUserDefaults *def;
}
@end
