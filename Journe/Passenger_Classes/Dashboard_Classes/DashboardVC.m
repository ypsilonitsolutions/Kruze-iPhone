//
//  DashboardVC.m
//  Journe
//
//  Created by admin on 20/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "DashboardVC.h"

@interface DashboardVC ()

@end

@implementation DashboardVC
@synthesize routeTable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"DashboardVC";
            cell_nib=@"RouteCell";

            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"DashboardVC_4";
            cell_nib=@"RouteCell";
       
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"DashboardVC_6";
            cell_nib=@"RouteCell_6";
   
   
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"DashboardVC_6plus";
            cell_nib=@"RouteCell_6plus";
 
            
        }
    }
    else
    {
        nibName=@"DashboardVC_ipad";
        cell_nib=@"RouteCell_ipad";
      
        
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
    city_array=[[NSMutableArray alloc] init];
    userDict=[[NSMutableDictionary alloc]init];
    nsud=[NSUserDefaults standardUserDefaults];
    ResponseArray=[[NSMutableArray alloc] init];
    landmarkArray=[[NSMutableArray alloc] init];
    tableLandmark.layer.masksToBounds=YES;
    tableLandmark.layer.cornerRadius=5;
    tableLandmark.layer.borderWidth=1;
    tableLandmark.layer.borderColor=sky_blue_color;
    locationManager = [[CLLocationManager alloc] init];
    NSString *ver = [[UIDevice currentDevice] systemVersion];
    float ver_float = [ver floatValue];
    
    if (ver_float >8.0)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    setCityId=[nsud objectForKey:@"CityId"];
    if (setCityId.length==0)
    {
        locationManager.delegate=self;
        
    }
    else
    {
        
        cityId=[nsud objectForKey:@"CityId"];
        LocType=@"2";
        latitude=@"";
        longitude=@"";
        
        
        
    }
}
-(void)viewWillAppear:(BOOL)animateds
{
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]])
    {
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString *locCheck=[nsud objectForKey:@"LocCheck"];
    if (locCheck!=nil)
    {
        [self setting_view];

    }
    
    
}


#pragma mark- MenuPanel_methods
#pragma mark-
- (IBAction)slider:(id)sender
{
    [self.view endEditing:true];
    [self.slidingViewController anchorTopViewTo:ECRight];
   
}
#pragma mark- SettingView_methods
#pragma mark-
-(void)setting_view
{
    [nsud removeObjectForKey:@"BookingId"];
    [nsud removeObjectForKey:@"ReturnSearch"];
    userDict=[nsud objectForKey:@"LoginUserDict"];
    [self getRoutesList];
    txtDestination.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Enter Destination" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    txtSource.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Your Location" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
}
#pragma mark - Tableview delegate methods
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
return 1;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (tableView==tableLandmark)
    {
        return [landmarkArray count];
    }
    else
    {
        
        return [ResponseArray count];
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==tableLandmark)
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
        RouteCell *cell = [routeTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            
            NSArray * nib = [[NSBundle mainBundle]loadNibNamed:cell_nib owner:self options:nil];
            cell = [nib objectAtIndex:0];
           
         
          
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSDictionary *dict=[ResponseArray objectAtIndex:indexPath.row];
        cell.lblBg.layer.borderWidth=1;
        cell.lblBg.layer.borderColor=sky_blue_color;
        cell.lblBg.layer.cornerRadius=3;
        cell.lblBg.layer.masksToBounds=YES;
        cell.lblName.text=[dict valueForKey:@"bus_route_title"];
        
        return cell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==tableLandmark)
    {
        
        NSMutableDictionary *dict=[landmarkArray objectAtIndex:indexPath.row];
        
        
        if ([tapCheck isEqualToString:@"source"])
        {
            txtSource.text=[dict valueForKey:@"landmark"];
            
            
        }
        else
        {
            txtDestination.text=[dict valueForKey:@"landmark"];
            
        }
        tableLandmark.hidden = true;
        tapCheck=@"";
        
    }
    else
    {
        NSDictionary *dict=[ResponseArray objectAtIndex:indexPath.row];
        selectedSource=[dict valueForKey:@"bus_route_from_title"];
        selectedDestination=[dict valueForKey:@"bus_route_to_title"];
        [nsud setObject:[dict valueForKey:@"bus_route_from_title"] forKey:@"searchTxt1"];
        [nsud setObject:[dict valueForKey:@"bus_route_to_title"] forKey:@"searchTxt2"];
        [nsud setObject:selectedSource forKey:@"SourceText"];
        [nsud setObject:selectedDestination forKey:@"DestinationText"];
        [nsud setObject:@"" forKey:@"RouteID"];
          [nsud setObject:@"2" forKey:@"SearchType"];
        SearchRouteVC *nav = [[SearchRouteVC alloc]initWithNibName:@"SearchRouteVC" bundle:nil];
        
        [self.navigationController pushViewController:nav animated:YES];
  
    
    }
}



#pragma mark- RouteListing_methods
#pragma mark-
-(void)getRoutesList
{
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?city_id=%@&type=%@&loc_lat=%@&loc_long=%@",Route_list_Url,cityId,LocType,latitude,longitude];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             NSMutableDictionary *dicti=[response objectForKey:@"city_details"];
             cityName=[dicti valueForKey:@"city_name"];
             cityId=[dicti valueForKey:@"city_id"];
             lbl_city.text=[dicti valueForKey:@"city_name"];
             ResponseArray=[response objectForKey:@"routes"];
             [routeTable reloadData];
             
         }
         else
             
         {
             lbl_city.text=[nsud objectForKey:@"CityName"];
             ResponseArray=[[NSMutableArray alloc] init];
             [routeTable reloadData];
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
         }
         [self getLandmarkList];
     }];
}

#pragma mark- LocationDelegate_methods
#pragma mark-
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusDenied)
    {
        cityId=@"8";
        LocType=@"2";
        latitude=@"";
        longitude=@"";
        NSString *key=[nsud objectForKey:@"LocCheck"];
        if (key==nil)
        {
            [nsud setObject:@"yes" forKey:@"LocCheck"];
            [self setting_view];
  
        }
        

        
    }
    else if ((status == kCLAuthorizationStatusAuthorized) || (status == kCLAuthorizationStatusAuthorizedAlways)  ||(status == kCLAuthorizationStatusAuthorizedWhenInUse))
    {
        
        
    float a = locationManager.location.coordinate.latitude;
    float b = locationManager.location.coordinate.longitude;
        latitude=[NSString stringWithFormat:@"%f",a];
        longitude=[NSString stringWithFormat:@"%f",b];
        LocType=@"1";
        lbl_city.text=cityName;
        NSString *key=[nsud objectForKey:@"LocCheck"];
        if (key==nil)
        {
            [nsud setObject:@"yes" forKey:@"LocCheck"];
            [self setting_view];
            
        }

    }
    
    
}
#pragma mark- LandMrkList_methods
#pragma mark-
-(void)getLandmarkList
{
    
    NSString *str = [NSString stringWithFormat:@"%@?city_id=%@",SearchLandmark_Url,cityId];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             
             searchArray=[response objectForKey:@"landmark_list"];
              [tableLandmark reloadData];
             
         }
         else
         {
             
             tableLandmark.hidden=TRUE;
             searchArray=[[NSMutableArray alloc] init];
             [tableLandmark reloadData];
             
             
             
         }
         
         
         
         
     }];
    
    
    
    
    
    
}



#pragma mark- Search_methods
#pragma mark-
-(IBAction)search_route:(id)sender
{
    [txtSource resignFirstResponder];
    [txtDestination resignFirstResponder];
    if (txtSource.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    
    else if (txtDestination.text.length==0){
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Destination" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    else
    {
        [nsud setObject:txtSource.text forKey:@"searchTxt1"];
        [nsud setObject:txtDestination.text forKey:@"searchTxt2"];
        [nsud setObject:txtSource.text forKey:@"SourceText"];
        [nsud setObject:txtDestination.text forKey:@"DestinationText"];
        [nsud setObject:@""forKey:@"RouteID"];
        [nsud setObject:@"2" forKey:@"SearchType"];
        [nsud setObject:cityId forKey:@"selectedCityId"];
        SearchRouteVC *nav = [[SearchRouteVC alloc]initWithNibName:@"SearchRouteVC" bundle:nil];
        InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        objISVC.topViewController = nav;
        [self.navigationController pushViewController:objISVC animated:YES];
    }
    
    
}

#pragma mark- hidetables
#pragma mark-
- (IBAction)sourceEnd:(id)sender
{
    [txtSource resignFirstResponder];
    [txtDestination resignFirstResponder];
    tableLandmark.hidden=TRUE;
}

- (IBAction)destiEnd:(id)sender
{
    [txtSource resignFirstResponder];
    [txtDestination resignFirstResponder];
    tableLandmark.hidden=TRUE;
}
#pragma mark- autocomplete_methods_methods
#pragma mark-
- (IBAction)sourceSearch:(id)sender
{
    
    if (txtSource.text.length==0||[txtSource.text isEqualToString:@""])
    {
        tableLandmark.hidden=TRUE;
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            tableLandmark.frame=CGRectMake(60, 106, 231, 150);
            
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            
            tableLandmark.frame=CGRectMake(61, 103, 299, 150);
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            tableLandmark.frame=CGRectMake(73, 116, 260, 185);
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            tableLandmark.frame=CGRectMake(92, 115, 279, 185);
            
        }
        else
        {
            tableLandmark.frame=CGRectMake(152, 165, 430, 200);
            
        }
        
        
        tapCheck=@"source";
        searchTxt=txtSource.text;
        //[self getLandmarkList];
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
            tableLandmark.hidden=TRUE;
            lblNoResult.hidden=false;
        }
        else
        {
            [tableLandmark reloadData];
            tableLandmark.hidden=false;
            lblNoResult.hidden=TRUE;
        }
    }
}

- (IBAction)destiSearch:(id)sender
{
    
    if (txtDestination.text.length==0||[txtDestination.text isEqualToString:@""])
    {
        tableLandmark.hidden=TRUE;
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            tableLandmark.frame=CGRectMake(60, 145, 231, 150);
            
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            
            tableLandmark.frame=CGRectMake(61, 142, 299, 150);
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            tableLandmark.frame=CGRectMake(73, 160, 260, 185);
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            tableLandmark.frame=CGRectMake(92, 167, 279, 185);
            
        }
        else
        {
            tableLandmark.frame=CGRectMake(152, 233, 430, 200);
            
        }
        tapCheck=@"desti";
        searchTxt=txtDestination.text;
        landmarkArray = [[NSMutableArray alloc]init];
        for (int i=0;i<searchArray.count;i++)
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            dict = [searchArray objectAtIndex:i];
            if(([[NSString stringWithFormat:@"%@ ",[dict objectForKey:@"landmark"]] rangeOfString:txtDestination.text options:(NSAnchoredSearch | NSCaseInsensitiveSearch)].location !=NSNotFound))
            {
                [landmarkArray addObject:dict];
                
            }
            
        }
        
        if (landmarkArray.count==0)
        {
            tableLandmark.hidden=TRUE;
            lblNoResult.hidden=false;
        }
        else
        {
            
            [tableLandmark reloadData];
            tableLandmark.hidden=false;
            lblNoResult.hidden=TRUE;
        }
        
        
        
        
        
        
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end