//
//  PerkVC.m
//  Journe
//
//  Created by admin on 30/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "PerkVC.h"

#define IS_IOS_8_AND_GREATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

@interface PerkVC ()

@end

@implementation PerkVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"PerkVC";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"PerkVC_4";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"PerkVC_6";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"PerkVC_6plus";
            
            
        }
    }
    else
    {
        nibName=@"PerkVC_ipad";
        
        
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
    def=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    lbl_referNo.text=[userDict valueForKey:@"passenger_referral_code"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated

{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
}


#pragma mark- MenuPanel_methods
#pragma mark-
- (IBAction)slider:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
    [self.view endEditing:true];
}

#pragma mark- MenuPanel_methods
#pragma mark-
- (IBAction)inviteFriends:(id)sender
{
    //  NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
    
    NSString *name = [NSString stringWithFormat:@"Hey! Try KRUZE with my referral code %@ and your first trip is FREE.With WiFi and AC bus service in Mumbai, KRUZE is the new way to travel. Check it out:< www.gokruze.com > ",lbl_referNo.text];
    
    NSArray *itemsToShare = @[name];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes=@[ UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, UIActivityTypeAssignToContact,UIActivityTypeCopyToPasteboard];
    
    if (IS_IOS_8_AND_GREATER)
    {
        
        activityVC.popoverPresentationController.sourceView = self.view;
        activityVC.popoverPresentationController.sourceRect = shareView.frame;
        
    }
    
    [self presentViewController:activityVC
                       animated:YES
                     completion:nil];
    
    
}


@end
