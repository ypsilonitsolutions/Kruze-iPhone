//
//  Dvr_KiloMetrVC.m
//  Journe_Driver
//
//  Created by admin on 01/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "Dvr_KiloMetrVC.h"
#import "Dvr_DailyTVCell.h"

@interface Dvr_KiloMetrVC ()
{
   
    IBOutlet UIButton *btnSave;
    IBOutlet UITextField *txtStartKm;
    IBOutlet UITextField *txtEndKm;
    IBOutlet UIView *vwKm;
    IBOutlet UIButton *btnTime;
    IBOutlet UILabel *lblTripEndTm;
    NSArray *arryTime;
    NSString *strTripId;
  
}

@end

@implementation Dvr_KiloMetrVC{
     NSMutableArray *arrayForBool;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Dvr_KiloMetrVC_5";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Dvr_KiloMetrVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Dvr_KiloMetrVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Dvr_KiloMetrVC_6plus";
            
        }
    }
    else
    {
        nibName=@"Dvr_KiloMetrVC_ipad";
        
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
    [self setting_view];
    def=[NSUserDefaults standardUserDefaults];
    driverDict=[def objectForKey:@"LoginDriverDict"];
    DriverId=[driverDict valueForKey:@"driver_id"];
    
    NSDictionary *tripDict=[def objectForKey:@"km_selected"];
    if (tripDict==nil)
    {
        [self gettingTimingAPI];
    }
    else
    {
        btn_timing.enabled=false;
        lblTripEndTm.text = [NSString stringWithFormat:@"%@ - %@",[tripDict valueForKey:@"start"],[tripDict valueForKey:@"end"]];
        strTripId=[tripDict valueForKey:@"km_trip_id"];
        KmsType=@"2";
        
        NSString *endKm=[tripDict valueForKey:@"end_kms"];
        NSString *startKm=[tripDict valueForKey:@"start_kms"];
        
        if(startKm.length==0)
        {
            txtStartKm.enabled=true;
            txtEndKm.enabled=false;
        }
        else if(endKm.length==0)
        {
            txtStartKm.text=startKm;
            txtStartKm.enabled=false;
            txtEndKm.enabled=true;
        }
        else
        {
            txtStartKm.enabled=false;
            txtEndKm.enabled=false;
            txtStartKm.text=startKm;
            txtEndKm.text=endKm;
        }
        
    }
    
    self.mArrayRide = [[NSMutableArray alloc]init];
    self.tblDaily.hidden = YES;
    arrayForBool=[[NSMutableArray alloc]init];
    btn_timing.layer.cornerRadius=1;
    btn_timing.layer.masksToBounds=YES;
    btn_timing.layer.borderWidth=1;
    btn_timing.layer.borderColor=sky_blue_color;
    countCheck=[def objectForKey:@"CountCheck"];
}

#pragma mark- SettingView_methods
#pragma mark-
-(void)setting_view
{
    
    txtStartKm.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Start Kms" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtEndKm.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"End Kms" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
}



#pragma mark- Back_methods
#pragma mark-
-(IBAction)actionBack:(id)sender
{
    [def removeObjectForKey:@"km_selected"];
    [self.navigationController popViewControllerAnimated:false];
}



#pragma mark- Save_methods
#pragma mark-
-(IBAction)btnDailyRide:(id)sender
{
  Dvr_Daily_ListVC *startJourny = [[Dvr_Daily_ListVC alloc]initWithNibName:@"Dvr_Daily_ListVC" bundle:nil];
  [self.navigationController pushViewController:startJourny animated:NO];
}

#pragma mark- Save_methods
#pragma mark-
-(IBAction)btnWeeklyRide:(id)sender
{
    
  
    DvrWeekendListVC *startJourny = [[DvrWeekendListVC alloc]initWithNibName:@"DvrWeekendListVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:NO];
    
    
}
#pragma mark- Save_methods
#pragma mark-
-(IBAction)actionSave:(id)sender
{
    if (KmsType==nil)
    {
        KmsType=@"0";
    }
    
   if ([KmsType isEqualToString:@"1"] &&[txtStartKm.text isEqualToString:@""])
    {
        
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Enter Start Kms" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
    }
    else if ([KmsType isEqualToString:@"2"] && [txtEndKm.text isEqualToString:@""])
    {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Enter End Kms" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
    }
    else if ([KmsType isEqualToString:@"0"])
    {
        return;
    }
    else
    {
        txtEndKm.enabled=false;
        txtStartKm.enabled=true;
        if ([KmsType isEqualToString:@"1"])
        {
         Kms=txtStartKm.text;
        }else if ([KmsType isEqualToString:@"2"])
        {
            Kms=txtEndKm.text;
        }
        flag=0;
        [self submit_km];
    }
}


#pragma mark - API of gettingTiming
#pragma mark -
-(void)gettingTimingAPI
{
    WebService *api = [WebService alloc];
    
    NSString *url= [NSString stringWithFormat:@"%@?driver_id=%@",started_triplist_API,DriverId];
    
    [api call_API:url OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
            self.mArrayRide=[response valueForKey:@"trips"];
             [self.tblDaily reloadData];
         }
         else
         {
             self.mArrayRide=[[NSMutableArray alloc]init];
             [self.tblDaily reloadData];
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
     }];
}

#pragma mark - HideShowTableMethod
#pragma mark -
-(IBAction)actionTripTime:(id)sender
{
    
    if (!btnTime.selected)
    {
        
        vwKm.frame = CGRectMake(11, 270, 299, 227);
        self.tblDaily.hidden=NO;
        btnTime.selected = YES;
         btnTime.backgroundColor = [UIColor whiteColor];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            
        {
            if ([[UIScreen mainScreen] bounds].size.height==480)
                
            {
                vwKm.frame = CGRectMake(11, 270, 299, 227);
                self.tblDaily.hidden=NO;
                btnTime.selected = YES;
                btnTime.backgroundColor = [UIColor clearColor];
                
            }
            
           else if ([[UIScreen mainScreen] bounds].size.height==568)
                
            {
                
                vwKm.frame = CGRectMake(11, 315, 299, 227);
                self.tblDaily.hidden=NO;
                btnTime.selected = YES;
                btnTime.backgroundColor = [UIColor clearColor];
                
            }
            
            else if ([[UIScreen mainScreen] bounds].size.height==667)
                
            {
                
                vwKm.frame = CGRectMake(11, 340, 299, 227);
                self.tblDaily.hidden=NO;
                btnTime.selected = YES;
                btnTime.backgroundColor = [UIColor clearColor];
                
            }
            
            else if ([[UIScreen mainScreen] bounds].size.height==736)
                
            {
                
              
                vwKm.frame = CGRectMake(24, 350, 299, 227);
                self.tblDaily.hidden=NO;
                btnTime.selected = YES;
                btnTime.backgroundColor = [UIColor clearColor];
                
                
            }
            
           

            
        }
        else
            
        {
            vwKm.frame = CGRectMake(69, 400, 299, 227);
            self.tblDaily.hidden=NO;
            btnTime.selected = YES;
            btnTime.backgroundColor = [UIColor clearColor];
            
            
        }
       
    }else{
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            
        {
            if ([[UIScreen mainScreen] bounds].size.height==480)
                
            {
                vwKm.frame = CGRectMake(11, 167, 299, 227);
                self.tblDaily.hidden=YES;
                btnTime.selected = NO;
                btnTime.backgroundColor = [UIColor clearColor];
                
                
            }
            else if ([[UIScreen mainScreen] bounds].size.height==568)
                
            {
                
                vwKm.frame = CGRectMake(11, 177, 299, 227);
                self.tblDaily.hidden=YES;
                btnTime.selected = NO;
                btnTime.backgroundColor = [UIColor clearColor];
                
            }
            
            else if ([[UIScreen mainScreen] bounds].size.height==667)
                
            {
                
                vwKm.frame = CGRectMake(14, 196, 299, 227);
                self.tblDaily.hidden=YES;
                btnTime.selected = NO;

                btnTime.backgroundColor = [UIColor clearColor];
                
            }
            
            else if ([[UIScreen mainScreen] bounds].size.height==736)
                
            {
                
                
                vwKm.frame = CGRectMake(24, 205, 299, 227);
                self.tblDaily.hidden=YES;
                btnTime.selected = NO;

                btnTime.backgroundColor = [UIColor clearColor];
                
                
            }
            
          
            
            
        }
        else
            
        {
            vwKm.frame = CGRectMake(69, 350, 299, 227);
            self.tblDaily.hidden=YES;
            btnTime.selected = NO;
            
            btnTime.backgroundColor = [UIColor clearColor];
            
            
        }
        
   }

}



#pragma mark -  Submit_Api
#pragma mark -
-(void)submit_km
{
    NSString *str = [NSString stringWithFormat:@"%@?driver_id=%@&kms=%@&kms_type=%@&trip_id=%@",AddDailyKm,DriverId,Kms,KmsType,strTripId];
    
    WebService *api = [WebService alloc];
    
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
     }];
}




# pragma mark - table expand

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return self.mArrayRide.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *CellIdentifier = @"dailyid";
    Dvr_DailyTVCell *cell = (Dvr_DailyTVCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Dvr_DailyTVCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSMutableDictionary *dictionaryRide = [self.mArrayRide objectAtIndex:indexPath.row];
   cell.lblTimeDvr.text = [dictionaryRide valueForKey:@"trip_start_time"];
    cell.lbltimeEnd.text = [dictionaryRide valueForKey:@"trip_end_time"];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dictionaryRide = [self.mArrayRide objectAtIndex:indexPath.row];
    
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            
        {
            
            if ([[UIScreen mainScreen] bounds].size.height==480)
                
            {
                
                vwKm.frame = CGRectMake(11, 167, 299, 227);
               
                
            }
            else if ([[UIScreen mainScreen] bounds].size.height==568)
                
            {
                
                vwKm.frame = CGRectMake(11, 177, 299, 227);
             
          
            }
            
            else if ([[UIScreen mainScreen] bounds].size.height==667)
                
            {
                
                vwKm.frame = CGRectMake(14, 196, 299, 227);
                
                
            }
            
            else if ([[UIScreen mainScreen] bounds].size.height==736)
                
            {
                
                vwKm.frame = CGRectMake(24, 205, 299, 227);
                
                
            }
 
        }
        else
            
        {
            vwKm.frame = CGRectMake(69, 265, 299, 227);
            
        }
    NSArray *kms=[dictionaryRide objectForKey:@"kms"];
    NSDictionary *di1=[NSDictionary new];
    NSDictionary *di2=[NSDictionary new];
    NSString *endKm;
    NSString *startKm;
    if (kms.count==2)
    {
        di2=[kms lastObject];
        endKm=[di2 objectForKey:@"km_value"];
        
        di1=[kms firstObject];
        startKm=[di1 objectForKey:@"km_value"];
        KmsType=@"0";
    }
    else if (kms.count==0)
    {
        KmsType=@"1";
    endKm=@"";
      startKm=@"";
    }
    else if (kms.count==1)
    {
        KmsType=@"2";
        di1=[kms firstObject];
        startKm=[di1 objectForKey:@"km_value"];
    }
    
    if(startKm.length==0)
    {
        txtStartKm.enabled=true;
        txtEndKm.enabled=false;
    }
    else if(endKm.length==0)
    {
        txtStartKm.text=startKm;
        txtStartKm.enabled=false;
        txtEndKm.enabled=true;
    }
    else
    {
        txtStartKm.enabled=false;
        txtEndKm.enabled=false;
    }
    txtStartKm.text=startKm;
    txtEndKm.text=endKm;
    
    self.tblDaily.hidden=YES;
    btnTime.selected = NO;
    
    btnTime.backgroundColor = [UIColor clearColor];
    NSLog(@"%@",KmsType);
    lblTripEndTm.text = [NSString stringWithFormat:@"%@ - %@",[dictionaryRide valueForKey:@"trip_start_time"],[dictionaryRide valueForKey:@"trip_end_time"]];
    strTripId=[dictionaryRide valueForKey:@"trip_id"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
