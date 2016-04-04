//
//  DvrWeekendListVC.m
//  Journe_Driver
//
//  Created by admin on 15/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "DvrWeekendListVC.h"
#import "Dvr_KiloMTVCell.h"

@interface DvrWeekendListVC ()

@end

@implementation DvrWeekendListVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"DvrWeekendListVC";
            cellNib=@"Dvr_KiloMTVCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"DvrWeekendListVC_4";
            cellNib=@"Dvr_KiloMTVCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"DvrWeekendListVC_6";
            cellNib=@"Dvr_KiloMTVCell_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"DvrWeekendListVC_6plus";
            cellNib=@"Dvr_KiloMTVCell_6plus";
            
        }
    }
    else
    {
        nibName=@"DvrWeekendListVC_ipad";
        cellNib=@"Dvr_KiloMTVCell_ipad";
        
    }
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    nsud=[NSUserDefaults standardUserDefaults];
    userdict=[nsud objectForKey:@"LoginDriverDict"];
    DriverId=[userdict objectForKey:@"driver_id"];
    [self weekendList];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Back_methods
#pragma mark-
-(IBAction)actionBack:(id)sender
{
    
    DriverDashVC *startJourny = [[DriverDashVC alloc]initWithNibName:@"DriverDashVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:YES];
    
    
}

#pragma mark- SaveHeaderTapped_methods
#pragma mark-
-(IBAction)btnDailyRide:(id)sender
{
    
    
    Dvr_Daily_ListVC *startJourny = [[Dvr_Daily_ListVC alloc]initWithNibName:@"Dvr_Daily_ListVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:NO];
    
}

-(IBAction)btnWeeklyRide:(id)sender

{

    DvrWeekendListVC *startJourny = [[DvrWeekendListVC alloc]initWithNibName:@"DvrWeekendListVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:NO];
    
}

#pragma mark- AddWeekendList_methods
#pragma mark-
-(IBAction)actionList:(id)sender{
    
    Dvr_KmWeekendVC *startJourny = [[Dvr_KmWeekendVC alloc]initWithNibName:@"Dvr_KmWeekendVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:NO];
    
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

#pragma mark- WeekendList
#pragma mark-

-(void)weekendList
{
    [self add_progress_view];
    WebService *api = [WebService alloc];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *today = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)day, (long)week, (long)year];
    
    
    NSString *url= [NSString stringWithFormat:@"%@?driver_id=%@&date=%@",Show_KiloM,DriverId,today];
    
    [api call_API:url OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])

         {
            _arryList = [response valueForKey:@"weekend_rides"];
             [_tblWeekend reloadData];
             
            
           }
         
         else
         {
             
             _arryList=[[NSMutableArray alloc]init];
             [_tblWeekend reloadData];
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
             
         }
     }];
}


# pragma mark - tableViewMethods
# pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return _arryList.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *CellIdentifier = @"listData";
    
    Dvr_KiloMTVCell *cell = (Dvr_KiloMTVCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellNib owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    

    NSMutableDictionary *dict=[_arryList objectAtIndex:indexPath.row];
    
    cell.lblStartLocation.text = [dict valueForKey:@"start_location"];
    cell.lblEndLocation.text = [dict valueForKey:@"end_location"];
    cell.lblStartTiime.text = [dict valueForKey:@"start_time"];
    cell.lblEndTime.text = [dict valueForKey:@"end_time"];
    cell.lblOpeningKm.text= [NSString stringWithFormat:@"%@ Kms",[dict valueForKey:@"opening_km"]];
    cell.lblClosingKm.text = [NSString stringWithFormat:@"%@ Kms",[dict valueForKey:@"closing_km"]];
    return cell;
    
}





@end
