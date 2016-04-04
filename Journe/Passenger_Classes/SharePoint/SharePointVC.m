//
//  SharePointVC.m
//  Journe_Driver
//
//  Created by admin on 29/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "SharePointVC.h"

@interface SharePointVC ()

@end

@implementation SharePointVC



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"SharePointVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"SharePointVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"SharePointVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"SharePointVC_6plus";
            
        }
    }
    else
    {
        nibName=@"SharePointVC_ipad";
        
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
    [self settingView];
    // Do any additional setup after loading the view from its nib.
    def=[NSUserDefaults standardUserDefaults];
    userDict=[def objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
    [self getRewards];
}

#pragma mark- SettingView_methods
#pragma mark-
-(void)settingView
{
    btnSharePoint.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
    btnSharePoint.titleLabel.numberOfLines = 2;
 
    [scrolView setContentSize:CGSizeMake(320, 500)];
    
    txtMObile.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Email / Mobile Number" attributes:@{NSForegroundColorAttributeName:text_gray_color }];
    
    txtOptional.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"What is it for?(optional)" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
     txtSharePonts.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Share Points" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
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
#pragma  mark - RewardsPointsmethods
#pragma mark

-(void)getRewards
{
    
    
    [self add_progress_view];
    NSString *str=[NSString stringWithFormat:@"%@?passenger_id=%@",Rewards_Url,User_Id];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             LblPoints.text=[NSString stringWithFormat:@"%@ Pts.",[response valueForKey:@"points"]];
             totalPoints=[[response valueForKey:@"points"]intValue];
             
             
             
         }
         else
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
         
     }];
    
    
}
#pragma mark- Back_methods
#pragma mark-
-(IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:true];
    
}
#pragma mark- SharePoints_methods
#pragma mark-
-(IBAction)actionSendPoints:(id)sender
{
   
    if (txtMObile.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Email/Mobile" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    
    else if (txtSharePonts.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Points" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else if ([txtSharePonts.text intValue]>totalPoints)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"You dont have Sufficient Points" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    
    else
    {
        
        
        [self add_progress_view];
        NSString *str=[NSString stringWithFormat:@"%@?passenger_id=%@&friend_detail=%@&points=%@",SharePoints_Url,User_Id,txtMObile.text,txtSharePonts.text];
        WebService *api = [WebService alloc];
        [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
         {
             [HUD hide:true];
             if ([[response objectForKey:@"status"] isEqualToString:@"true"])
             {
                 txtSharePonts.text=@"";
                 txtOptional.text=@"";
                 txtMObile.text=@"";
                 UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [a show];
                 [self getRewards];
                 
                 
             }
             else
             {
                 UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [a show];
             }
             
         }];
        
        
        
        
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
