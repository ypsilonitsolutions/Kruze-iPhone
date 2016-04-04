//
//  History_BookVC.m
//  Journe_Driver
//
//  Created by admin on 24/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "History_BookVC.h"
@interface History_BookVC ()

@end

@implementation History_BookVC



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"History_BookVC";
            CellNib=@"HistoryTVCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"History_BookVC_4";
            CellNib=@"HistoryTVCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"History_BookVC_6";
            CellNib=@"history_667";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"History_BookVC_6plus";
            CellNib=@"history_736";
            
        }
    }
    else
    {
        nibName=@"History_BookVC_ipad";
        CellNib=@"history_768";
        
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
    [self getBookingList];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated

{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
 
}
#pragma  mark - getListing
#pragma  mark -
-(void)getBookingList
{
    
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?passenger_id=%@",BookingHistory_Url,User_Id];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             respArray=[response objectForKey:@"booking_array"];
             [tblHistory reloadData];
             
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

#pragma  mark - MenuMethods
#pragma  mark -
-(IBAction)actionMenu:(id)sender
{
 [self.slidingViewController anchorTopViewTo:ECRight];
    [self.view endEditing:true];
}

#pragma  mark - HeaderMethods
#pragma  mark -
-(IBAction)actionCurrentBook:(id)sender
{
    Current_BookVC *Cp = [[Current_BookVC alloc] initWithNibName:@"Current_BookVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    [self.navigationController pushViewController:objISVC animated:NO];}

-(IBAction)actionHistoryBook:(id)sender
{
    History_BookVC *historyView = [[History_BookVC alloc]initWithNibName:@"History_BookVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = historyView;

    [self.navigationController pushViewController:objISVC animated:NO];
}


#pragma  mark - tableViewMethods
#pragma  mark -

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
    HistoryTVCell *cell = [tblHistory dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:CellNib owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
        
    }
    NSDictionary *di=[respArray objectAtIndex:indexPath.row];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.lblDestinationTime.text=[di valueForKey:@"destination_time"];
    cell.lblBusnumber.text=[di valueForKey:@"bus_no"];
    cell.lblSourceTime.text=[di valueForKey:@"source_time"];
    cell.LblDestinationAdd.text=[di valueForKey:@"destination"];
    cell.LblSourceAdd.text=[di valueForKey:@"source"];
    if ([[di valueForKey:@"status"] isEqualToString:@"Cancel"])
    {
    cell.lblCancelled.text=[di valueForKey:@"status"];
         cell.lblCancelled.textColor=[UIColor redColor];
        
    }
    else if ([[di valueForKey:@"status"] isEqualToString:@"Completed"])
    {
        cell.lblCancelled.text=[di valueForKey:@"status"];
        cell.lblCancelled.textColor=[HexColorToUIColor colorFromHexString:@"#379A62"];
        
    }
    else
    {
cell.lblCancelled.hidden=true;
    }
    cell.lbl_date.text=[di valueForKey:@"date"];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dict=[respArray objectAtIndex:indexPath.row];
    [def setObject:dict forKey:@"historydetailDict"];
    HistoryDetails *detailBook = [[HistoryDetails alloc]initWithNibName:@"HistoryDetails" bundle:nil];
    [self.navigationController pushViewController:detailBook animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
