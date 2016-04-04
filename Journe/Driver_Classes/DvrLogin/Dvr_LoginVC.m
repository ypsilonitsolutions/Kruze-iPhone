//
//  LoginVC.m
//  Journe
//
//  Created by admin on 19/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "Dvr_LoginVC.h"

@interface Dvr_LoginVC ()

@end

@implementation Dvr_LoginVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Dvr_LoginVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Dvr_LoginVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Dvr_LoginVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Dvr_LoginVC_6plus";
            
        }
    }
    else
    {
        nibName=@"Dvr_LoginVC_ipad";
        
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
    // Do any additional setup after loading the view from its nib.
    [self setting_view];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    
    scrollView.contentSize=CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height+180);
}
#pragma mark- SettingView_methods
#pragma mark-
-(void)setting_view
{
    nsud=[NSUserDefaults standardUserDefaults];
   

    btnLogin.layer.borderWidth=1;
    btnLogin.clipsToBounds = YES;
    btnLogin.layer.cornerRadius = btnLogin.frame.size.height/2.0f;
    btnLogin.layer.borderColor=sky_blue_color;
    
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtPwd.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    usertype=@"driver";
    
}

#pragma mark- SignInButton_methods
#pragma mark-
-(IBAction)goto_Login:(id)sender
{
    
    if ([self login_Validation])
    {
       
           [self call_Driver_Login_API];
            
 
       
    }
    
}


-(BOOL)login_Validation
{
    
    BOOL isValid = false;
    
    if (txtEmail.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else if (![self isValidEmail:txtEmail.text]){
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Valid Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else if (txtPwd.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }else  if (txtPwd.text.length<6)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Valid Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    
    else
    {
        
        
        isValid = true;
    }
    
    return isValid;
}



#pragma mark- DriverLogin_methods
#pragma mark-
-(void)call_Driver_Login_API
{
    
    
    [self add_progress_view];
    NSString *deviceToken = [nsud valueForKey:@"DEVICE_TOKEN"];
    if (deviceToken.length==0)
    {
        deviceToken=@"fdsjkhfshsdkjdhfk47464647466464hfhkhkdhkdshd";
    }
    NSString *str = [NSString stringWithFormat:@"%@?driver_email=%@&driver_password=%@&driver_device_token=%@&driver_device_type=%@",DriverLogin_Url,txtEmail.text,txtPwd.text,deviceToken,@"2"];
    
    WebService *api = [WebService alloc];
    
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
            [nsud setObject:response forKey:@"LoginDriverDict"];
             [nsud setObject:usertype forKey:@"UserType"];
             DriverDashVC *Cp = [[DriverDashVC alloc] initWithNibName:@"DriverDashVC" bundle:nil];
             [self.navigationController pushViewController:Cp animated:YES];
             
         }
         else
             
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
         }
         
         
         
         
     }];
 
    
}

#pragma mark- gotoLogin_methods
#pragma mark-
-(IBAction)Login:(id)sender
{
    
    LoginVC *nav = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
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

#pragma mark - Email Validation Method
#pragma mark -

-(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
