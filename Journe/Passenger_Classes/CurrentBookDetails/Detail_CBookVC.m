//
//  Detail_CBookVC.m
//  Journe_Driver
//
//  Created by admin on 24/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "Detail_CBookVC.h"

@interface Detail_CBookVC ()

@end

@implementation Detail_CBookVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Detail_CBookVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Detail_CBookVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Detail_CBookVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Detail_CBookVC_6plus";
            
        }
    }
    else
    {
        nibName=@"Detail_CBookVC_ipad";
        
    }
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
     def=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
    lblBusnumber.layer.cornerRadius = lblBusnumber.frame.size.height/2;
    lblBusnumber.layer.borderWidth = 1;
lblBusnumber.layer.borderColor = [UIColor whiteColor].CGColor;
   
    NSMutableDictionary *dict=[def objectForKey:@"detailDict"];
    lblBookingId.text=[dict valueForKey:@"b_id"];
    bId=[dict valueForKey:@"b_id"];
    lblBusnumber.text=[dict valueForKey:@"bus_no"];
    lblDestinationAdd.text=[dict valueForKey:@"destination"];
    lblDetinationTime.text=[dict valueForKey:@"destination_time"];
    lblSeatNo.text=[NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"seats"],[dict valueForKey:@"ac_type"]];
    lblSourceAdd.text=[dict valueForKey:@"source"];
    lblSourceTime.text=[dict valueForKey:@"source_time"];
    lblTotalCost.text=[NSString stringWithFormat:@"Rs %@.00",[dict valueForKey:@"price"]];
    btntrackride.enabled=true;
    [btntrackride setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSString *status=[dict valueForKey:@"status"];
    if ([status isEqualToString:@"Booked"])
    {
        btnCancel.hidden=false;
        imgCancel.hidden=false;
       
       
         
    }
  else  if ([status isEqualToString:@"Boarded"])
    {
        btnCancel.hidden=true;
        imgCancel.hidden=true;
        
    }
   
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- ProgressBar_methods
#pragma mark-
-(void)add_progress_view
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Processing...";
    HUD.square = YES;
    [HUD show:YES];
    
    
}
#pragma  mark - TrackRide
#pragma  mark -

-(IBAction)actionTrackRide:(id)sender
{
   [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?&b_id=%@",TrackRide_Url,bId];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             [def setObject:bId forKey:@"bookingID"];
             YourRideVC *Cp = [[YourRideVC alloc] initWithNibName:@"YourRideVC" bundle:nil];
             [self.navigationController pushViewController:Cp animated:YES];

             
         }
         else
         {
             
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
             
         }
  
     }];
  
}

#pragma mark -textViewDelegate
#pragma mark -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Reason.."]) {
        textView.text = @"";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Reason..";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}




#pragma  mark - CancelBookingMethods
#pragma  mark -
-(IBAction)cancelBooking:(id)sender
{
    
    
    shadow.hidden=false;
    
    
}


-(IBAction)cancelBookingbtnPressed:(id)sender
{
    if ([txtView.text isEqualToString:@""])
    {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please enter reason.." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
        return;
    }
    else
    {
    
    [self cacelbookingsapi];
    }
}


-(void)cacelbookingsapi
{
    
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?passenger_id=%@&b_id=%@&reason=%@",CancelBookings_Url,User_Id,bId,txtView.text];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             shadow.hidden=true;
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             a.tag=1;
             
         }
         else
             
         {
             
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
             
         }
         
         
         
         
     }];
    
  
    
    
    
}

#pragma  mark - CancelBooking
#pragma  mark -
-(IBAction)hideBookingshadow:(id)sender
{
    
    
    shadow.hidden=true;
    
    
}

#pragma  mark - MenuMethods
#pragma  mark -
-(IBAction)actionMenu:(id)sender
{
   [self.navigationController popViewControllerAnimated:true];
    
}
#pragma mark - AlertView_Delegate Method
#pragma mark -
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            
            Current_BookVC *Cp = [[Current_BookVC alloc] initWithNibName:@"Current_BookVC" bundle:nil];
            InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
            
            objISVC.topViewController = Cp;
            
            
            [self.navigationController pushViewController:objISVC animated:YES];
          
            
           
            
            
            
            
        }
    }
    
    
    
    
    
    
    
}



@end
