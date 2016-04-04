//
//  DriverDashVC.m
//  paytm
//
//  Created by admin on 27/01/16.
//  Copyright (c) 2016 admin. All rights reserved.
//

#import "DriverDashVC.h"
#import "Constant.h"

@interface DriverDashVC ()

@end

@implementation DriverDashVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"DriverDashVC_5";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"DriverDashVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"DriverDashVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"DriverDashVC_6plus";
            
        }
    }
    else
    {
        nibName=@"DriverDashVC_ipad";
        
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
    nsud=[NSUserDefaults standardUserDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- MenuButtons_methods
#pragma mark-
-(IBAction)actionStartJrn:(id)sender
{
    StartJourne *startJourny = [[StartJourne alloc]initWithNibName:@"StartJourne" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:YES];
}

-(IBAction)actionCash:(id)sender
{
  
    Dvr_CashVC *startJourny = [[Dvr_CashVC alloc]initWithNibName:@"Dvr_CashVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:YES];
    
}

-(IBAction)actionFuel:(id)sender
{
    
    
    Dvr_Expense_ListVC *startJourny = [[Dvr_Expense_ListVC alloc]initWithNibName:@"Dvr_Expense_ListVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:YES];
    
    
}

-(IBAction)actionKm:(id)sender
{
    
    
    Dvr_Daily_ListVC *startJourny = [[Dvr_Daily_ListVC alloc]initWithNibName:@"Dvr_Daily_ListVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:YES];
    
    
}

-(IBAction)actionHelp:(id)sender
{
    
    
    Dvr_HelpVC *startJourny = [[Dvr_HelpVC alloc]initWithNibName:@"Dvr_HelpVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:YES];
    
    
}

-(IBAction)actionLogout:(id)sender
{
    
    
    
    
    UIAlertView *v1 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to Logout?" delegate:self cancelButtonTitle:@"Logout" otherButtonTitles:@"Cancel",nil];
    v1.tag=1;
    [v1 show];
    
    
    
    
}

-(IBAction)actionLocation:(id)sender
{
    
    
    
    
   
}


# pragma mark -CallSaveAPI
# pragma mark -
-(void)logout_api
{
    
   NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
   NSDictionary *driverDict=[def objectForKey:@"LoginDriverDict"];
   NSString *DriverId=[driverDict valueForKey:@"driver_id"];
   NSString *str = [NSString stringWithFormat:@"%@?driver_id=%@",driver_logout_API,DriverId];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             [nsud removeObjectForKey:@"LoginDriverDict"];
             [nsud removeObjectForKey:@"UserType"];
             Dvr_LoginVC *Cp = [[Dvr_LoginVC alloc] initWithNibName:@"Dvr_LoginVC" bundle:nil];
             
             [self.navigationController pushViewController:Cp animated:YES];
         }
         else
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Kruze" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
     }];
}

#pragma mark- AlerDelegate_methods
#pragma mark-
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            [self logout_api];
        }
        else
        {
            return;
        }
    }
}

@end
