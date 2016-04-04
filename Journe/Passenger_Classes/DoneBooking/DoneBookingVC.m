//
//  DoneBookingVC.m
//  Journe
//
//  Created by admin on 26/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "DoneBookingVC.h"

@interface DoneBookingVC ()

@end

@implementation DoneBookingVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"DoneBookingVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"DoneBookingVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"DoneBookingVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"DoneBookingVC_6plus";
            
        }
    }
    else
    {
        nibName=@"DoneBookingVC_ipad";
        
    }
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    def=[NSUserDefaults standardUserDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - MonthlyPass
#pragma  mark -
-(IBAction)monthlyPass:(id)sender
{
    
    
    
    
}
#pragma  mark - returnJourney
#pragma  mark -
-(IBAction)returnJourney:(id)sender
{
    NSString *desti=[def objectForKey:@"landmarkSource"];
    NSString *source=[def objectForKey:@"landmarkDesti"];    
    [def setObject:source forKey:@"searchTxt1"];
    [ def setObject:desti forKey:@"searchTxt2"];
//   [def setObject:@"" forKey:@"RouteID"];
//  [def setObject:@"2" forKey:@"SearchType"];
//    [def setObject:desti forKey:@"DestinationText"];
//    [def setObject:source forKey:@"SourceText"];
    
    [def setObject:@"return" forKey:@"ReturnSearch"];
    
    
    
    [def synchronize];
    SearchRouteVC *nav = [[SearchRouteVC alloc]initWithNibName:@"SearchRouteVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    objISVC.topViewController = nav;
    [self.navigationController pushViewController:objISVC animated:YES];
    
   
}


#pragma  mark - returnJourney
#pragma  mark -
-(IBAction)contactUs:(id)sender
{
   
    ContactVC *nav = [[ContactVC alloc]initWithNibName:@"ContactVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    objISVC.topViewController = nav;
    [self.navigationController pushViewController:objISVC animated:YES];
    
    
}
#pragma  mark - NotNow
#pragma  mark -
-(IBAction)notNow:(id)sender
{
    
    Current_BookVC *nav = [[Current_BookVC alloc]initWithNibName:@"Current_BookVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    objISVC.topViewController = nav;
    [self.navigationController pushViewController:objISVC animated:YES];
    
    
}

@end
