//
//  SplashVC.m
//  Journe
//
//  Created by admin on 22/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "SplashVC.h"
#import "InternetAccess.h"

@interface SplashVC ()

@end

@implementation SplashVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"SplashVC";
            SplashImage=@"logox320";
          
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"SplashVC_4";
            SplashImage=@"logox320";
           
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"SplashVC_6";
            SplashImage=@"logox375";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"SplashVC_6plus";
            SplashImage=@"logox414";
            
            
        }
    }
    else
    {
        nibName=@"SplashVC_ipad";
        SplashImage=@"logox768";
        
        
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
    
    
    i=0;
    
    NSString *path=[[NSBundle mainBundle]pathForResource:SplashImage ofType:@"gif"];
    
    NSURL *url=[[NSURL alloc] initFileURLWithPath:path];
    
    AnimatedSplash.image= [UIImage animatedImageWithAnimatedGIFURL:url];
    
    
    
    [self continueCheck];
    
    
}

-(void)continueCheck
{
    
    [self performSelector:@selector(animatedTimer) withObject:nil afterDelay:1.0];
    
}

-(void)animatedTimer
{
    
    
    
    if (i==5)
    {
        
    
    //Animated GIF image from app code
    InternetAccess  *access=[[InternetAccess alloc] init];
    
    if ([access checkInternet]==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        btnRetry.hidden=false;
    }
    else
    {
        btnRetry.hidden=true;
        def=[NSUserDefaults standardUserDefaults];
        [self timer];
    }
    }
    
    else
    {
        i++;
        [self continueCheck];
    }
}

-(void)timer

{
   
         NSString *usertype=[def objectForKey:@"UserType"];
        if ([usertype isEqualToString:@"passenger"])
        {
            
            NSMutableDictionary *user_dict=[def objectForKey:@"LoginUserDict"];
            if (user_dict.count==0)
            {
                LoginVC *sign_UP=[[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
                [UIView  beginAnimations:nil context:NULL];
            [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
                [UIView setAnimationDuration:0.75];
                
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
                [UIView commitAnimations];
                [self.navigationController pushViewController:sign_UP animated:YES];
            }
            else
            {
                
                DashboardVC *sign_UP=[[DashboardVC alloc]initWithNibName:@"DashboardVC" bundle:nil];
                [UIView  beginAnimations:nil context:NULL];
                [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
                [UIView setAnimationDuration:0.75];
                
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
                [UIView commitAnimations];
                InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
                
                objISVC.topViewController = sign_UP;
                [self.navigationController pushViewController:objISVC animated:YES];
                
                
            }
            
        }
       else if ([usertype isEqualToString:@"driver"])
        {
            
            
            DriverDashVC *sign_UP=[[DriverDashVC alloc]initWithNibName:@"DriverDashVC" bundle:nil];
            [UIView  beginAnimations:nil context:NULL];
            [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
            [UIView setAnimationDuration:0.75];
            
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
            [UIView commitAnimations];
    
            [self.navigationController pushViewController:sign_UP animated:YES];
           
            
        }
        
        else
        {
            
            
            LoginVC *sign_UP=[[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
            [UIView  beginAnimations:nil context:NULL];
            [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
            [UIView setAnimationDuration:0.75];
            
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
            [UIView commitAnimations];
            [self.navigationController pushViewController:sign_UP animated:YES];
            
            
        }
     
       
        
       
   
    
    
}

-(IBAction)retry:(id)sender
{
    [self viewDidLoad];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
