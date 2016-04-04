//
//  BookCarVC.m
//  Journe_Driver
//
//  Created by admin on 18/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "BookCarVC.h"

@interface BookCarVC ()

@end

@implementation BookCarVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"BookCarVC";
            carImageA=@"car_active";
            carImageI=@"car_inactive";
            busImageA=@"bus_active";
            busImageI=@"bus_inactive";
            PlaneImageA=@"plane_active";
            PlaneImageI=@"plane_inactive";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"BookCarVC_4";
            carImageA=@"car_active";
            carImageI=@"car_inactive";
            busImageA=@"bus_active";
            busImageI=@"bus_inactive";
            PlaneImageA=@"plane_active";
            PlaneImageI=@"plane_inactive";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"BookCarVC_6";
            carImageA=@"car_active";
            carImageI=@"car_inactive";
            busImageA=@"bus_active";
            busImageI=@"bus_inactive";
            PlaneImageA=@"plane_active";
            PlaneImageI=@"plane_inactive";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"BookCarVC_6plus";
            carImageA=@"car_active";
            carImageI=@"car_inactive";
            busImageA=@"bus_active";
            busImageI=@"bus_inactive";
            PlaneImageA=@"plane_active";
            PlaneImageI=@"plane_inactive";
            
        }
    }
    else
    {
        nibName=@"BookCarVC_ipad";
        carImageA=@"car_active_i";
        carImageI=@"car_inactive_i";
        busImageA=@"bus_active_i";
        busImageI=@"bus_inactive_i";
        PlaneImageA=@"plane_active_i";
        PlaneImageI=@"plane_inactive_i";
        
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
    Typeselected=@"";
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
    [self SettingView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated

{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    
    
}
-(IBAction)actionBack:(id)sender
{
    
    [self.slidingViewController anchorTopViewTo:ECRight];
    [self.view endEditing:true];
    
}
#pragma  mark - SettingView_methods
#pragma mark -
-(void)SettingView
{
    txtvMesage.layer.cornerRadius = 3;
    txtvMesage.layer.borderWidth = 1;
    txtvMesage.layer.borderColor = [UIColor  colorWithRed:0.149 green:0.663 blue:0.878 alpha:1].CGColor ;
}

#pragma  mark - SubmitMethods
#pragma mark -
-(IBAction)actionSubmit:(id)sender
{
    
    
    if ([self Submit_Validation])
    {
        
        [self call_Submit_API];
    }
    
    
    
    
}

-(void)call_Submit_API
{

    [self add_progress_view];
    NSString *str=[NSString stringWithFormat:@"%@?passenger_id=%@&source=%@&destination=%@&date=%@&message=%@&vechicle_type=%@",BookAcar_Url,User_Id,txtTo.text,txtFrom.text,txtDate.text,txtvMesage.text,Typeselected];
    WebService *api = [WebService alloc];
    
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             txtTo.text=@"";
             txtFrom.text=@"";
             txtDate.text=@"";
             txtvMesage.text=@"";
             Typeselected=@"";
             [btnCar setImage:[UIImage imageNamed:carImageI] forState:UIControlStateNormal];
             [btnBus setImage:[UIImage imageNamed:busImageI] forState:UIControlStateNormal];
             [btnPlane setImage:[UIImage imageNamed:PlaneImageI] forState:UIControlStateNormal];
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
#pragma mark - AlertView_Delegate Method
#pragma mark -
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    if (alertView.tag==1)
    {
        
        
        DashboardVC *Cp = [[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
        InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        
        objISVC.topViewController = Cp;
        
        
        [self.navigationController pushViewController:objISVC animated:YES];
        
        
        
        
        
    }
    
    
}


-(BOOL)Submit_Validation
{
    
    BOOL isValid = false;
    if (txtTo.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Source" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    
    else if (txtFrom.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Destination." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    
    else if (txtDate.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Select Date" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else if ([Typeselected isEqualToString:@""])
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Select Vehicle Type" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else if (txtvMesage.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }else
    {
        
        isValid = true;
    }
    
    return isValid;
}

#pragma mark-
-(void)add_progress_view
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Processing...";
    HUD.square = YES;
    [HUD show:YES];
    
    
}

#pragma mark - picker_methods
#pragma mark -

-(IBAction)actionDate:(id)sender
{
    [self.view endEditing:true];
    [shadowView setHidden:false];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    [dataPicker setDate:[NSDate date]];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDat = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDat options:0];
    [comps setYear:0];
    
    [dataPicker setMinimumDate:maxDate];
    
    
    [UIView animateWithDuration:0.2f animations:^{
        dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,self.view.frame.size.height-dataPickerView.frame.size.height,dataPickerView.frame.size.width,dataPickerView.frame.size.height);
    }];}


- (IBAction)dateSelected:(id)sender
{
    [self.view endEditing:true];
    CGRect screenSize=[[UIScreen mainScreen]bounds];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd-MM-YYYY"];
    currentDate=[format stringFromDate:dataPicker.date];
    txtDate.text=[format stringFromDate:dataPicker.date];
    [dataPicker reloadInputViews];
    [UIView animateWithDuration:0.2f animations:^{
        
        if(screenSize.size.height<=1024)
            
        {
            
            dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,300, dataPickerView.frame.size.width,dataPickerView.frame.size.height);
            
        }
        else
        {
            
            dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,300, dataPickerView.frame.size.width,dataPickerView.frame.size.height);
        }
        
        
    }];
    [shadowView setHidden:true];
    
}
-(IBAction)cancelShadow:(id)sender{
    
    CGRect screenSize=[[UIScreen mainScreen]bounds];
    [UIView animateWithDuration:0.2f animations:^{
        if(screenSize.size.height<=1024)
            
        {
            
            dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,1024, dataPickerView.frame.size.width,dataPickerView.frame.size.height);
            
        }
        else
        {
            
            dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,600, dataPickerView.frame.size.width,dataPickerView.frame.size.height);
        }
        
        
    }];
    
    
    [shadowView setHidden:true];
    
}

#pragma mark -textViewDelegate
#pragma mark -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
  
    if ([textView.text isEqualToString:@"Message"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Message";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}



#pragma mark - TypeSelection_methods
#pragma mark -

-(IBAction)carSelected:(id)sender
{
  Typeselected=@"Car";
[btnCar setImage:[UIImage imageNamed:carImageA] forState:UIControlStateNormal];
    [btnBus setImage:[UIImage imageNamed:busImageI] forState:UIControlStateNormal];
    [btnPlane setImage:[UIImage imageNamed:PlaneImageI] forState:UIControlStateNormal];
    
    
    
  
}
-(IBAction)busSelected:(id)sender
{

   Typeselected=@"Bus";
    [btnCar setImage:[UIImage imageNamed:carImageI] forState:UIControlStateNormal];
    [btnBus setImage:[UIImage imageNamed:busImageA] forState:UIControlStateNormal];
    [btnPlane setImage:[UIImage imageNamed:PlaneImageI] forState:UIControlStateNormal];
    
    
    
    
}
-(IBAction)planeSelected:(id)sender
{
    planeSelection=[def objectForKey:@"planepoint"];
    if (planeSelection==nil)
    {
        Typeselected=@"";
        [btnCar setImage:[UIImage imageNamed:carImageI] forState:UIControlStateNormal];
        [btnBus setImage:[UIImage imageNamed:busImageI] forState:UIControlStateNormal];
        [btnPlane setImage:[UIImage imageNamed:PlaneImageA] forState:UIControlStateNormal];
        [self add_progress_view];
        
        NSString *str=[NSString stringWithFormat:@"%@?passenger_id=%@",BookPlane_Url,User_Id];
        WebService *api = [WebService alloc];
        
        [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
         {
             [HUD hide:true];
             if ([[response objectForKey:@"status"] isEqualToString:@"true"])
             {
            UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [a show];
            [def setObject:@"Set" forKey:@"planepoint"];
            btnPlane.enabled=false;
            [btnPlane setImage:[UIImage imageNamed:PlaneImageI] forState:UIControlStateNormal];
                 
             }
             else
                 
             {
                 UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [a show];
                 
             }
             
         }];
        
    }
    else
    {
        
        
        btnPlane.enabled=false;
        [btnPlane setImage:[UIImage imageNamed:PlaneImageI] forState:UIControlStateNormal];
        
        
        
    }
    
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
