//
//  StopListingVC.m
//  Journe
//
//  Created by admin on 12/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "StopListingVC.h"

@interface StopListingVC ()

@end

@implementation StopListingVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"StopListingVC";
            cell_nib=@"StopCell";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"StopListingVC_4";
            cell_nib=@"StopCell";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"StopListingVC_6";
            cell_nib=@"StopCell_6";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"StopListingVC_6plus";
            cell_nib=@"StopCell_6plus";
            
            
        }
    }
    else
    {
        nibName=@"StopListingVC_ipad";
        cell_nib=@"StopCell_ipad";
        
        
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
    // Do any additional setup after loading the view from its nib
    StopArray=[[NSMutableArray alloc]init];
    CellArray=[[NSMutableArray alloc]init];
    statusArray=[[NSMutableArray alloc]init];
    def=[NSUserDefaults standardUserDefaults];
    lbl_busNO.clipsToBounds = YES;
    lbl_busNO.layer.cornerRadius = lbl_busNO.frame.size.height/2.0f;
    b_to=false;
    b_from=false;
    to=-1;
    from=-1;
    [self getStopList];
}
-(void)getStopList
{
    NSMutableDictionary *d1=[def objectForKey:@"StopDict"];
    tripId=[d1 valueForKey:@"trip_id"];
    NSMutableDictionary *d2=[d1 objectForKey:@"from_details"];
   // FromId=[d2 valueForKey:@"t_stop"];
lblSource.text=[d2 valueForKey:@"bus_stop_name"];
     NSMutableDictionary *d3=[d1 objectForKey:@"to_details"];
    //ToId=[d3 valueForKey:@"t_stop"];
    lblDesti.text=[d3 valueForKey:@"bus_stop_name"];
    lbl_busNO.text=[d1 valueForKey:@"bus_no"];
    [self add_progress_view];
NSString *str = [NSString stringWithFormat:@"%@?trip_id=%@",StopList_Url,tripId];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             StopArray=[response objectForKey:@"stop_list"];
             for (int i=0; i<[StopArray count]; i++)
             {
                 [statusArray addObject:@"0"];
             }
             [tbStop reloadData];
             
         }
         else
             
         {
             StopArray=[[NSMutableArray alloc]init];
             [tbStop reloadData];
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
#pragma mark - Tableview delegate methods
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return [StopArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
  
        static NSString *simpleTableIdentifier = @"TableCellCustom";
        StopCell *cell = [tbStop dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            
            NSArray * nib = [[NSBundle mainBundle]loadNibNamed:cell_nib owner:self options:nil];
            cell = [nib objectAtIndex:0];
            [CellArray addObject:cell];

            
        }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSMutableDictionary *dict=[StopArray objectAtIndex:indexPath.row];
    
    if ([[dict valueForKey:@"reach_status"] isEqualToString:@"1"])
    {
        cell.lblhide.hidden=false;
    }
    
    else
    {
      cell.lblhide.hidden=true;
        
    }
    cell.lblName.text=[dict valueForKey:@"bus_stop_name"];
    cell.lblTime.text=[dict valueForKey:@"t_stop_time"];
    if(from==indexPath.row)
    {
       cell.img_loc.image=[UIImage imageNamed:@"location_green_i-1.png"];
        selectedSource=[dict valueForKey:@"bus_stop_name"];
        S_Id=[dict valueForKey:@"t_stop"];
        S_time=[dict valueForKey:@"t_stop_time"];
        
    }
    else if(to==indexPath.row)
    {
    cell.img_loc.image=[UIImage imageNamed:@"location_red.png"];
        selectedDestination=[dict valueForKey:@"bus_stop_name"];
        D_Id=[dict valueForKey:@"t_stop"];
         D_Time=[dict valueForKey:@"t_stop_time"];
    }
    else
    {
cell.img_loc.image=[UIImage imageNamed:@"location_white.png"];
       
       
    }
        if (from==-1)
        {
            selectedSource=@"";
            S_Id=@"";
            S_time=@"";
    
        }
        else if (to==-1)
        {
            selectedDestination=@"";
            D_Id=@"";
            D_Time=@"";
            
        }
    
        return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict=[StopArray objectAtIndex:indexPath.row];
    if ([[dict valueForKey:@"reach_status"] isEqualToString:@"1"])
    {
       
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Bus Already Leave That Stop.." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
       
    }
    
    else
    {
            if(from==indexPath.row)
            {
                from=-1;
            }
            else if(to==indexPath.row)
            {
                to=-1;
            }
            else if(from==-1&&to==-1)
            {
                from=indexPath.row;
            }
            else if(indexPath.row>from)
            {
                if(to==-1)
                {
                    to=indexPath.row;
                }
                else if(indexPath.row>(to-from-1)/2)
                {
                    to=indexPath.row;
                }
                else
                {
                    from=indexPath.row;
                }
            }
            else
            {
                if(to==-1)
                {
                    to = from;
                    from = indexPath.row;
                }
                else
                {
                    from=indexPath.row;
                }
            }
            
       
    [tbStop reloadData];
    }
    
  
}


#pragma  mark - SelectSeat_methods
#pragma mark -

- (IBAction)selectSeat:(id)sender
{
    if ([selectedDestination isEqualToString:@""]||[selectedSource isEqualToString:@""])
    {
        
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please select source and destination" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
  
        
    }
    else
    {
    NSLog(@"SelectedSource=%@",selectedSource);
    NSLog(@"SelectedDestination=%@",selectedDestination);
        NSLog(@"SourceId=%@",S_Id);
        NSLog(@"DestinationId=%@",D_Id);
        
        [def setObject:S_Id forKey:@"SourceStopId"];
        [def setObject:D_Id forKey:@"DestiStopId"];
        [def setObject:S_time forKey:@"SourceStopTime"];
        [def setObject:D_Time forKey:@"DestiStopTime"];
        [def setObject:selectedSource forKey:@"SourceStopName"];
        [def setObject:selectedDestination forKey:@"DestiStopName"];
    SeatListingVC *nav = [[SeatListingVC alloc]initWithNibName:@"SeatListingVC" bundle:nil];
    
    [self.navigationController pushViewController:nav animated:YES];
    }
    
    
    
    
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
#pragma  mark - Back_methods
#pragma mark -
- (IBAction)gotoBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
