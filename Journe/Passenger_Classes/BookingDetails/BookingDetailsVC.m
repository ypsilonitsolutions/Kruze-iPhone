//
//  BookingDetailsVC.m
//  Journe
//
//  Created by admin on 06/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "BookingDetailsVC.h"

@interface BookingDetailsVC ()

@end

@implementation BookingDetailsVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"BookingDetailsVC";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"BookingDetailsVC_4";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"BookingDetailsVC_6";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"BookingDetailsVC_6plus";
            
            
        }
    }
    else
    {
        nibName=@"BookingDetailsVC_ipad";
        
        
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
    lblBusNo.layer.borderWidth=1;
    lblBusNo.clipsToBounds = YES;
    lblBusNo.layer.cornerRadius=lblBusNo.frame.size.height/2.0f;
    lblBusNo.layer.borderColor=sky_blue_color;
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    userID=[userDict valueForKey:@"passenger_id"];
    NSMutableDictionary *d1=[def objectForKey:@"StopDict"];
    lblBusNo.text=[d1 valueForKey:@"bus_no"];
    lblSeatCost.text=[NSString stringWithFormat:@"Rs.%@.00",[def objectForKey:@"seatCost"]];
    lblRideFare.text=[NSString stringWithFormat:@"TotalCost:%@.00 Rs",[def objectForKey:@"FinalseatPrice"]];
    NSArray *arr=[def  objectForKey:@"seatIdArray"];
    lblSeatId.text=[NSString stringWithFormat:@"%@",[arr componentsJoinedByString:@","]];
    selectedSeatCount=[arr count];
    lblBusType.text=[d1 valueForKey:@"ac_type"];
   lblSource.text=[def objectForKey:@"SourceStopName"];
   lblDesti.text =[def objectForKey:@"DestiStopName"];
    lbl_SourceTime.text=[def objectForKey:@"SourceStopTime"];
    lbl_DestiTime.text=[def objectForKey:@"DestiStopTime"];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Back_view_methods
#pragma mark -
-(IBAction)go_back:(id)sender
{
    
    
   
[self.navigationController popViewControllerAnimated:TRUE];
    
    
}
#pragma  mark - Home_methods
#pragma mark -
- (IBAction)gohome:(id)sender
{
    DashboardVC *Cp = [[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}
#pragma  mark - Back_view_methods
#pragma mark -
-(IBAction)bookSeat:(id)sender
{
    [self freeRideCheck];
    
}

#pragma  mark - FreeRideCheck_methods
#pragma mark -
-(void)freeRideCheck
{
    NSString *str=[def objectForKey:@"FreeRides"];
    freeRides=[str intValue];
    if (freeRides==0)
    {
        rideSubmit=str;
        finaSeatPrice=[def objectForKey:@"FinalseatPrice"];
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"You have no free rides availabel for now" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
        a.tag=1;
        
    }
   else
   {
       if (freeRides>selectedSeatCount)
       {
        finaSeatPrice=@"0";
        rideSubmit=[NSString stringWithFormat:@"%d",selectedSeatCount];
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[NSString stringWithFormat:@"You have %d free rides availabel now amount to be paid is Rs.0.00",freeRides] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
           [a show];
            a.tag=1;
       }
       else
       {
        
           int remaintSeatCount=selectedSeatCount-freeRides;
           rideSubmit=str;
           NSString *p=[def objectForKey:@"seatCost"];
           int perCost=[p intValue];
           int finalP=perCost*remaintSeatCount;
           finaSeatPrice=[NSString stringWithFormat:@"%d",finalP];
           UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[NSString stringWithFormat:@"You have %d free rides availabel now amount to be paid is Rs.%@.00",freeRides,finaSeatPrice] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
           [a show];
           a.tag=1;
    
       }
       

       
   }
    
}
#pragma mark- ConfirmBookingMethods
#pragma mark-
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            [self finalConfirmPressed];
        }
    }
}

#pragma mark- ConfirmBookingMethods
#pragma mark-
-(void)finalConfirmPressed
{
    
    NSMutableDictionary *d1=[def objectForKey:@"StopDict"];
    [self add_progress_view];
    NSString *str=[NSString stringWithFormat:@"%@?passenger_id=%@&trip_id=%@&bus_id=%@&from_stop=%@&to_stop=%@&amount=%@&seats=%@&payment_type=%@&payment_status=%@&free_rides=%@",BookSeat_Url,userID,[d1 valueForKey:@"trip_id"],[def objectForKey:@"BusId"],[def objectForKey:@"SourceStopId"],[def objectForKey:@"DestiStopId"],finaSeatPrice,lblSeatId.text,@"1",@"2",rideSubmit];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             [def setObject:[response valueForKey:@"b_id"] forKey:@"BookingId"];
             DoneBookingVC *detailBook = [[DoneBookingVC alloc]initWithNibName:@"DoneBookingVC" bundle:nil];
             [self.navigationController pushViewController:detailBook animated:YES];
             
         }
         else
             
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
         }
         
     }];

}
#pragma mark- ProgressViewMethods
#pragma mark-
-(void)add_progress_view
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Processing...";
    HUD.square = YES;
    [HUD show:YES];
    
    
}
@end
