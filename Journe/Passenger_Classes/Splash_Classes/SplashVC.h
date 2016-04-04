//
//  SplashVC.h
//  Journe
//
//  Created by admin on 22/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface SplashVC : UIViewController
{
    int i;
    NSString *SplashImage;
    NSUserDefaults *def;
    IBOutlet UIButton *btnRetry;
    
    IBOutlet UIImageView *AnimatedSplash;
}


@end
