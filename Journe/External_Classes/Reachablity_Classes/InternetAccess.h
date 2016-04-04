//
//  InternetAccess.h
//  Hopin
//
//  Created by Mahesh Dhakad on 26/12/14.
//  Copyright (c) 2014 Mahesh Dhakad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface InternetAccess : NSObject
{
    Reachability* wifiReach ;
    NetworkStatus netStatus;
}
-(int) checkInternet;
@end
