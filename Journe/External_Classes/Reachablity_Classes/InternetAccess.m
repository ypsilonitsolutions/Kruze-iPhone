//
//  InternetAccess.m
//  Hopin
//
//  Created by Mahesh Dhakad on 26/12/14.
//  Copyright (c) 2014 Mahesh Dhakad. All rights reserved.
//

#import "InternetAccess.h"

static int flag=0;

@implementation InternetAccess

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(int) checkInternet
{
    flag=0;
    wifiReach = [Reachability reachabilityWithHostName: @"www.google.com"];
    netStatus = [wifiReach currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable:
        {
            NSLog(@"Access Not Available");
            // UIAlertView
            flag=0;
            break;
        }
            
        case ReachableViaWWAN:
        {
            flag=1;
            NSLog(@"Reachable WWAN");
            break;
        }
        case ReachableViaWiFi:
        {
            flag=1;
            NSLog(@"Reachable WiFi");
            break;
        }
            
    }

        return flag;
    
}
@end
