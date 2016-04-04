//
//  SearchRouteVC.m
//  Journe
//
//  Created by admin on 25/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "SearchRouteVC.h"

@interface SearchRouteVC ()

@end

@implementation SearchRouteVC
@synthesize Table;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"SearchRouteVC";
            cell_nib=@"SerachRouteCell";
           
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"SearchRouteVC_4";
            cell_nib=@"SerachRouteCell";
         
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"SearchRouteVC_6";
            cell_nib=@"SerachRouteCell_6";
          
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"SearchRouteVC_6plus";
            cell_nib=@"SerachRouteCell_6plus";
           
            
        }
    }
    else
    {
        nibName=@"SearchRouteVC_ipad";
        cell_nib=@"SerachRouteCell_ipad";
      
        
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
    TripArray=[[NSMutableArray alloc]init];
    searchArray=[[NSMutableArray alloc]init];
source=[def objectForKey:@"SourceText"];
destination=[def objectForKey:@"DestinationText"];
    RouteID=[def objectForKey:@"RouteID"];
    SearchType=[def objectForKey:@"SearchType"];
    cityId=[def objectForKey:@"selectedCityId"];
    cityTable.layer.masksToBounds=YES;
    cityTable.layer.cornerRadius=5;
    cityTable.layer.borderWidth=1;
    cityTable.layer.borderColor=sky_blue_color;
    txtSource.text=[def objectForKey:@"searchTxt1"];
    txtDesti.text=[def objectForKey:@"searchTxt2"];;
    tableview_type=@"";
    [self getLandmarkList];
    
    if ([[def objectForKey:@"ReturnSearch"] isEqualToString:@"return"]) 
    {
        
        
        [self getReturnTripList];
        
        
        
    }
    else
        
    {
        [self getTripList];
   
        
        
    }
    
    
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- SettingView_methods
#pragma mark-
-(void)setting_view
{
    txtDesti.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Your Location" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    txtSource.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Enter Destination" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
}


-(void)getReturnTripList
{
    
    [self add_progress_view];

    NSString *str = [NSString stringWithFormat:@"%@?b_id=%@",ReturnTrip_Url,[def valueForKey:@"BookingId"]];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             TripArray=[response objectForKey:@"result"];
             [Table reloadData];
             
         }
         else
             
         {
             TripArray=[[NSMutableArray alloc]init];
             [Table reloadData];
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
             
         }
         
         
         
         
     }];
    
    
    
    
    
}
-(void)getTripList
{
    
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?type=%@&route_id=%@&from_stop=%@&to_stop=%@",SearchTrip_Url,SearchType,RouteID,source,destination];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             TripArray=[response objectForKey:@"result"];
            [Table reloadData];
             
         }
         else
             
         {
             TripArray=[[NSMutableArray alloc]init];
             [Table reloadData];
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
             
         }
         
         
         
         
     }];
    
 
    
    
    
}
#pragma mark- search_button_pressed_methods
#pragma mark-
-(IBAction)searchButton_pressed:(id)sender
{
  

    [txtSource resignFirstResponder];
    [txtDesti resignFirstResponder];
    if (txtSource.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    
    else if (txtDesti.text.length==0){
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Destination" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else
    {
       lblNoResult.hidden=TRUE;
source=txtSource.text;
destination=txtDesti.text;
        RouteID=@"";
        SearchType=@"2";
[self getTripList];
    }
    
  
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


#pragma mark- LandMrkList_methods
#pragma mark-
-(void)getLandmarkList
{
//    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?city_id=%@",SearchLandmark_Url,cityId];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
        // [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             
             searchArray=[response objectForKey:@"landmark_list"];
          
    
             
             
         }
         else
         {
             cityTable.hidden=true;
             searchArray=[[NSMutableArray alloc] init];
             [cityTable reloadData];
           //  UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Journe" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            // [a show];
             
             
         }
         
         
         
         
     }];
    
    
    
    
    
    
}


#pragma mark- MenuPanel_methods
#pragma mark-
- (IBAction)slider:(id)sender
{

    DashboardVC *Cp = [[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
  
}

#pragma mark - Tableview delegate methods
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if ([tableview_type isEqualToString:@"landmark"])
    {
        return [landmarkArray count];
    }
    else
    {
    return [TripArray count];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([tableview_type isEqualToString:@"landmark"])
    {
        
        UITableViewCell *celll=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        NSMutableDictionary *dict=[landmarkArray objectAtIndex:indexPath.row];
        celll.textLabel.textAlignment=UITextAlignmentCenter;
        celll.textLabel.font=[UIFont fontWithName:@"Roboto Regular" size:14.0];
        
        celll.textLabel.text=[NSString stringWithFormat: @"%@",[dict objectForKey:@"landmark"] ];
        return celll;
        
    }

    else
        
    {
    static NSString *simpleTableIdentifier = @"TableCellCustom";
    SerachRouteCell *cell = [Table dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:cell_nib owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    NSDictionary *di=[TripArray objectAtIndex:indexPath.row];
    NSDictionary *sourcedict=[di objectForKey:@"from_details"];
    NSDictionary *destidict=[di objectForKey:@"to_details"];
cell.lbl_source.text=[sourcedict valueForKey:@"bus_stop_name"];
 cell.lbl_Stiming.text=[sourcedict valueForKey:@"t_stop_time"];
  cell.lbl_desti.text=[destidict valueForKey:@"bus_stop_name"];
   cell.lbl_Dtiming.text=[destidict valueForKey:@"t_stop_time"];
    cell.lbl_cost.text=[NSString stringWithFormat:@"Rs.%@",[di valueForKey:@"price"]];
    cell.lbl_via.text=[NSString stringWithFormat:@"Via %@",[di valueForKey:@"via"]];
    cell.lbl_Seat.text=[NSString stringWithFormat:@"%@ Out of %@",[di valueForKey:@"available_seats"],[di valueForKey:@"total_seats"]];
        cell.lbl_busType.text=[di valueForKey:@"ac_type"];
    cell.lbl_busNo.text=[di valueForKey:@"bus_no"];
    [cell.btn_book setTag:indexPath.row];
    [cell.btn_book addTarget:self action:@selector (bookSeat:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    if ([tableview_type isEqualToString:@"landmark"])
    {
        
        NSMutableDictionary *dict=[landmarkArray objectAtIndex:indexPath.row];
        
        
        if ([tapCheck isEqualToString:@"source"])
        {
            txtSource.text=[dict valueForKey:@"landmark"];
            
            
        }
        else
        {
            txtDesti.text=[dict valueForKey:@"landmark"];
            
        }
        cityTable.hidden = true;
        tableview_type=@"";
        tapCheck=@"";
        
    }
    else
    {
        
        
        
    }
  
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.7 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - BookSeat_methods
#pragma mark -
-(void)bookSeat:(id)sender
{
    
NSMutableDictionary *dictu = [TripArray objectAtIndex:[sender tag]];
[def setObject:dictu forKey:@"StopDict"];
    [def setObject:txtSource.text forKey:@"landmarkSource"];
    [def setObject:txtDesti.text forKey:@"landmarkDesti"];
    StopListingVC *nav = [[StopListingVC alloc]initWithNibName:@"StopListingVC" bundle:nil];
    
    [self.navigationController pushViewController:nav animated:YES];
    
    
}
#pragma mark- hidetables
#pragma mark-
- (IBAction)sourceEnd:(id)sender
{
    [txtSource resignFirstResponder];
    [txtDesti resignFirstResponder];
    cityTable.hidden=TRUE;
}

- (IBAction)destiEnd:(id)sender
{
    [txtSource resignFirstResponder];
    [txtDesti resignFirstResponder];
  cityTable.hidden=TRUE;
}
#pragma mark- autocomplete_methods_methods
#pragma mark-l
- (IBAction)sourceSearch:(id)sender
{
    if (txtSource.text.length==0||[txtSource.text isEqualToString:@""])
    {
        cityTable.hidden=TRUE;
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
              cityTable.frame=CGRectMake(62, 104, 201, 170);
            
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            
            cityTable.frame=CGRectMake(61, 104, 199, 149);
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            cityTable.frame=CGRectMake(72, 122, 230, 181);
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            cityTable.frame=CGRectMake(91, 128, 231, 202);
            
        }
        else
        {
            cityTable.frame=CGRectMake(151, 167, 391, 200);
            
        }

      
    tapCheck=@"source";
    tableview_type=@"landmark";
    searchTxt=txtSource.text;
    landmarkArray = [[NSMutableArray alloc]init];
    for (int i=0;i<searchArray.count;i++)
    {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict = [searchArray objectAtIndex:i];
    if(([[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"landmark"]] rangeOfString:txtSource.text options:(NSAnchoredSearch | NSCaseInsensitiveSearch)].location !=NSNotFound))
    {
    [landmarkArray addObject:dict];
                    
    }
                
    }
        
        if (landmarkArray.count==0)
        {
            cityTable.hidden=TRUE;
            lblNoResult.hidden=false;
        }
        else
        {
            [cityTable reloadData];
            cityTable.hidden=false;
            lblNoResult.hidden=TRUE;
        }
    }
}

- (IBAction)destiSearch:(id)sender
{
    if (txtSource.text.length==0||[txtDesti.text isEqualToString:@""])
    {
        cityTable.hidden=TRUE;
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
           
            cityTable.frame=CGRectMake(62, 140, 201, 170);
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            
            cityTable.frame=CGRectMake(61, 137, 199, 149);
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            cityTable.frame=CGRectMake(72, 162, 230, 181);
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            cityTable.frame=CGRectMake(91, 163, 231, 202);
            
        }
        else
        {
            cityTable.frame=CGRectMake(151, 215, 391, 200);
            
        }
   
    tapCheck=@"desti";
    tableview_type=@"landmark";
     searchTxt=txtDesti.text;
        landmarkArray = [[NSMutableArray alloc]init];
        for (int i=0;i<searchArray.count;i++)
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            dict = [searchArray objectAtIndex:i];
            if(([[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"landmark"]] rangeOfString:txtDesti.text options:(NSAnchoredSearch | NSCaseInsensitiveSearch)].location !=NSNotFound))
            {
                [landmarkArray addObject:dict];
                
            }
            
        }
        
        if (landmarkArray.count==0)
        {
         cityTable.hidden=TRUE;
        lblNoResult.hidden=false;
        }
        else
        {
            [cityTable reloadData];
            cityTable.hidden=false;
            lblNoResult.hidden=TRUE;
        }
        
        
        
        
        
    
    }
   
    
}


@end
