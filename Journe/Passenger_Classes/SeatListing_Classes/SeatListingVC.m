//
//  SeatListingVC.m
//  Journe
//
//  Created by admin on 02/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "SeatListingVC.h"

@interface SeatListingVC ()

@end

@implementation SeatListingVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"SeatListingVC";
            seat4nib=@"SeatCell";
            seat5nib=@"Seater5Cell";
            seat6nib=@"Seater6Cell";
            selectedImg=@"selected_seat";
            availabelImg=@"available_seat";
            reservedImg=@"reserved_seat";
           
          
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"SeatListingVC_4";
            seat4nib=@"SeatCell";
            seat5nib=@"Seater5Cell";
            seat6nib=@"Seater6Cell";
            selectedImg=@"selected_seat";
            availabelImg=@"available_seat";
            reservedImg=@"reserved_seat";
      
           
            
          
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"SeatListingVC_6";
            seat4nib=@"SeatCell_6";
            seat5nib=@"Seater5Cell_6";
            seat6nib=@"Seater6Cell_6";
            selectedImg=@"selected_seat_i";
            availabelImg=@"available_seat_i";
            reservedImg=@"reserved_seat_i";
        
            
            
           
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"SeatListingVC_6plus";
            seat4nib=@"SeatCell_6plus";
            seat5nib=@"Seater5Cell_6plus";
            seat6nib=@"Seater6Cell_6plus";
            selectedImg=@"selected_seat_i";
            availabelImg=@"available_seat_i";
            reservedImg=@"reserved_seat_i";
     
          

            
        }
    }
    else
    {
        nibName=@"SeatListingVC_ipad";
        seat4nib=@"SeatCell_ipad";
        seat5nib=@"Seater5Cell_ipad";
        seat6nib=@"Seater6Cell_ipad";
        selectedImg=@"selected_seat_i";
        availabelImg=@"available_seat_i";
        reservedImg=@"reserved_seat_i";
      
       
        
       
        
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
    count=0;
    lbl_count.text=[NSString stringWithFormat:@"%d",count];
    SeatObjectsArr=[[NSMutableArray alloc]init];
     selectedSeatId=[[NSMutableArray alloc]init];
    SeatArray=[[NSMutableArray alloc]init];
    mainArray=[[NSMutableArray alloc]init];
    def=[NSUserDefaults standardUserDefaults];
    lbl_busNo.clipsToBounds = YES;
    lbl_busNo.layer.cornerRadius = lbl_busNo.frame.size.height/2.0f;
    [def objectForKey:@"SourceStopName"];
    [def objectForKey:@"DestiStopName"];
    NSMutableDictionary *d1=[def objectForKey:@"StopDict"];
    lbl_busNo.text=[d1 valueForKey:@"bus_no"];
    lblTiming.text=[NSString stringWithFormat:@"%@ - %@",[def objectForKey:@"SourceStopTime"],[def objectForKey:@"DestiStopTime"]];
    [self getSeatListing];
}

#pragma  mark - SettingSeat_view_methods
#pragma mark -

-(void)getSeatListing
{
NSMutableDictionary *d1=[def objectForKey:@"StopDict"];
NSString *tripId=[d1 valueForKey:@"trip_id"];
    
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?trip_id=%@&fromstop_Id=%@&tostop_Id=%@",SeatView_Url,tripId,[def objectForKey:@"SourceStopId"],
                     [def objectForKey:@"DestiStopId"]];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
   seatPrice=0;
   price=[[response objectForKey:@"price"]intValue];
    [def setObject:[response objectForKey:@"bus_id"] forKey:@"BusId"];
   reserveArray=[[NSMutableArray alloc]init];
   reserveArray=[response objectForKey:@"booked_seats"];
    NSMutableArray *rowarr=[response objectForKey:@"rows_array"];
    for (int i=0; i<[rowarr count]; i++)
    {
    NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
        NSMutableArray *MyArray=[[NSMutableArray alloc]init];
        NSMutableDictionary *dict1=[rowarr objectAtIndex:i];
            [d1 setObject:[dict1 valueForKey:@"row"] forKey:@"RowNo"];
            NSMutableArray *arr1=[dict1 valueForKey:@"seats"];
            for (int j=0; j<[arr1 count]; j++)
            {
      NSMutableDictionary *dict2=[arr1 objectAtIndex:j];
      NSMutableDictionary *mydict=[[NSMutableDictionary alloc]init];
                if ([reserveArray containsObject:[dict2 valueForKey:@"seat_no"]])
                {
                [mydict setObject:[dict2 valueForKey:@"seat_no"] forKey:@"seatID"];
                [mydict setObject:@"3" forKey:@"seatStatus"];
                }
        
                else if ([[dict2 valueForKey:@"seat_no"] isEqualToString:@"0"])
                {
                    
                    [mydict setObject:@"0" forKey:@"seatID"];
                    [mydict setObject:@"0" forKey:@"seatStatus"];
                }
                else
                {
                    
                    [mydict setObject:[dict2 valueForKey:@"seat_no"] forKey:@"seatID"];
                    [mydict setObject:@"1" forKey:@"seatStatus"];
                    
                }
                [MyArray addObject:mydict];
                [d1 setObject:MyArray forKey:@"seats"];
            
        }
                
        [mainArray addObject:d1];
        NSLog(@"MyArray=%@",mainArray);
        [tbSeat reloadData];

    }
             
        
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
- (IBAction)gohome:(id)sender
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
    return [mainArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    maindict=[mainArray objectAtIndex:indexPath.row];
    seatArr=[maindict objectForKey:@"seats"];
    if ([seatArr count]==4)
    {
        static NSString *simpleTableIdentifier = @"TableCellCustom";
        SeatCell *cell = [tbSeat dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            
            NSArray * nib = [[NSBundle mainBundle]loadNibNamed:seat4nib owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
        for (int i=0; i<[seatArr count]; i++)
        {
          dictseat=[seatArr objectAtIndex:i];
            if (i==0)
            {
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn1.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn1.enabled=false;
                    
                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn1 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn1 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn1 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn1 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn1 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn1.hidden=false;
                    cell.btn1.enabled=true;
                    
                }
            }
            if (i==1)
            {
                
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn2.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn2.enabled=false;
                    [cell.btn2 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn2 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn2 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn2 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn2 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn2 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn2.enabled=true;
                    cell.btn2.hidden=false;
                }
                
                
            }
            if (i==2)
            {
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn3.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn3.enabled=false;
                    [cell.btn3 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn3 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn3 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn3 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn3 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn3 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn3.hidden=false;
                    cell.btn3.enabled=true;
                    
                    
                }
                
                
            }
            if (i==3)
            {
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn4.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn4.enabled=false;
                    [cell.btn4 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn4 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn4 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn4 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn4 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn4 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn4.enabled=true;
                    cell.btn4.hidden=false;
                }
                
                
            }
            

        }
        
        
        
        cell.btn1.tag=indexPath.row;
        cell.btn2.tag=indexPath.row;

        cell.btn3.tag=indexPath.row;

        cell.btn4.tag=indexPath.row;

        [cell.btn1 addTarget:self action:@selector (selectSeat1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector (selectSeat2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector (selectSeat3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn4 addTarget:self action:@selector (selectSeat4:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    if ([seatArr count]==5)
    {
     
        
        static NSString *simpleTableIdentifier = @"TableCellCustom";
        Seater5Cell *cell = [tbSeat dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            
            NSArray * nib = [[NSBundle mainBundle]loadNibNamed:seat5nib owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        for (int i=0; i<[seatArr count]; i++)
        {
            dictseat=[seatArr objectAtIndex:i];
            if (i==0)
            {
            seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn1.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn1.enabled=false;
                   
                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn1 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn1 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn1 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn1 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn1 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn1.hidden=false;
                    cell.btn1.enabled=true;
                    
                }
            }
            if (i==1)
            {
                
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn2.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn2.enabled=false;
                    [cell.btn2 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn2 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn2 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn2 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn2 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn2 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn2.enabled=true;
                    cell.btn2.hidden=false;
                }

                
            }
            if (i==2)
            {
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn3.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn3.enabled=false;
                    [cell.btn3 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn3 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn3 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn3 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn3 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn3 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn3.hidden=false;
                    cell.btn3.enabled=true;
                   
                    
                }

                
            }
            if (i==3)
            {
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn4.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn4.enabled=false;
                    [cell.btn4 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn4 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn4 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn4 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn4 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn4 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn4.enabled=true;
                    cell.btn4.hidden=false;
                }
                
                
            }
            if (i==4)
            {
               
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn5.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn5.enabled=false;
                    [cell.btn5 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn5 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn5 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn5 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                       
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn5 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn5 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                    
                        
                    }
                    cell.btn5.enabled=true;
                    cell.btn5.hidden=false;
                }
                
            }
           
            
            
        }
        
        
            
        cell.btn1.tag=indexPath.row;
        cell.btn2.tag=indexPath.row;
        
        cell.btn3.tag=indexPath.row;
        
        cell.btn4.tag=indexPath.row;
        cell.btn5.tag=indexPath.row;
            
        [cell.btn1 addTarget:self action:@selector (selectSeat1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector (selectSeat2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector (selectSeat3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn4 addTarget:self action:@selector (selectSeat4:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn5 addTarget:self action:@selector (selectSeat5:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
        
        
        
    }
    else
    {
        
        static NSString *simpleTableIdentifier = @"TableCellCustom";
        Seater6Cell *cell = [tbSeat dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            
            NSArray * nib = [[NSBundle mainBundle]loadNibNamed:seat6nib owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        for (int i=0; i<[seatArr count]; i++)
        {
            dictseat=[seatArr objectAtIndex:i];
            if (i==0)
            {
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn1.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn1.enabled=false;
                    
                    [cell.btn1 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn1 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn1 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn1 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn1 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn1 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn1.hidden=false;
                    cell.btn1.enabled=true;
                    
                }
            }
            if (i==1)
            {
                
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn2.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn2.enabled=false;
                    [cell.btn2 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn2 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn2 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn2 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn2 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn2 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn2.enabled=true;
                    cell.btn2.hidden=false;
                }
                
                
            }
            if (i==2)
            {
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn3.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn3.enabled=false;
                    [cell.btn3 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn3 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn3 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn3 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn3 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn3 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn3.hidden=false;
                    cell.btn3.enabled=true;
                    
                    
                }
                
                
            }
            if (i==3)
            {
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn4.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn4.enabled=false;
                    [cell.btn4 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn4 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn4 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn4 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn4 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn4 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn4.enabled=true;
                    cell.btn4.hidden=false;
                }
                
                
            }
            if (i==4)
            {
                
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn5.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn5.enabled=false;
                    [cell.btn5 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn5 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                    
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn5 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn5 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn5 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn5 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                        
                    }
                    cell.btn5.enabled=true;
                    cell.btn5.hidden=false;
                }
                
            }
            if (i==5)
            {
                
                seatStatus=[dictseat valueForKey:@"seatStatus"];
                if ([seatStatus isEqualToString:@"0"])
                {
                    cell.btn6.hidden=true;
                }
                else if ([seatStatus isEqualToString:@"3"])
                {
                    cell.btn6.enabled=false;
                    [cell.btn6 setBackgroundImage:[UIImage imageNamed:reservedImg] forState:UIControlStateNormal];
                    [cell.btn6 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                }
                else
                {
                    if ([seatStatus isEqualToString:@"2"])
                    {
                        [cell.btn6 setBackgroundImage:[UIImage imageNamed:selectedImg] forState:UIControlStateNormal];
                        [cell.btn6 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    else if ([seatStatus isEqualToString:@"1"])
                    {
                        [cell.btn6 setBackgroundImage:[UIImage imageNamed:availabelImg] forState:UIControlStateNormal];
                        [cell.btn6 setTitle:[dictseat valueForKey:@"seatID"] forState:UIControlStateNormal];
                        
                    }
                    cell.btn6.hidden=false;
                    cell.btn6.enabled=true;
                }
                
            }

            
            
            
        }
        cell.btn1.tag=indexPath.row;
        cell.btn2.tag=indexPath.row;
        
        cell.btn3.tag=indexPath.row;
        
        cell.btn4.tag=indexPath.row;
        cell.btn5.tag=indexPath.row;
        cell.btn6.tag=indexPath.row;
        [cell.btn1 addTarget:self action:@selector (selectSeat1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector (selectSeat2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector (selectSeat3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn4 addTarget:self action:@selector (selectSeat4:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn5 addTarget:self action:@selector (selectSeat5:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn6 addTarget:self action:@selector (selectSeat6:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
 
        
    }
}
#pragma mark - BookSeat_methods
#pragma mark -
-(void)selectSeat1:(id)sender
{
  

    maindict=[mainArray objectAtIndex:[sender tag]];
    seatArr=[maindict valueForKey:@"seats"];
    dictseat=[seatArr objectAtIndex:0];
    NSString *status=[dictseat valueForKey:@"seatStatus"];
    if ([status isEqualToString:@"1"])
    {
    count=count+1;
    lbl_count.text=[NSString stringWithFormat:@"%d",count];
    [dictseat setObject:@"2" forKey:@"seatStatus"];
    [selectedSeatId addObject:[dictseat valueForKey:@"seatID"]];
    lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
    finalPrice=[NSString stringWithFormat:@"%d",price*count];
    
    }
    else if ([status isEqualToString:@"2"])
    {
        count=count-1;

        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

       [dictseat setObject:@"1" forKey:@"seatStatus"];
        if ([selectedSeatId containsObject:[dictseat valueForKey:@"seatID"]])
        {
            [selectedSeatId removeObject:[dictseat valueForKey:@"seatID"]];
      
            
        }
        
    }
    if (count==0)
    {
        btnDone.enabled=false;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#303030"];
    }
    else
    {
        btnDone.enabled=true;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#389844"];
        
    }
    [tbSeat reloadData];

}
-(void)selectSeat2:(id)sender
{
  
    maindict=[mainArray objectAtIndex:[sender tag]];
    seatArr=[maindict valueForKey:@"seats"];
    dictseat=[seatArr objectAtIndex:1];
    NSString *status=[dictseat valueForKey:@"seatStatus"];
    if ([status isEqualToString:@"1"])
    {
        
        count=count+1;
        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        [dictseat setObject:@"2" forKey:@"seatStatus"];
         [selectedSeatId addObject:[dictseat valueForKey:@"seatID"]];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

        
    }
    else if ([status isEqualToString:@"2"])
    {
        count=count-1;
        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

        [dictseat setObject:@"1" forKey:@"seatStatus"];
        if ([selectedSeatId containsObject:[dictseat valueForKey:@"seatID"]])
        {
            [selectedSeatId removeObject:[dictseat valueForKey:@"seatID"]];
            
        }
        
    }
    if (count==0)
    {
        btnDone.enabled=false;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#303030"];
    }
    else
    {
        btnDone.enabled=true;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#389844"];
        
    }
    [tbSeat reloadData];

    
    
}
-(void)selectSeat3:(id)sender
{
    if (count==0)
    {
        btnDone.enabled=false;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"303030"];
    }
    else
    {
        btnDone.enabled=true;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"303030"];
        
    }
    maindict=[mainArray objectAtIndex:[sender tag]];
    seatArr=[maindict valueForKey:@"seats"];
    dictseat=[seatArr objectAtIndex:2];
    NSString *status=[dictseat valueForKey:@"seatStatus"];
    if ([status isEqualToString:@"1"])
    {
      
        count=count+1;
        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

        [dictseat setObject:@"2" forKey:@"seatStatus"];
        [selectedSeatId addObject:[dictseat valueForKey:@"seatID"]];
        
    }
    else if ([status isEqualToString:@"2"])
    {
        count=count-1;
        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

        [dictseat setObject:@"1" forKey:@"seatStatus"];
        if ([selectedSeatId containsObject:[dictseat valueForKey:@"seatID"]])
        {
            [selectedSeatId removeObject:[dictseat valueForKey:@"seatID"]];
         
        }
        
    }
    if (count==0)
    {
        btnDone.enabled=false;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#303030"];
    }
    else
    {
        btnDone.enabled=true;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#389844"];
        
    }
    [tbSeat reloadData];
    
}
-(void)selectSeat4:(id)sender
{
  maindict=[mainArray objectAtIndex:[sender tag]];
    seatArr=[maindict valueForKey:@"seats"];
    dictseat=[seatArr objectAtIndex:3];
    NSString *status=[dictseat valueForKey:@"seatStatus"];
    if ([status isEqualToString:@"1"])
    {
      
        count=count+1;
        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

        [dictseat setObject:@"2" forKey:@"seatStatus"];
        [selectedSeatId addObject:[dictseat valueForKey:@"seatID"]];
        
    }
    else if ([status isEqualToString:@"2"])
    {
        count=count-1;
        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

        [dictseat setObject:@"1" forKey:@"seatStatus"];
        if ([selectedSeatId containsObject:[dictseat valueForKey:@"seatID"]])
        {
            [selectedSeatId removeObject:[dictseat valueForKey:@"seatID"]];
        }
        
        
    }
    if (count==0)
    {
        btnDone.enabled=false;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#303030"];
    }
    else
    {
        btnDone.enabled=true;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#389844"];
        
    }
    [tbSeat reloadData];

    
    
    
}
-(void)selectSeat5:(id)sender
{

    maindict=[mainArray objectAtIndex:[sender tag]];
    seatArr=[maindict valueForKey:@"seats"];
    dictseat=[seatArr objectAtIndex:4];
    NSString *status=[dictseat valueForKey:@"seatStatus"];
    if ([status isEqualToString:@"1"])
    {
      
        count=count+1;
        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

        [dictseat setObject:@"2" forKey:@"seatStatus"];
         [selectedSeatId addObject:[dictseat valueForKey:@"seatID"]];
        
    }
    else if ([status isEqualToString:@"2"])
    {
        count=count-1;
        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

        [dictseat setObject:@"1" forKey:@"seatStatus"];
        if ([selectedSeatId containsObject:[dictseat valueForKey:@"seatID"]])
        {
            [selectedSeatId removeObject:[dictseat valueForKey:@"seatID"]];
        }
        
        
    }
    if (count==0)
    {
        btnDone.enabled=false;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#303030"];
    }
    else
    {
        btnDone.enabled=true;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#389844"];
        
    }
    [tbSeat reloadData];

    
    
}
-(void)selectSeat6:(id)sender
{

    
    maindict=[mainArray objectAtIndex:[sender tag]];
    seatArr=[maindict valueForKey:@"seats"];
    dictseat=[seatArr objectAtIndex:5];
    NSString *status=[dictseat valueForKey:@"seatStatus"];
    if ([status isEqualToString:@"1"])
    {
       
        count=count+1;
        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

        [dictseat setObject:@"2" forKey:@"seatStatus"];
         [selectedSeatId addObject:[dictseat valueForKey:@"seatID"]];
       
    }
    else if ([status isEqualToString:@"2"])
    {
        count=count-1;
        lbl_count.text=[NSString stringWithFormat:@"%d",count];
        lblPrice.text=[NSString stringWithFormat:@"Rs.%d.00",price*count];
        finalPrice=[NSString stringWithFormat:@"%d",price*count];

        [dictseat setObject:@"1" forKey:@"seatStatus"];
        if ([selectedSeatId containsObject:[dictseat valueForKey:@"seatID"]])
        {
            [selectedSeatId removeObject:[dictseat valueForKey:@"seatID"]];
        }
        
    }
    
    if (count==0)
    {
        btnDone.enabled=false;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#303030"];
    }
    else
    {
        btnDone.enabled=true;
        btnDone.backgroundColor=[HexColorToUIColor colorFromHexString:@"#389844"];
        
    }
    [tbSeat reloadData];

    
    
}
#pragma  mark - Back_view_methods
#pragma mark -
-(IBAction)go_back:(id)sender
{
[self.navigationController popViewControllerAnimated:TRUE];
    
}



#pragma  mark - Back_view_methods
#pragma mark -
-(IBAction)booking_details:(id)sender
{
    if (count==0)
    {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please Select Seats.." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
    }
    else
    {
NSLog(@"seatidArray%@",selectedSeatId);
 [def setObject:[NSString stringWithFormat:@"%d",price] forKey:@"seatCost"];
[def setObject:selectedSeatId forKey:@"seatIdArray"];
[def setObject:finalPrice forKey:@"FinalseatPrice"];
BookingDetailsVC *nav = [[BookingDetailsVC alloc]initWithNibName:@"BookingDetailsVC" bundle:nil];
    
[self.navigationController pushViewController:nav animated:YES];
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
