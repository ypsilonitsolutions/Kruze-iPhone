//
//  Sugest_RoutVC.m
//  Journe_Driver
//
//  Created by admin on 12/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "Sugest_RoutVC.h"

@interface Sugest_RoutVC (){
    IBOutlet UITextField *txtSource;
    IBOutlet UITextField *txtDestination;
}

@end

@implementation Sugest_RoutVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Sugest_RoutVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Sugest_RoutVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Sugest_RoutVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Sugest_RoutVC_6plus";
            
        }
    }
    else
    {
        nibName=@"Sugest_RoutVC_ipad";
        
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
    
    
    // Do any additional setup after loading the view from its nib.
}




-(void)viewWillAppear:(BOOL)animated

{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self setting_view];
    
}

#pragma  mark - SettingView_methods
#pragma mark -

-(void)setting_view
{
    txtSource.text=@"";
    txtDestination.text=@"";
    txtTimes.text=@"";
    ToTime.text=@"";
    FromTime.text=@"";
    tap=@"";
    txtSource.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Enter Location" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    txtDestination.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Enter Location" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
     txtTimes.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"2 times a day" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    ToTime.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Select Time" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    FromTime.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Select Time" attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
}



#pragma  mark - Menu_methods
#pragma mark -

-(IBAction)actionBack:(id)sender
{
    
    [self.slidingViewController anchorTopViewTo:ECRight];
    [self.view endEditing:true];
    
    
}

#pragma  mark - SuggestRoute_methods
#pragma mark -
-(IBAction)actionSuggest:(id)sender
{
    
    [self sendRoutesLocationsToServer];
}


#pragma mark - picker_methods
#pragma mark -

- (IBAction)dateSelected:(id)sender
{
    CGRect screenSize=[[UIScreen mainScreen]bounds];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"h:mm a"];
    SelectdDate=[format stringFromDate:dataPicker.date];
    if ([tap isEqualToString:@"to"])
    {
        ToTime.text=SelectdDate;
    }
    else
    {
      FromTime.text=SelectdDate;
    }
    [dataPicker reloadInputViews];
    [UIView animateWithDuration:0.2f animations:^{
        
        if(screenSize.size.height<=1024)
            
        {
            
            dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,300, dataPickerView.frame.size.width,dataPickerView.frame.size.height);
            
        }
        else
        {
            
            dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,300, dataPickerView.frame.size.width,dataPickerView.frame.size.height);
        }
        
        
    }];
    [shadowView setHidden:true];
    
}
-(IBAction)cancelShadow:(id)sender{
    
    CGRect screenSize=[[UIScreen mainScreen]bounds];
    [UIView animateWithDuration:0.2f animations:^{
        if(screenSize.size.height<=1024)
            
        {
            
            dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,1024, dataPickerView.frame.size.width,dataPickerView.frame.size.height);
            
        }
        else
        {
            
            dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,600, dataPickerView.frame.size.width,dataPickerView.frame.size.height);
        }
        
        
    }];
    
    
    [shadowView setHidden:true];
    
}

#pragma mark- send routes to server
#pragma mark-
-(void)sendRoutesLocationsToServer
{
    if (txtSource.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please enter source location" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return ;
    }
    else if (txtDestination.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please enter destination location" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return ;
    }
    else if (txtTimes.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please enter  times" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return ;
    }
    else if (FromTime.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please enter  timing" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return ;
    }
    else if (ToTime.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please enter  timing" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return ;
    }
    [self add_progress_view];
    [def setObject:txtSource.text forKey:@"source_location"];
    [def setObject:txtDestination.text forKey:@"destination_location"];
    
    
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    NSString *User_Id=[userDict valueForKey:@"passenger_id"];
    NSString *str = [NSString stringWithFormat:@"%@?passenger_id=%@&source=%@&destination=%@&travel_times=%@&to_time=%@&from_time=%@",SuggestRoutes_Url,User_Id,txtSource.text,txtDestination.text,txtTimes.text,ToTime.text,FromTime.text];
    str=[str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:YES];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             ThankYouVC *thankvc = [[ThankYouVC alloc] initWithNibName:@"ThankYouVC" bundle:nil];
             [self.navigationController pushViewController:thankvc animated:YES];
         }
         else
         {
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please try again in some time" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert show];
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
#pragma mark-TimeSelectionButtons
- (IBAction)todateSelected:(id)sender
{
  tap=@"to";
    [shadowView setHidden:false];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];
    [dataPicker setDate:[NSDate date]];
    [UIView animateWithDuration:0.2f animations:^{
        dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,self.view.frame.size.height-dataPickerView.frame.size.height,dataPickerView.frame.size.width,dataPickerView.frame.size.height);
    }];
    
}
- (IBAction)fromdateSelected:(id)sender
{
  tap=@"from";
    [shadowView setHidden:false];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];
    [dataPicker setDate:[NSDate date]];
    [UIView animateWithDuration:0.2f animations:^{
        dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,self.view.frame.size.height-dataPickerView.frame.size.height,dataPickerView.frame.size.width,dataPickerView.frame.size.height);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

