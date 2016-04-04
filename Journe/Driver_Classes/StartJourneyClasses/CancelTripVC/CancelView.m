//
//  CancelView.m
//  Journe
//
//  Created by admin on 30/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "CancelView.h"

@implementation CancelView

+ (id)cancelViewSet
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"CancelView";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"CancelView_4";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"CancelView_6";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"CancelView_6plus";
        }
    }
    else
    {
        nibName=@"CancelView_ipad";
    }
    CancelView *cv = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
    if ([cv isKindOfClass:[CancelView class]])
        return cv;
    else
        return nil;
}

@end
