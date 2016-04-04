//  Dvr_Daily_ListVC.m
//  Journe_Driver
//  Created by admin on 18/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.


#import "Dvr_Daily_ListVC.h"

@interface Dvr_Daily_ListVC ()

@end

@implementation Dvr_Daily_ListVC

@synthesize tblDailyList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Dvr_Daily_ListVC";
             cellNib=@"Dvr_KiloMTVCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Dvr_Daily_ListVC_4";
             cellNib=@"Dvr_KiloMTVCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Dvr_Daily_ListVC_6";
             cellNib=@"Dvr_KiloMTVCell_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Dvr_Daily_ListVC_6plus";
             cellNib=@"Dvr_KiloMTVCell_6plus";
            
        }
    }
    else
    {
        nibName=@"Dvr_Daily_ListVC_ipad";
         cellNib=@"Dvr_KiloMTVCell_ipad";
        
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
    driverDict=[def objectForKey:@"LoginDriverDict"];
    driverID=[driverDict valueForKey:@"driver_id"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d.M.yyyy";
    currentDate = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    lbl_date.text=[NSString stringWithFormat:@"%ld",(long)day];
    selected_dict=[[NSMutableDictionary alloc] init];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self getDaily_Listing];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- Listingmethods
#pragma mark-

- (void)getDaily_Listing
{
    
    [self add_progress_view];
    WebService *api = [WebService alloc];
    NSString *url= [NSString stringWithFormat:@"%@?driver_id=%@&date=%@",DailyRideList,driverID,currentDate];
    
    [api call_API:url OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
             
         {
             ArrayList = [response valueForKey:@"km_list"];
             [tblDailyList reloadData];
             
         }
         else
         {
             ArrayList=[[NSMutableArray alloc]init];
             [tblDailyList reloadData];
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
     }];
}


#pragma mark - picker_methods
#pragma mark -
- (IBAction)selectDOB:(id)sender
{
    [shadowView setHidden:false];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    [dataPicker setDate:[NSDate date]];
    [UIView animateWithDuration:0.2f animations:^{
        dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,self.view.frame.size.height-dataPickerView.frame.size.height,dataPickerView.frame.size.width,dataPickerView.frame.size.height);
    }];
    
    
}
- (IBAction)dateSelected:(id)sender
{
    CGRect screenSize=[[UIScreen mainScreen]bounds];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd-MM-YYYY"];
    currentDate=[format stringFromDate:dataPicker.date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"dd"];
    lbl_date.text=[format1 stringFromDate:dataPicker.date];
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
    [self getDaily_Listing];
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

#pragma mark- BACK_methods
#pragma mark-
-(IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- SaveHeaderTapped_methods
#pragma mark-
-(IBAction)actionWeekly:(id)sender
{
    DvrWeekendListVC *startJourny = [[DvrWeekendListVC alloc]initWithNibName:@"DvrWeekendListVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:NO];
}

-(IBAction)actionDaily:(id)sender
{
    
    Dvr_Daily_ListVC *startJourny = [[Dvr_Daily_ListVC alloc]initWithNibName:@"Dvr_Daily_ListVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:NO];
    
    
}

-(void)gotoDvr_KilomtrVC
{
    
}

-(IBAction)addDailyRide:(id)sender
{
    Dvr_KiloMetrVC *startJourny = [[Dvr_KiloMetrVC alloc]initWithNibName:@"Dvr_KiloMetrVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:NO];
}

#pragma mark- TableView_methods
#pragma mark-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return ArrayList.count;
    
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
    
    
    NSMutableDictionary *dict=[ArrayList objectAtIndex:indexPath.row];
    
    cell.lblStartLocation.text = [dict valueForKey:@"from"];
    cell.lblEndLocation.text = [dict valueForKey:@"to"];
    cell.lblStartTiime.text = [dict valueForKey:@"start"];
    cell.lblEndTime.text = [dict valueForKey:@"end"];
    cell.lblOpeningKm.text= [NSString stringWithFormat:@"%@ Kms",[dict valueForKey:@"start_kms"]];
    cell.lblClosingKm.text = [NSString stringWithFormat:@"%@ Kms",[dict valueForKey:@"end_kms"]];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSMutableDictionary *dict=[ArrayList objectAtIndex:indexPath.row];
    [def setObject:dict forKey:@"km_selected"];
    [def synchronize];
    Dvr_KiloMetrVC *startJourny = [[Dvr_KiloMetrVC alloc]initWithNibName:@"Dvr_KiloMetrVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:NO];
}




@end
