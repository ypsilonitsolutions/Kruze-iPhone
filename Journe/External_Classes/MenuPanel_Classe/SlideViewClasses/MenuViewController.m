//
//  MenuViewController.m
//  ECSlidingViewController
//
//  Created by Administrator on 28/02/15.
//  Copyright (c) 2014 MaheshDhakad. All rights reserved.
//

#import "MenuViewController.h"

#import "InitialSlidingViewController.h"
@interface MenuViewController()

@end


@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"MenuViewController";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"MenuViewController";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"MenuViewController_6";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"MenuViewController_6plus";
        }
        
    }
    else
    {
        
        nibName=@"MenuViewController_ipad";
        
    }
    
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    nsud=[NSUserDefaults standardUserDefaults];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
    [self.slidingViewController setAnchorRightRevealAmount:220.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    }
    else
    {
    [self.slidingViewController setAnchorRightRevealAmount:350.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    }
     userDict=[nsud objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
   
    lbl_mail.text=[userDict objectForKey:@"passenger_email"];
    lbl_name.text=[userDict objectForKey:@"passenger_name"];
    NSString *Url_image = [NSString stringWithFormat:@"%@",[userDict objectForKey:@"passenger_image"]];
    if ([Url_image isEqualToString:@"http://54.67.85.189/journe/uploads/passenger_image/"])
    {
        [BtnQRCode setImage:[UIImage imageNamed:@"profile_icon_ipad"] forState:UIControlStateNormal];
    }
    else
    {
    BtnQRCode.layer.borderWidth=1;
    BtnQRCode.clipsToBounds = YES;
BtnQRCode.layer.cornerRadius=BtnQRCode.frame.size.height/2.0f;
    BtnQRCode.layer.borderColor=sky_blue_color;
    [BtnQRCode.imageView setImageWithURL:[NSURL URLWithString:Url_image] completed:^(UIImage *imag, NSError *error, SDImageCacheType cacheType)
     {
         [BtnQRCode setImage:imag forState:UIControlStateNormal];
     }];
    }
    
   
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
             [nsud setObject: [response valueForKey:@"rides"] forKey:@"FreeRides"];
             
     
             
         }
         else
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
         
     }];
    
 
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.view endEditing:true];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            scroll_view.contentSize=CGSizeMake(scroll_view.frame.size.width,scroll_view.frame.size.height+250);
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
           scroll_view.contentSize=CGSizeMake(scroll_view.frame.size.width,scroll_view.frame.size.height+280);

        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
           scroll_view.contentSize=CGSizeMake(scroll_view.frame.size.width,scroll_view.frame.size.height+270);

        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
         scroll_view.contentSize=CGSizeMake(scroll_view.frame.size.width,scroll_view.frame.size.height+290);
            
        }
        
    }
    else
    {
        
      scroll_view.contentSize=CGSizeMake(scroll_view.frame.size.width,scroll_view.frame.size.height+300);
        
    }
    
     [self getRewards];
        }

#pragma mark- Buttons_methods
#pragma mark-
- (IBAction)goToDashboard:(id)sender
{
    DashboardVC *Cp = [[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
   
}
#pragma mark- Buttons_methods
#pragma mark-
- (IBAction)notificationVC:(id)sender
{
    NotificationVC *Cp = [[NotificationVC alloc] initWithNibName:@"NotificationVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}

#pragma mark- Buttons_methods
#pragma mark-
- (IBAction)FaqVC:(id)sender
{
    FAQ_VC *Cp = [[FAQ_VC alloc] initWithNibName:@"FAQ_VC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}


- (IBAction)goToBookings:(id)sender
{
    Current_BookVC *Cp = [[Current_BookVC alloc] initWithNibName:@"Current_BookVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}
- (IBAction)kruzePlay:(id)sender
{
    Kruze_PlayVC *Cp = [[Kruze_PlayVC alloc] initWithNibName:@"Kruze_PlayVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}
- (IBAction)goToWallet:(id)sender
{
    WalletVC *Cp = [[WalletVC alloc] initWithNibName:@"WalletVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}


- (IBAction)goToProfile:(id)sender
{
    ProfileVC *Cp = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}

- (IBAction)goToMembershipVC:(id)sender
{
    MemberIdentificationVC *Cp = [[MemberIdentificationVC alloc] initWithNibName:@"MemberIdentificationVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}

- (IBAction)goToPerks:(id)sender
{
    PerkVC *Cp = [[PerkVC alloc] initWithNibName:@"PerkVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}


- (IBAction)goToContact:(id)sender
{
    ContactVC *Cp = [[ContactVC alloc] initWithNibName:@"ContactVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}
- (IBAction)goToSuggestRoute:(id)sender
{
    Sugest_RoutVC *Cp = [[Sugest_RoutVC alloc] initWithNibName:@"Sugest_RoutVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}

- (IBAction)bookACar:(id)sender
{
    BookCarVC *Cp = [[BookCarVC alloc] initWithNibName:@"BookCarVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
}
- (IBAction)GoToLogout:(id)sender
{
    UIAlertView *v1 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you want to Logout" delegate:self cancelButtonTitle:@"Logout" otherButtonTitles:@"Cancel",nil];
    v1.tag=1;
    [v1 show];
}
#pragma mark- AlerDelegate_methods
#pragma mark-
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            [nsud removeObjectForKey:@"LoginUserDict"];
            [nsud removeObjectForKey:@"UserType"];
            LoginVC *Cp = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
            InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
            
            objISVC.topViewController = Cp;
            
            
            [self.navigationController pushViewController:objISVC animated:YES];
            
        }
        else
        {
            return;
        }
        
    }
    
}


@end

