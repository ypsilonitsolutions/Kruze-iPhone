//
//  VerifyOtpVC.m
//  Journe
//
//  Created by admin on 20/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "VerifyOtpVC.h"

@interface VerifyOtpVC ()

@end

@implementation VerifyOtpVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"VerifyOtpVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"VerifyOtpVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"VerifyOtpVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"VerifyOtpVC_6plus";
            
        }
    }
    else
    {
        nibName=@"VerifyOtpVC_ipad";
        
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
    [self setting_view];
}
#pragma mark- SettingView_methods
#pragma mark-
-(void)setting_view
{
    btnResend.layer.borderWidth=1;
    btnResend.clipsToBounds = YES;
    btnResend.layer.cornerRadius = btnResend.frame.size.height/2.0f;
    btnResend.layer.borderColor=sky_blue_color;
    btnSubmit.clipsToBounds = YES;
    btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2.0f;
    btnSubmit.layer.borderWidth=1;
    btnSubmit.layer.borderColor=sky_blue_color;
    
    txtOtp.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Enter OTP" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    nsud=[NSUserDefaults standardUserDefaults];
    Mobile_No=[nsud objectForKey:@"MobileNumber"];
    lbl_number.text=[NSString stringWithFormat:@"+91%@",Mobile_No];
       
}


#pragma mark- Submit_OTP_methods
#pragma mark-
-(IBAction)goto_Submit:(id)sender
{
    
    if ([self otp_Validation])
    {
        
        [self call_OTP_verify_API];
    }
    
}

-(void)call_OTP_verify_API
{
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?passenger_mobile=%@&passenger_verification_code=%@",OTP_verification_Url,Mobile_No,txtOtp.text];
    
    WebService *api = [WebService alloc];
    
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
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

-(BOOL)otp_Validation
{
    
    BOOL isValid = false;
    
    if (txtOtp.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Otp" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else
    {
        
        
        isValid = true;
    }
    
    return isValid;
}
#pragma mark - AlertView_Delegate Method
#pragma mark -
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
          
            DashboardVC *Cp = [[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
            InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
            
            objISVC.topViewController = Cp;
            
            
            [self.navigationController pushViewController:objISVC animated:YES];
            
            
            
            
        }
    }
    
    
    
    
    
}

#pragma mark- Back_methods
#pragma mark-
-(IBAction)Back:(id)sender
{
    
    SignUpVc *nav = [[SignUpVc alloc]initWithNibName:@"SignUpVc" bundle:nil];
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
    [UIView setAnimationDuration:0.75];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    [self.navigationController pushViewController:nav animated:YES];
    
    
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
