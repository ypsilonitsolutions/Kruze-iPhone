//
//  RewardsHistoryVC.m
//  Journe
//
//  Created by admin on 21/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "RewardsHistoryVC.h"
@interface RewardsHistoryVC ()

@end

@implementation RewardsHistoryVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"RewardsHistoryVC";
            cellNib=@"RewardHistoryCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"RewardsHistoryVC_4";
            cellNib=@"RewardHistoryCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"RewardsHistoryVC_6";
            cellNib=@"RewardHistoryCell_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"RewardsHistoryVC_6plus";
            cellNib=@"RewardHistoryCell_6plus";
            
        }
    }
    else
    {
        nibName=@"RewardsHistoryVC_ipad";
        cellNib=@"RewardHistoryCell_ipad";
        
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
    respArray =[[NSMutableArray alloc]init];
    backView.layer.cornerRadius=5;
    backView.layer.masksToBounds=YES;
    backView.layer.borderColor=sky_blue_color;
    backView.layer.borderWidth=1;
    def=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
    
    NSString *strPoints=[def objectForKey:@"TotalRewardsPoints"];
    totalRewardsPoints=[strPoints intValue];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self RewardsList];
}

#pragma  mark - getListing
#pragma  mark -
-(void)RewardsList
{
    
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?passenger_id=%@",RewardsList_Url,User_Id];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
            respArray=[response objectForKey:@"reward_points"];
            ReedemPassPoints=[[response valueForKey:@"redeem_pass_points"]intValue];
            ReedemRidePoints=[[response valueForKey:@"redeem_ride_points"]intValue];
            [TB reloadData];
             
         }
         else
             
         {
             
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
             
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

#pragma  mark - Back_methods
#pragma mark -
-(IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - TableView_methods
#pragma mark -
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
    RewardHistoryCell *cell = [TB dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:cellNib owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
        
    }
    cell.backgroundColor=[UIColor clearColor];
    NSMutableDictionary *dict=[respArray objectAtIndex:indexPath.row];
    if ([[dict valueForKey:@"ep_type"] isEqualToString:@"1"])
    {
        cell.lblMinus.hidden=true;
    }
    else
    {
      cell.lblMinus.hidden=false;
    }
    
    cell.lblRupee.text=[NSString stringWithFormat:@"%@ Pts",[dict valueForKey:@"ep_points"] ];
    
    cell.lblMessage.text=[dict valueForKey:@"ep_remark"] ;
    
    cell.lblDateTime.text=[dict valueForKey:@"ep_datetime"] ;
    return cell;
    
    
    
    
}

#pragma  mark - Home_methods
#pragma mark -
- (IBAction)gohome:(id)sender
{
    DashboardVC *Cp = [[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
    
    
    
}

#pragma  mark - Home_methods
#pragma mark -
- (IBAction)sharePoints:(id)sender
{
    SharePointVC *Cp = [[SharePointVC alloc] initWithNibName:@"SharePointVC" bundle:nil];

    [self.navigationController pushViewController:Cp animated:YES];
    
}
#pragma  mark - Home_methods
#pragma mark -
- (IBAction)redeemPoints:(id)sender
{
   
    UIActionSheet *act=[[UIActionSheet alloc] initWithTitle:@"Select" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Daily Ride",@"Monthly Pass", nil];
    act.tag=1;
    [act showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1)
    {
        
        if (buttonIndex==0)
        {
            txtReedemRide.text=@"";
             a=totalRewardsPoints/ReedemRidePoints;
            lblDes.text=[NSString stringWithFormat:@"You Can Reddem Upto %d Rides Maximum.Enter Number Of Rides You Want To Redeem",a];
            shadow.hidden=false;
  
        }
        else if (buttonIndex==1)
        {
   
        }
       
        
    }
}


#pragma  mark - RedeemRidesSubmit_methods
#pragma mark -
- (IBAction)redeemPointsSubmit:(id)sender
{
    int b=[txtReedemRide.text intValue];
    if (b>a)
    {
        
        UIAlertView *ab=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please enter valid number of rides" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [ab show];
    }
    
    else
    {
        
        [self add_progress_view];
        NSString *str = [NSString stringWithFormat:@"%@?passenger_id=%@&rides=%@",RedeemRide_Url,User_Id,txtReedemRide.text];
        WebService *api = [WebService alloc];
        [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
         {
             [HUD hide:true];
             if ([[response objectForKey:@"status"] isEqualToString:@"true"])
             {
                 shadow.hidden=true;
                 UIAlertView *ab=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [ab show];
                 
                 
             }
             else
                 
             {
                 
                 UIAlertView *ab=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [ab show];
                 
                 
                 
             }
             
             
             
             
         }];
        
   
        
        
        
        
    }
    
}


#pragma  mark - CancelShadow_methods
#pragma mark -
- (IBAction)CancelShadow:(id)sender
{
    shadow.hidden=true;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
