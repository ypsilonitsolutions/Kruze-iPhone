//
//  ThankYouVC.m
//  Journe_Driver
//
//  Created by admin on 12/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//


#import "ThankYouVC.h"

@interface ThankYouVC ()

@end

@implementation ThankYouVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"ThankYouVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"ThankYouVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"ThankYouVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"ThankYouVC_6plus";
            
        }
    }
    else
    {
        nibName=@"ThankYouVC_ipad";
        
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


#pragma  mark - SettingView_methods
#pragma mark -
-(void)setting_view
{
    def=[NSUserDefaults standardUserDefaults];
    txtSource.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Sun city, gurgaon" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    txtDestination.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Vatika city point" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    txtSource.text=[def objectForKey:@"source_location"];
    txtDestination.text=[def objectForKey:@"destination_location"];
}


#pragma  mark - SuggestAnother_methods
#pragma mark -
-(IBAction)actionSuggest:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma  mark - Back_methods
#pragma mark -
-(IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - Home_methods
#pragma mark -
-(IBAction)goHome:(id)sender
{
DashboardVC *Cp = [[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];

objISVC.topViewController = Cp;


[self.navigationController pushViewController:objISVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

