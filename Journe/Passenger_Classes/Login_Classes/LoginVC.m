//
//  LoginVC.m
//  Journe
//
//  Created by admin on 19/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"LoginVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"LoginVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"LoginVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"LoginVC_6plus";
            
        }
    }
    else
    {
        nibName=@"LoginVC_ipad";
        
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
    [[GIDSignIn sharedInstance] signOut];
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
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
   
    btnFb.layer.cornerRadius=5;
    btnFb.layer.masksToBounds=YES;
    btnFb.layer.borderWidth=1;
    btnFb.layer.borderColor=fb_outline_color;
    btnGplus.layer.cornerRadius=5;
    btnGplus.layer.masksToBounds=YES;
    btnGplus.layer.borderWidth=1;
    btnGplus.layer.borderColor=[[UIColor colorWithRed:213.0/255.0 green:73.0/255.0 blue:55.0/255.0 alpha:1.0]CGColor];
    btnLogin.layer.borderWidth=1;
    btnLogin.clipsToBounds = YES;
    btnLogin.layer.cornerRadius = btnLogin.frame.size.height/2.0f;
    btnLogin.layer.borderColor=sky_blue_color;
    btnSignUp.clipsToBounds = YES;
    btnSignUp.layer.cornerRadius = btnSignUp.frame.size.height/2.0f;
    btnSignUp.layer.borderWidth=1;
    btnSignUp.layer.borderColor=sky_blue_color;
    
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtPwd.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    usertype=@"passenger";
    
}

#pragma mark- SignInButton_methods
#pragma mark-
-(IBAction)goto_Login:(id)sender
{
    
    if ([self login_Validation])
    {
        
             [self call_Passenger_Login_API];
       
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



#pragma mark- PassemgerLogin_methods
#pragma mark-

-(void)call_Passenger_Login_API
{
    [self add_progress_view];
    NSString *deviceToken = [nsud valueForKey:@"DEVICE_TOKEN"];
    if (deviceToken.length==0)
    {
        deviceToken=@"fdsjkhfshsdkjdhfk4";
    }
    NSString *str = [NSString stringWithFormat:@"%@?passenger_email=%@&passenger_password=%@&device_token=%@",Login_Url,txtEmail.text,txtPwd.text,deviceToken];
    
    WebService *api = [WebService alloc];
    
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             [nsud setObject:response forKey:@"LoginUserDict"];
             [nsud setObject:usertype forKey:@"UserType"];
             [nsud synchronize];
             DashboardVC *Cp = [[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
             InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
             
             objISVC.topViewController = Cp;
             
             
             [self.navigationController pushViewController:objISVC animated:YES];
             
         }
         else
             
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
         }
         
         
         
         
     }];
    
    
    
}



#pragma mark- SignUp_methods
#pragma mark-
-(IBAction)SignUp:(id)sender
{
   
    [nsud setObject:@"" forKey:@"UserName"];
    [nsud setObject:@"" forKey:@"UserMail"];
    SignUpVc *sign_UP=[[SignUpVc alloc]initWithNibName:@"SignUpVc" bundle:nil];
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
    [UIView setAnimationDuration:0.75];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    [self.navigationController pushViewController:sign_UP animated:YES];
   
   
    
    
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

#pragma mark- SignUp_with_facebook_methods
#pragma mark-
-(IBAction)facebook_Login:(id)sender
{
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    login.loginBehavior=FBSDKLoginBehaviorWeb;
    
    [login
     logInWithReadPermissions: @[@"public_profile", @"email",@"user_friends"]
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in %@",result);
             if ([FBSDKAccessToken currentAccessToken]) {
                 NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                 [parameters setValue:@"id,name,email,first_name,last_name" forKey:@"fields"];
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id resul, NSError *error) {
                      
                      NSLog(@"fetched user:%@", resul);
                      NSString *email = [resul objectForKey:@"email"];
                    //  NSString *fname=[resul objectForKey:@"first_name"];
                     // NSString *lname=[resul objectForKey:@"last_name"];
                    //  NSString *accessToken=[resul objectForKey:@"id"];
                    NSString *name=[resul objectForKey:@"name"];
                      [nsud setObject:name forKey:@"UserName"];
                      [nsud setObject:email forKey:@"UserMail"];
                      SignUpVc *sign_UP=[[SignUpVc alloc]initWithNibName:@"SignUpVc" bundle:nil];
                      [UIView  beginAnimations:nil context:NULL];
                      [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
                      [UIView setAnimationDuration:0.75];
                      
                      [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
                      [UIView commitAnimations];
                      [self.navigationController pushViewController:sign_UP animated:YES];
                      
                      
                      
                      
                 
                  }];
             }
         }
     }];


    
}

#pragma mark - Driver Login
#pragma mark -
- (IBAction)driverLogin:(id)sender
{
    
    
    
    Dvr_LoginVC *sign_UP=[[Dvr_LoginVC alloc]initWithNibName:@"Dvr_LoginVC" bundle:nil];
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
    [UIView setAnimationDuration:0.75];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    [self.navigationController pushViewController:sign_UP animated:YES];
 
    
    
    
    
}

#pragma mark - Google Login
#pragma mark -
- (IBAction)googleSignIn:(id)sender
{
   

    GIDSignIn *sigNIn=[GIDSignIn sharedInstance];
  
    [sigNIn signIn];
    

}
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error
{
    if (error)
    {
       // [self HideProgressBar];
    }
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    //GIDGoogleUser *googleUser = [[GIDSignIn sharedInstance] currentUser];
    // NSString *userId = user.userID;
    // For client-side use only!
    if (error)
    {
        //[self HideProgressBar];
    }
    else
    {
        NSString *idToken = user.authentication.idToken;
        // Safe to send to the server
        NSString *name = user.profile.name;
        NSArray *nameArray=[name componentsSeparatedByString:@" "];
        NSString *fname,*lname;
        if (nameArray.count==2)
        {
            fname=[nameArray objectAtIndex:0];
            lname=[nameArray objectAtIndex:1];
        }
        else
        {
            fname=[nameArray objectAtIndex:0];
        }
        NSString *email = user.profile.email;
    [nsud setObject:name forKey:@"UserName"];
    [nsud setObject:email forKey:@"UserMail"];
  
        SignUpVc *sign_UP=[[SignUpVc alloc]initWithNibName:@"SignUpVc" bundle:nil];
        [UIView  beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
        [UIView setAnimationDuration:0.75];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
        [self.navigationController pushViewController:sign_UP animated:YES];
        
        
        
        
        
        
    }
}
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self ShowProgressBar];
}

#pragma mark- ForgetPwdMethods_methods
#pragma mark-
-(IBAction)forgetTapped:(id)sender
{
    
    shadowView.hidden=false;
    
}
-(IBAction)doneForgetpressed:(id)sender
{
    
    if (txtForgetMail.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else if (![self isValidEmail:txtForgetMail.text]){
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Valid Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else
    {
        [self add_progress_view];
        NSString *str = [NSString stringWithFormat:@"%@?email=%@",PsgForgetPwd_Url,txtForgetMail.text];
        
        WebService *api = [WebService alloc];
        
        [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
         {
             [HUD hide:true];
             if ([[response objectForKey:@"status"] isEqualToString:@"true"])
             {
                 shadowView.hidden=true;
                 UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [a show];
                 
             }
             else
                 
             {
                 shadowView.hidden=true;
                 UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [a show];
                 
                 
             }
             
             
             
             
         }];
  
        
        
        
        
    }
    
  
    
}
-(IBAction)closeShadow:(id)sender
{

    txtForgetMail.text=@"";
    shadowView.hidden=true;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
