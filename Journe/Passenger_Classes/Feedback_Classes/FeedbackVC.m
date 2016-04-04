//
//  FeedbackVC.m
//  Journe
//
//  Created by admin on 29/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//



#import "FeedbackVC.h"

@interface FeedbackVC ()

@end

@implementation FeedbackVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"FeedbackVC";
            
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"FeedbackVC_4";
            
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"FeedbackVC_6";
            
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"FeedbackVC_6plus";
            
            
            
        }
    }
    else
    {
        nibName=@"FeedbackVC_ipad";
        
        
        
    }
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its
    def=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- FeedbackPressed_methods
#pragma mark-
- (IBAction)feedbackPressed:(id)sender
{
    int btnTag=[sender tag];
    if (btnTag==1)
    {
        
      FeedbackTxt=@"Rude Driver";
    }
   else if (btnTag==2)
    {
      FeedbackTxt=@"Not Safe";
    }
   else if (btnTag==3)
    {
     FeedbackTxt=@"A.C Not Working";
    }
   else if (btnTag==4)
    {
      FeedbackTxt=@"Not Clean";
    }
   else if (btnTag==5)
    {
     FeedbackTxt=@"Note On Time";
    }
   else if (btnTag==6)
    {
      FeedbackTxt=@"Some Other Issues";
    }
   else if (btnTag==7)
    {
      FeedbackTxt=@"Just Awesome";
    }
    [self call_FeedbackAPI];
    
    
}

#pragma  mark - GetUserProfile_methods
#pragma mark -
-(void)call_FeedbackAPI
{
[self add_progress_view];
NSString *str = [NSString stringWithFormat:@"%@?passenger_id=%@&feedback=%@&b_id=%@&feedback_type=%@",PsgFeedback_Url,User_Id,FeedbackTxt,[def objectForKey:@"feedback_bId"],@"1"];
    
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
#pragma mark- MenuPanel_methods
#pragma mark-
- (IBAction)slider:(id)sender
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
            
            History_BookVC *Cp = [[History_BookVC alloc] initWithNibName:@"History_BookVC" bundle:nil];
            InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
            
            objISVC.topViewController = Cp;
            
            
            [self.navigationController pushViewController:objISVC animated:YES];
            
            
            
            
            
            
            
        }
    }
    
    
    
    
    
    
    
}

@end
