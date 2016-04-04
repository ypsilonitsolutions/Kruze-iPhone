//
//  Kruze_PlayVC.m
//  Journe_Driver
//
//  Created by admin on 03/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "Kruze_PlayVC.h"

@interface Kruze_PlayVC ()

@end

@implementation Kruze_PlayVC



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Kruze_PlayVC";
            imgActive=@"ck_box_active";
            imgInactive=@"ck_box_inactive";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Kruze_PlayVC_4";
            imgActive=@"ck_box_active";
            imgInactive=@"ck_box_inactive";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Kruze_PlayVC_6";
            imgActive=@"ck_box_active";
            imgInactive=@"ck_box_inactive";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Kruze_PlayVC_6plus";
            imgActive=@"ck_box_active";
            imgInactive=@"ck_box_inactive";
            
        }
    }
    else
    {
        nibName=@"Kruze_PlayVC_ipad";
        imgActive=@"ck_box_active_i";
        imgInactive=@"ck_box_inactive_i";
        
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
}
-(void)viewWillAppear:(BOOL)animated

{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - MenuMethods
#pragma  mark -
-(IBAction)actionMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
    [self.view endEditing:true];
    
}
#pragma  mark - SubmitMethods
#pragma  mark -

-(IBAction)actionSubmit:(id)sender
{
   
    tapMusic=false;
    tapebook=false;
    tapnews=false;
    tapsong=false;
    tapYoutube=false;
    
     [btnMusic setImage:[UIImage imageNamed:imgInactive] forState:UIControlStateNormal];
     [btnEbook setImage:[UIImage imageNamed:imgInactive] forState:UIControlStateNormal];
     [btnNews setImage:[UIImage imageNamed:imgInactive] forState:UIControlStateNormal];
     [btnSong setImage:[UIImage imageNamed:imgInactive] forState:UIControlStateNormal];
    [btnyoutube setImage:[UIImage imageNamed:imgInactive] forState:UIControlStateNormal];
    
    UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Thanks for your reply, we will get you entertained soon" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [a show];
    a.tag=1;
    
    
    
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

#pragma  mark - SuggetionButtonsMethods
#pragma  mark -
-(IBAction)actionMusic:(id)sender
{
    if (tapMusic==false)
    {
     
        [btnMusic setImage:[UIImage imageNamed:imgActive] forState:UIControlStateNormal];
        tapMusic=true;
        
    }
    else
    {
        
        tapMusic=false;
      
          [btnMusic setImage:[UIImage imageNamed:imgInactive] forState:UIControlStateNormal];
        
    }
    
  
    
}


-(IBAction)actionYouTube:(id)sender
{
    
    if (tapYoutube==false)
    {
        
        [btnyoutube setImage:[UIImage imageNamed:imgActive] forState:UIControlStateNormal];
        tapYoutube=true;
        
    }
    else
    {
        
        tapYoutube=false;
        
        [btnyoutube setImage:[UIImage imageNamed:imgInactive] forState:UIControlStateNormal];
        
    }
 
}


-(IBAction)actionSong:(id)sender
{ if (tapsong==false)
{
    
    [btnSong setImage:[UIImage imageNamed:imgActive] forState:UIControlStateNormal];
    tapsong=true;
    
}
else
{
    
    tapsong=false;
    
    [btnSong setImage:[UIImage imageNamed:imgInactive] forState:UIControlStateNormal];
    
}

    
}


-(IBAction)actionNews:(id)sender
{
    if (tapnews==false)
    {
        
        [btnNews setImage:[UIImage imageNamed:imgActive] forState:UIControlStateNormal];
        tapnews=true;
        
    }
    else
    {
        
        tapnews=false;
        
        [btnNews setImage:[UIImage imageNamed:imgInactive] forState:UIControlStateNormal];
        
    }
 
    
}


-(IBAction)actionEbook:(id)sender
{
    if (tapebook==false)
    {
        
        [btnEbook setImage:[UIImage imageNamed:imgActive] forState:UIControlStateNormal];
        tapebook=true;
        
    }
    else
    {
        
        tapebook=false;
        
        [btnEbook setImage:[UIImage imageNamed:imgInactive] forState:UIControlStateNormal];
        
    }
    
 
}

@end
