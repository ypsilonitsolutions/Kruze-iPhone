//
//  Dvr_HelpVC.m
//  Journe_Driver
//
//  Created by admin on 05/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "Dvr_HelpVC.h"

@interface Dvr_HelpVC ()
@end

@implementation Dvr_HelpVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Dvr_HelpVC_5";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Dvr_HelpVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Dvr_HelpVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Dvr_HelpVC_6plus";
            
        }
    }
    else
    {
        nibName=@"Dvr_HelpVC_ipad";
        
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
    
    
    tvDescription.layer.cornerRadius = 3;
    tvDescription.layer.borderWidth = 1;
    tvDescription.layer.borderColor = [UIColor  colorWithRed:0.149 green:0.663 blue:0.878 alpha:1].CGColor ;
    bgView.layer.cornerRadius=8.0f;
    bgView.layer.borderColor=sky_blue_color;
    
    tvDescription.text=@"Description...";
    tvDescription.textColor = [UIColor lightGrayColor];
    
    
    def=[NSUserDefaults standardUserDefaults];
    driverDict=[def objectForKey:@"LoginDriverDict"];
    driverID=[driverDict valueForKey:@"driver_id"];// Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -SendMethod
#pragma mark -
-(IBAction)actionSend:(id)sender
{
    
    
    if (tvDescription.text.length==0)
    {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter description" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
    }
    if ([tvDescription.text isEqualToString:@"Description..."])
    {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter description" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
    }
    
    else
    {
        [self Help_API];
    }
}

#pragma mark -CallHelpAPI
#pragma mark -
-(void)Help_API
{
    if (tvDescription.text.length==0)
    {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Enter message first!!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%@?driver_id=%@&text=%@",Help_Web,driverID,tvDescription.text];
    
    WebService *api = [WebService alloc];
    
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
             
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Your request is successfully submited" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
         
         else
             
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
         }
         
     }];
    
}


#pragma mark -BackMethods
#pragma mark -
-(IBAction)actionBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -textViewDelegate
#pragma mark -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Description..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Description...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (IBAction)callToHelpCenter:(id)sender {
    
}




@end
