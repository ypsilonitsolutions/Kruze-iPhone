//
//  FAQ_VC.m
//  Journe
//
//  Created by admin on 30/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "FAQ_VC.h"

@interface FAQ_VC ()

@end

@implementation FAQ_VC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"FAQ_VC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"FAQ_VC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"FAQ_VC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"FAQ_VC_6plus";
            
        }
    }
    else
    {
        nibName=@"FAQ_VC_ipad";
        
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
    [self add_progress_view];
    
    NSURL *url=[NSURL URLWithString:@"http://54.67.85.189/journe/webservices/html/faq.html"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [webVieww loadRequest:request];
    [HUD hide:true];
}
-(void)viewWillAppear:(BOOL)animated

{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    
    
}

#pragma  mark - MenuMethods
#pragma  mark -
-(IBAction)actionMenu:(id)sender
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
