//
//  Current_BookVC.m
//  Journe_Driver
//
//  Created by admin on 23/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "Current_BookVC.h"

@interface Current_BookVC ()


@end

@implementation Current_BookVC



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Current_BookVC";
            CellNib=@"CurrentCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Current_BookVC_4";
            CellNib=@"CurrentCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Current_BookVC_6";
            CellNib=@"CurrentCell_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Current_BookVC_6plus";
            CellNib=@"CurrentCell_6plus";
            
        }
    }
    else
    {
        nibName=@"Current_BookVC_ipad";
        CellNib=@"CurrentCell_ipad";
        
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
}



-(void)viewWillAppear:(BOOL)animated

{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    
    
}

#pragma  mark - getListing
#pragma  mark -
-(void)getBookingList
{
    
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?passenger_id=%@",CurrentBookings_Url,User_Id];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             respArray=[response objectForKey:@"booking_array"];
             [tbBookings reloadData];
             
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

#pragma  mark - HeaderMenuMethods
#pragma  mark -
-(IBAction)actionCurrentBook:(id)sender
{
    Current_BookVC *Cp = [[Current_BookVC alloc] initWithNibName:@"Current_BookVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:NO];
}

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
    CurrentCell *cell = [tbBookings dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:CellNib owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
        
    }
NSDictionary *di=[respArray objectAtIndex:indexPath.row];
cell.lblCancelled.hidden=true;
//cell.lblCancelled.text=[di valueForKey:@"status"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.lbl_date.hidden=true;
cell.lblDestinationTime.text=[di valueForKey:@"destination_time"];
cell.lblBusnumber.text=[di valueForKey:@"bus_no"];
cell.lblSourceTime.text=[di valueForKey:@"source_time"];
cell.txtDestinationAdd.text=[di valueForKey:@"destination"];
cell.txtSourceAdd.text=[di valueForKey:@"source"];
return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dict=[respArray objectAtIndex:indexPath.row];
    [def setObject:dict forKey:@"detailDict"];
    Detail_CBookVC *detailBook = [[Detail_CBookVC alloc]initWithNibName:@"Detail_CBookVC" bundle:nil];
    [self.navigationController pushViewController:detailBook animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}




@end
