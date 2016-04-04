//
//  Kruze_PlayVC.h
//  Journe_Driver
//
//  Created by admin on 03/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface Kruze_PlayVC : UIViewController<UIAlertViewDelegate>
{
    IBOutlet UIButton *btnMusic;
    IBOutlet UIButton *btnSong;
    IBOutlet UIButton *btnyoutube;
    IBOutlet UIButton *btnEbook;
    IBOutlet UIButton *btnNews;
    NSString *imgActive,*imgInactive;
    BOOL tapMusic,tapsong,tapebook,tapnews,tapYoutube;
}
@end
