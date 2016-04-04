//
//  NotificationVC.m
//  Journe_Driver
//
//  Created by admin on 17/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "NotificationVC.h"

@interface NotificationVC (){
    IBOutlet UITableView *tblNotification;
}

@end

@implementation NotificationVC



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"NotificationVC";
            
            cellNib=@"NotificationTVCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"NotificationVC_4";
             cellNib=@"NotificationTVCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"NotificationVC_6";
             cellNib=@"NotificationTVCell_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"NotificationVC_6plus";
             cellNib=@"NotificationTVCell_6plus";
            
        }
    }
    else
    {
        nibName=@"NotificationVC_ipad";
         cellNib=@"NotificationTVCell_ipad";
        
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
    
    respArray=[[NSMutableArray alloc]init];
    def=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
    [self getNotificationList];

    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated

{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
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
#pragma  mark - getListing
#pragma  mark -
-(void)getNotificationList
{
    
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?passenger_id=%@",Notification_Url,User_Id];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             respArray=[response objectForKey:@"notifications"];
             [tblNotification reloadData];
             
         }
         else
             
         {
             
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
             
         }
         
         
         
         
     }];
    
    
    
    
    
}
#pragma mark- Slider_methods
#pragma mark-
-(IBAction)goToMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
    [self.view endEditing:true];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return [respArray count];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *simpleTableIdentifier = @"TableCellCustom";
    NotificationTVCell *cell = [tblNotification dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:cellNib owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
        
    }
    
    NSMutableDictionary *dict=[respArray objectAtIndex:indexPath.row];
    cell.lblBookDetail.text=[dict valueForKey:@"noti_message"];
    cell.lblTime.text=[dict valueForKey:@"noti_datetime"];
     cell.lblheader.text=[dict valueForKey:@"noti_type"];
    
    return cell;
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
