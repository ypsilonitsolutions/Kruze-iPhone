//
//  WalletVC.m
//  Journe_Driver
//
//  Created by admin on 20/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "WalletVC.h"

@interface WalletVC ()

@end

@implementation WalletVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"WalletVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"WalletVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"WalletVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"WalletVC_6plus";
            
        }
    }
    else
    {
        nibName=@"WalletVC_ipad";
        
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
    vWWallet.layer.cornerRadius = 5;
    vWWallet.layer.borderWidth=1;
    vWWallet.layer.borderColor = [UIColor  colorWithRed:0.149 green:0.663 blue:0.878 alpha:1].CGColor ;
    
     txtAddFunds.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"₹ Add funds to your wallet" attributes:@{NSForegroundColorAttributeName:text_gray_color}];
    

}


-(void)viewWillAppear:(BOOL)animated

{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self getRewards];
}
#pragma  mark - MenuPanel_methods
#pragma mark -
-(IBAction)actionBack:(id)sender
{
  

 [self.slidingViewController anchorTopViewTo:ECRight];
    [self.view endEditing:true];

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
             lblPoints.text=[NSString stringWithFormat:@"%@ Pts.",[response valueForKey:@"points"]];
             
             [def setObject:[response valueForKey:@"points"] forKey:@"TotalRewardsPoints"];
           
              lblTrip.text=[NSString stringWithFormat:@"%@ Free Ride",[response valueForKey:@"rides"]];
             
         }
         else
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
         
     }];
    
    
    
    
    
    
    
    
    
}

#pragma  mark - RecentTransaction_methods
#pragma mark -



-(IBAction)actionJourneCash:(id)sender
{
    Recent_TransVC *recent = [[Recent_TransVC alloc]initWithNibName:@"Recent_TransVC" bundle:nil];
    [self.navigationController pushViewController:recent animated:YES];
}
#pragma  mark - RewardPoints_methods
#pragma mark -
-(IBAction)actionRewardPnt:(id)sender
{
    
    RewardsHistoryVC *recent = [[RewardsHistoryVC alloc]initWithNibName:@"RewardsHistoryVC" bundle:nil];
    [self.navigationController pushViewController:recent animated:YES];
    
}

#pragma  mark - PayNow_methods
#pragma mark -
-(IBAction)actionPayNow:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
