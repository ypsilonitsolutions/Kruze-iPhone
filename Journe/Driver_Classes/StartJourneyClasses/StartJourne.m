//
//  DashboardVC.m
//  Journe
//
//  Created by admin on 20/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "StartJourne.h"

@interface StartJourne ()

@end

@implementation StartJourne
@synthesize routeTable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"StartJourne";
            cell_nib=@"Dashboard_cell";
            rowHieght=44;
            headerHieght=65;
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"StartJourne_4";
            cell_nib=@"Dashboard_cell";
            rowHieght=44;
            headerHieght=65;
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"StartJourne_6";
            cell_nib=@"Dashboard_cell_6";
            rowHieght=55;
            headerHieght=70;
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"StartJourne_6plus";
            cell_nib=@"Dashboard_cell_6plus";
            rowHieght=60;
            headerHieght=70;
            
        }
    }
    else
    {
        nibName=@"StartJourne_ipad";
        cell_nib=@"Dashboard_cell_ipad";
        rowHieght=70;
        headerHieght=75;
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
    arrayForBool=[[NSMutableArray alloc] init];
    reachStatus=[[NSMutableArray alloc] init];
    userDict=[[NSMutableDictionary alloc]init];
    nsud=[NSUserDefaults standardUserDefaults];
    ResponseArray=[[NSMutableArray alloc] init];
    StopNameArr=[[NSMutableArray alloc] init];
    StopArray=[[NSMutableArray alloc] init];
    userDict=[nsud objectForKey:@"LoginDriverDict"];
    driverId=[userDict objectForKey:@"driver_id"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d.M.yyyy";
    lbl_date.text = [formatter stringFromDate:[NSDate date]];
    
    
}


#pragma mark - Table view header methods
#pragma mark -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return rowHieght;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return headerHieght;
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView ;
    UILabel *headerString;
    UILabel *status;
    UIImageView *imageview;
    UILabel *Substring;
    UIFont *myFont;
    UIFont *myFont1;
    headerView.tag=section;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            headerView      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, routeTable.frame.size.width,60)];
            imageview     =[[UIImageView alloc] initWithFrame:CGRectMake(325, 14, 25, 25)];
            
            myFont = [UIFont systemFontOfSize:18.0];
            myFont1 = [UIFont systemFontOfSize:13.0];
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            headerView      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, routeTable.frame.size.width,60)];
            imageview     =[[UIImageView alloc] initWithFrame:CGRectMake(360,16,25,25)];
            myFont = [UIFont systemFontOfSize:18.0];
            myFont1 = [UIFont systemFontOfSize:13.0];
            
        }
        else
        {
            headerView     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, routeTable.frame.size.width,60)];
            imageview     =[[UIImageView alloc] initWithFrame:CGRectMake(270,14,25,25)];
            myFont = [UIFont systemFontOfSize:15.0];
            myFont1 = [UIFont systemFontOfSize:12.0];
            
        }
    }
    else
    {
        headerView      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, routeTable.frame.size.width,40)];
        imageview     =[[UIImageView alloc] initWithFrame:CGRectMake(routeTable.frame.size.width-30,16,25,25)];
        myFont = [UIFont systemFontOfSize:21.0];
        myFont1 = [UIFont systemFontOfSize:14.0];
    }
    
    headerView.tag = section;
    
    headerView.backgroundColor= [UIColor whiteColor];
    headerView.layer.borderColor=sky_blue_color;
    headerView.layer.borderWidth=1.0f;
    headerView.layer.cornerRadius=3.0;
    headerView.layer.masksToBounds=YES;
    
    
    
    
    headerString  = [[UILabel alloc] initWithFrame:CGRectMake(15, 6, headerView.frame.size.width-15, 25)];
    Substring  = [[UILabel alloc] initWithFrame:CGRectMake(15, 23, 210, 25)];
    status=[[UILabel alloc] initWithFrame:CGRectMake(15, 40, 210, 25)];
    
    headerString.numberOfLines = 1;
    Substring.numberOfLines = 1;
    [headerString setFont:myFont];
    [Substring setFont:myFont1];
    [status setFont:myFont1];
    
    NSMutableDictionary *dict2=[ResponseArray objectAtIndex:section];
    
    NSString *tr_id=[dict2 objectForKey:@"trip_id"];
    
    [headerString setBackgroundColor:[UIColor clearColor]];
    [Substring setBackgroundColor:[UIColor clearColor]];
    [status setBackgroundColor:[UIColor clearColor]];
    
    headerString.text=[NSString stringWithFormat:@"%@",[dict2 objectForKey:@"bus_route_title"]];
    
    Substring.text=[NSString stringWithFormat:@"%@-%@",[dict2 objectForKey:@"trip_start_time"],[dict2 objectForKey:@"trip_end_time"]];
    NSString *current_status=[dict2 objectForKey:@"complete_status"];
    
        if ([current_status isEqualToString:@"0"])
        {
           status.text=@"Not Started Yet";
           status.textColor  = text_gray1_color;
        }
        else if ([current_status isEqualToString:@"1"])
        {
           status.text=@"Completed";
           status.textColor  = completed_text_color;
        }
    
        else if ([current_status isEqualToString:@"2"])
        {
           status.text=@"Running";
           status.textColor  = running_text_color;
        }
        else if ([current_status isEqualToString:@"3"])
        {
        status.text=@"Cancelled";
        status.textColor  = text_gray1_color;
        }
    
    headerString.textAlignment = NSTextAlignmentLeft;
    
    headerString.textColor  = text_gray_color;
    
    [headerView addSubview:headerString];
    
    Substring.textAlignment = NSTextAlignmentLeft;
    
    Substring.textColor  = text_gray_color;
    
    [headerView addSubview:status];
    
    [headerView addSubview:Substring];
    
    imageview.image=[UIImage imageNamed:@"down_arrow.png"];
    
    [headerView addSubview:imageview];
    
    UITapGestureRecognizer  *headerTapped  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    
    [headerView addGestureRecognizer:headerTapped];
    
    
    UILongPressGestureRecognizer *longGesture =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(logPressed:)];
    longGesture.minimumPressDuration=1;
    [headerView addGestureRecognizer:longGesture];
    
    return headerView;
    
}

-(void)logPressed:(UILongPressGestureRecognizer*)gesture
{
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gesture.view.tag];
        NSDictionary *dictstop=[ResponseArray objectAtIndex:indexPath.section];
        int tripid=[[dictstop objectForKey:@"trip_id"] intValue];
        
        cv=[CancelView cancelViewSet];
        [self.view addSubview:cv];
        cv.alpha=0;
        cv.layer.borderWidth=2.0f;
        cv.layer.borderColor=sky_blue_color;
        cv.frame=CGRectMake(0, -cv.frame.size.height, cv.frame.size.width, cv.frame.size.height);
        
        cv.txtDescription.layer.borderWidth=1.0;
        cv.txtDescription.layer.cornerRadius=8.0;
        cv.txtDescription.layer.borderColor=sky_blue_color;
        
        cv.txtDescription.delegate=self;
        
        [UIView animateWithDuration:.8 animations:^{
            cv.alpha=1;
            cv.frame=CGRectMake(0, (self.view.frame.size.height/2)-(cv.frame.size.height/2), cv.frame.size.width, cv.frame.size.height);
        }];
        cv.trip_name.text=[NSString stringWithFormat:@"%@",[dictstop objectForKey:@"bus_route_title"]];
        cv.cancel.tag=indexPath.section;
        [cv.cancel addTarget:self action:@selector(cancel_trip_view_cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        cv.submit.tag=tripid;
        [cv.submit addTarget:self action:@selector(cancel_trip_view_SubmitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
  
}

#pragma mark -textViewDelegate
#pragma mark -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Description..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Description...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}


-(void)cancel_trip_view_cancelBtn:(id)sender
{
    [cv removeFromSuperview];
}

-(void)cancel_trip_view_SubmitBtn:(id)sender
{
    NSLog(@"trip id - %ld",(long)[sender tag]);
    NSString *trp=[NSString stringWithFormat:@"%d",[sender tag] ];
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?driver_id=%@&trip_id=%@&reason=%@",cancel_trip_API,driverId,trp,cv.txtDescription.text];
    str=[str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             [self getRoutesList];
             [cv removeFromSuperview];
         }
         else
         {
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Cruze" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [alert show];
         }
     }];
}



#pragma mark - gesture tapped
#pragma mark -

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    UIImageView *ArrowImage=[[UIImageView alloc]init];
    UIView *TappedView=(UIView *)gestureRecognizer.view;
    NSArray *ViewArray=[TappedView subviews];
    for (UIImageView *ArrImage in ViewArray)
    {
        ArrowImage=ArrImage;
    }
    NSLog(@"ImageTag %ld",(long)TappedView.tag);
    
    
    StopNameArr=[[NSMutableArray alloc] init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
     NSDictionary *dictstop=[ResponseArray objectAtIndex:indexPath.section];
    
    int trip_new=[[dictstop objectForKey:@"trip_id"] intValue];
    
    int trip=[current_trip_id intValue];
    if ((trip == 0 && indexPath.section==0) || trip==trip_new)
    {
    if (indexPath.row == 0)
    {
        
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        
        if (collapsed==NO)
        {
            ArrowImage.image=[UIImage imageNamed:@"up_arrow"];
            [TappedView addSubview:ArrowImage];
        }
        else
        {
            
            ArrowImage.image=[UIImage imageNamed:@"down_arrow.png"];
            
        }
        
        collapsed       = !collapsed;
        
        [arrayForBool enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BOOL isOpen=[obj boolValue];
            if (isOpen)
            {
                [arrayForBool replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:false]];
                NSRange range   = NSMakeRange(idx, 1);
                
                NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
                
                [routeTable reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
        
        [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        NSRange range   = NSMakeRange(indexPath.section, 1);
        
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        NSDictionary *dictstop=[ResponseArray objectAtIndex:indexPath.section];
        
        NSMutableArray *stopsArr=[dictstop objectForKey:@"trip_stops"];
        _key=[NSString stringWithFormat:@"reach_status_%d",(int)indexPath.section];
       //[nsud removeObjectForKey:_key];
        NSArray *arr=[nsud objectForKey:_key];
        if (arr==nil)
        {
            [self reachStatusSetting:_key andArray:stopsArr];
        }
        else if (arr.count==0)
        {
            [self reachStatusSetting:_key andArray:stopsArr];
        }
        else
        {
            reachStatus=[arr mutableCopy];
        }
        //[routeTable reloadData];
        
        
        
        
        [routeTable reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
        
    }
  }
}
#pragma mark - Tableview delegate methods
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return [ResponseArray count];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    
    NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
    d1=[ResponseArray objectAtIndex:section];
    StopArray=[d1 objectForKey:@"trip_stops"];
    if (arrayForBool.count>0)
    {
        if([[arrayForBool objectAtIndex:section] boolValue])
        {
            
            NSLog(@"%lu",(unsigned long)[StopArray count]);
            return [StopArray count];
        }
    }
    
    return 0;
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"TableCellCustom";
    Dashboard_cell *cell = [routeTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:cell_nib owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    NSLog(@"indexPathSectionCellforrowatindexpath %ld",(long)indexPath.row);
    
    NSDictionary *dictstop=[ResponseArray objectAtIndex:indexPath.section];
    
    trip_id=[dictstop objectForKey:@"trip_id"];
    
    bus_id=[dictstop objectForKey:@"trip_bus_id"];
    
    StopArray=[dictstop objectForKey:@"trip_stops"];

    dict=[StopArray objectAtIndex:indexPath.row];
    
    for (int i=0; i<[StopArray count]; i++)
    {
        
        NSMutableDictionary *du=[StopArray objectAtIndex:i];
        NSString *stopname=[du objectForKey:@"stop_name"];
        [StopNameArr addObject:stopname];
        
    }
    cell.lbl_location_name.text=[dict objectForKey:@"stop_name"];
    //*******************************************************//
    NSString *curntStopId=[dict objectForKey:@"t_stop_id"];
    NSDictionary *lastStop=[StopArray lastObject];
    NSString *lastStopId=[lastStop objectForKey:@"t_stop_id"];
    
    cell.btn_reach.tag=indexPath.row;
    
    
    if (indexPath.row==0)
    {
        cell.img_location.image=[UIImage imageNamed:@"location_icon.png"];
    }
    else if(indexPath.row==(StopArray.count-1))
    {
        cell.img_location.image=[UIImage imageNamed:@"destination_icon.png"];
        cell.btn_reach.hidden=true;
    }

    //*********************************************************//
    if ([current_stop_id isEqualToString:@"0"] && indexPath.row==0)
    {
        if ([shouldShowNext isEqualToString:@"0"])
        {
        cell.btn_reach.hidden=false;
        [cell.btn_reach setTitle:@"Start" forState:UIControlStateNormal];
        [cell.btn_reach addTarget:self action:@selector(didPressReachButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
        cell.btn_reach.hidden=false;
        [cell.btn_reach setTitle:@"Next" forState:UIControlStateNormal];
        [cell.btn_reach addTarget:self action:@selector(nextTapped:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    else if ([current_stop_id isEqualToString:lastStopId]&&indexPath.row==[StopArray count]-1)
    {
        cell.btn_reach.hidden=false;
        [cell.btn_reach setTitle:@"Stop" forState:UIControlStateNormal];
        [cell.btn_reach addTarget:self action:@selector(stop_trip:) forControlEvents:UIControlEventTouchUpInside];
    }
   else if ([current_stop_id isEqualToString:curntStopId])
    {
        if ([shouldShowNext isEqualToString:@"0"])
        {
        cell.btn_reach.hidden=false;
        [cell.btn_reach setTitle:@"Reach" forState:UIControlStateNormal];
        [cell.btn_reach addTarget:self action:@selector(didPressReachButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
        cell.btn_reach.hidden=false;
        [cell.btn_reach setTitle:@"Next" forState:UIControlStateNormal];
        [cell.btn_reach addTarget:self action:@selector(nextTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        }
        cell.img_location.image=[UIImage imageNamed:@"circle_i"];
    }
    
    NSLog(@"%ld",(long)indexPath.row);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)nextTapped:(UIButton*)sender
{
    int ind=(int)[sender tag];
    [self reachedAtStop:ind];
}



-(void)startTapped:(id)sender
{
    [routeTable reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self getRoutesList];
//    NSString *keys=[nsud objectForKey:@"pressed_key"];
//    if (keys!=nil)
//    {
//        NSArray *arr=[nsud objectForKey:keys];
//        if (arr!=nil)
//        {
//            reachStatus=[arr mutableCopy];
//            [nsud setObject:reachStatus forKey:keys];
//            [routeTable reloadData];
//        }
//    }
    shouldShowNext=[nsud objectForKey:@"shouldShowNext"];
    
    if (shouldShowNext==nil)
    {
        shouldShowNext=@"0";
    }
}




-(void)didPressReachButton:(id)sender
{
    
    NSDictionary *d=[StopArray objectAtIndex:[sender tag]];
    
    stop_id =[d objectForKey:@"t_stop"];
    
    [nsud setObject:stop_id forKey:@"stop_id"];
    
    [nsud setObject:bus_id forKey:@"bus_id"];
    
    [nsud setObject:trip_id forKey:@"trip_id"];
    
    [nsud synchronize];
    
    
    
    QRCodeClass *qc=[[QRCodeClass alloc] initWithNibName:@"QRCodeClass" bundle:nil];
    
    [self.navigationController pushViewController:qc animated:YES];
}



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.transform = CGAffineTransformMakeScale(0.5, 0.5);
//    [UIView animateWithDuration:0.7 animations:^{
//        cell.transform = CGAffineTransformIdentity;
//    }];
}

#pragma mark - StopReach method
-(void)reachedAtStop:(int)index
{
    NSDictionary *d=[StopArray objectAtIndex:index+1];
    NSString *nextStopId=[d objectForKey:@"t_stop_id"];
    NSDictionary *d1=[StopArray objectAtIndex:index];
    NSDictionary *d2=[StopArray lastObject];
    NSString *last;
    if ([d1 isEqualToDictionary:d2])
    {
     last=@"1";
        
     NSLog(@"objects matched");
    }
    stop_id=[d1 objectForKey:@"t_stop_id"];
    [self add_progress_view];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"d.M.yyyy";
    
    NSString *date = [formatter stringFromDate:[NSDate date]];
   
    NSString *str = [NSString stringWithFormat:@"%@?driver_id=%@&trip_id=%@&stop_id=%@&reach_time=%@&last=%@",reachStopURL,driverId,trip_id,stop_id,date,last];

    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:YES];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             [nsud setObject:@"0" forKey:@"shouldShowNext"];
             shouldShowNext=@"0";
             current_stop_id=nextStopId;
             [routeTable reloadData];
         }
     }];
}


#pragma mark - StopReach method
-(void)stop_trip:(id)index
{
    [self add_progress_view];
    NSLog(@"%d",[index tag]);
    NSDictionary *d1=[StopArray objectAtIndex:[index tag]];
    stop_id=[d1 objectForKey:@"t_stop_id"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d.M.yyyy";
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSString *str = [NSString stringWithFormat:@"%@?driver_id=%@&trip_id=%@&stop_id=%@&reach_time=%@",reachStopURL,driverId,trip_id,stop_id,date];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:YES];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             [nsud setObject:@"0" forKey:@"shouldShowNext"];
             [self getRoutesList];
         }
     }];
}




#pragma mark- RouteListing_methods
#pragma mark-
-(void)getRoutesList
{
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?driver_id=%@",BusRoute_Url,driverId];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             current_trip_id=[response objectForKey:@"trip_id"];
             
             current_stop_id=[NSString stringWithFormat:@"%@", [response objectForKey:@"stop_id"] ];
             if (![current_stop_id isEqualToString:@"0"])
             {
                 int i=[current_stop_id intValue];
                 current_stop_id=[NSString stringWithFormat:@"%d",i+1];
                 [cv removeFromSuperview];
             }
             ResponseArray=[NSMutableArray new];
             ResponseArray=[response objectForKey:@"trip_list"];
             
             arrayForBool=[NSMutableArray new];
             for (int i=0;i<ResponseArray.count;i++)
             {
                 
              [arrayForBool addObject:[NSNumber numberWithBool:NO]];
                 
             }
             [routeTable reloadData];
            
             
         }
         else
             
         {
             ResponseArray=[[NSMutableArray alloc] init];
             StopNameArr=[[NSMutableArray alloc] init];
             StopArray=[[NSMutableArray alloc] init];
             [routeTable reloadData];
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
     }];
}



-(void)reachStatusSetting:(NSString*)keys andArray:(NSMutableArray*)array
{
    reachStatus=[NSMutableArray new];
    for (int i=0; i<array.count; i++)
    {
        if (i==0)
        {
            [reachStatus addObject:@"1"];
        }
        else
        {
            [reachStatus addObject:@"0"];
        }
    }
    [nsud setObject:reachStatus forKey:keys];
    [nsud synchronize];
}


#pragma mark- Back_methods
#pragma mark-
-(IBAction)actionBack:(id)sender
{

  [self.navigationController popViewControllerAnimated:YES];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
