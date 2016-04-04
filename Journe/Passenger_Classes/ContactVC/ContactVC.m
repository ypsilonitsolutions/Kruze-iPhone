//
//  Dvr_ContactVC.m
//  Journe_Driver
//
//  Created by admin on 11/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "ContactVC.h"

@interface ContactVC ()

@end

@implementation ContactVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"ContactVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"ContactVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"ContactVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"ContactVC_6plus";
            
        }
    }
    else
    {
        nibName=@"ContactVC_ipad";
        
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
    [self setting_view];
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
#pragma  mark - Menu_methods
#pragma mark -

-(IBAction)actionBack:(id)sender
{
    
   [self.slidingViewController anchorTopViewTo:ECRight];
    [self.view endEditing:true];
    
    
}
#pragma  mark - SettingView_methods
#pragma mark -

-(void)setting_view

{
    def=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
    txtName.text=[userDict valueForKey:@"passenger_name"];
    txtEmail.text=[userDict valueForKey:@"passenger_email"];
    txtPhone.text=[userDict valueForKey:@"passenger_mobile"];
    
    txtName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtPhone.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Phone" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    tvMessage.layer.cornerRadius = 3;
    tvMessage.layer.borderWidth = 1;
    tvMessage.layer.borderColor = [UIColor colorWithRed:0.149 green:0.663 blue:0.878 alpha:1].CGColor;
    [self getCompanyInfo];
    
}
#pragma  mark - SendMessage_methods
#pragma mark -

-(void)getCompanyInfo
{
    [self add_progress_view];
    NSString *str=[NSString stringWithFormat:@"%@",CompanyDetails_Url];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
           
             NSMutableDictionary *Dict=[response objectForKey:@"details"];
             [lblhelpline setTitle:[Dict valueForKey:@"c_detail_helpline_no"] forState:UIControlStateNormal];
             [lblLoc setTitle:[Dict valueForKey:@"c_detail_location"] forState:UIControlStateNormal];
             [lblMail setTitle:[Dict valueForKey:@"c_detail_email"] forState:UIControlStateNormal];
        
         }
         else
         {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
         }
         
     }];
    

    
    
    
    
    
}

#pragma  mark - SendMessage_methods
#pragma mark -

-(IBAction)actionSend:(id)sender
{
    
    
    
    if ([self Contact_Validation])
    {
        
        [self call_Contact_API];
    }
    
    
    
}


-(void)call_Contact_API
{
    
    
    [self add_progress_view];
    NSString *str=[NSString stringWithFormat:@"%@?passenger_id=%@&name=%@&email=%@&phone=%@&message=%@",ContactUs_Url,User_Id,txtName.text,txtEmail.text,txtPhone.text,tvMessage.text];
    WebService *api = [WebService alloc];
    
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             tvMessage.text=@"Message";
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

-(BOOL)Contact_Validation
{
    
    BOOL isValid = false;
    if (txtName.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Full Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    
    else if (txtEmail.text.length==0){
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else if (![self isValidEmail:txtEmail.text]){
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Valid Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    
    else if (txtPhone.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Contact No." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else if (txtPhone.text.length>10||txtPhone.text.length<10){
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Valid Contact No." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else if ([tvMessage.text isEqualToString:@"Message"])
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }else
    {
        
        isValid = true;
    }
    
    return isValid;
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
#pragma  mark - FooterOptions_methods
#pragma mark -


-(IBAction)actionLocation:(id)sender
{
    
    
    
}

-(IBAction)actionEmail:(id)sender
{
    
}

-(IBAction)actionCall:(id)sender
{
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
