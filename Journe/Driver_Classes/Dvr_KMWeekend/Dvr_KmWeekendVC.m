//  Dvr_KmWeekendVC.m
//  Journe_Driver
//  Created by admin on 06/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.


#import "Dvr_KmWeekendVC.h"
#import "Constant.h"
#import "Dvr_WeekendTVCell.h"

@interface Dvr_KmWeekendVC ()
@end

@implementation Dvr_KmWeekendVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Dvr_KmWeekendVC_5";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Dvr_KmWeekendVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Dvr_KmWeekendVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Dvr_KmWeekendVC_6plus";
            
        }
    }
    else
    {
        nibName=@"Dvr_KmWeekendVC_ipad";
        
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
     arryList = [NSArray arrayWithObjects:@"Empty",@"Pick Up",@"Drop", nil];
    btnStatus.layer.borderColor=sky_blue_color;
    btnStatus.layer.borderWidth=1;
    tableStatus.layer.borderColor=sky_blue_color;
    tableStatus.layer.borderWidth=1;
    def=[NSUserDefaults standardUserDefaults];
    driverDict=[def objectForKey:@"LoginDriverDict"];
    driverId=[driverDict valueForKey:@"driver_id"];
    [self setting_view];

}


#pragma mark- SettingView_methods
#pragma mark-
-(void)setting_view
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d.M.yyyy";
    currentDate = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    lblDate.text=[NSString stringWithFormat:@"%d",day];
    ScrolView.contentSize = CGSizeMake(ScrolView.frame.size.width,ScrolView.frame.size.height+350);
    
    txtVehicle.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Vehicle" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtVehiclType.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Vehicle Type" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtStartLocation.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Start Location" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtEndLocation.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"End Location" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtStartTiime.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Start Time" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtEndTime.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"End Time" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtOpeningKm.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Opening Km" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtClosingKm.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Closing Km" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtTotalKm.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Total Km" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtDutyH.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Duty Hours" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bgView.backgroundColor=[UIColor clearColor];
    
    //table=[[UITableView alloc] initWithFrame:CGRectMake(((self.view.frame.size.width)/2)/2, (self.view.frame.size.height)/3, txtVehiclType.frame.size.width, ((self.view.frame.size.height)/2)/2)];
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(txtVehiclType.frame.origin.x, lbl_company.frame.origin.y , txtVehiclType.frame.size.width, ((self.view.frame.size.height)/2)/2)];
    
    
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    table.layer.borderWidth=1.0f;
    table.layer.borderColor=sky_blue_color;
    table.dataSource=self;
    table.delegate=self;
    [_companyName addTarget:self action:@selector(selectCompany) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:table];
    bgView.hidden=true;
    
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedGesture:)];
    [bgView addGestureRecognizer:gesture];
    [ScrolView addSubview:bgView];
    [self gettingTimingAPI];
}

-(void)tappedGesture:(UIGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:table];
    
    NSIndexPath *theIndexPath = [table indexPathForRowAtPoint:point];
    if (theIndexPath)
    {
        NSDictionary *d=[companyArray objectAtIndex:theIndexPath.row];
        NSString *name=[d objectForKey:@"company_name"];
        companyID=[d objectForKey:@"company_id"];
        [_companyName setTitleColor:text_gray_color forState:UIControlStateNormal];
        
        [_companyName setTitle:name forState:UIControlStateNormal];
        bgView.hidden=true;
        isCompanyShow=!isCompanyShow;
    }
    else
    {
        bgView.hidden=true;
        isCompanyShow=!isCompanyShow;
    }
   
}



-(void)selectCompany
{
    isCompanyShow=!isCompanyShow;
    [self.view endEditing:YES];
    if (isCompanyShow)
    {
        bgView.hidden=false;
        [table reloadData];
    }
    else
    {
        bgView.hidden=true;
    }
}



#pragma mark - API of gettingTiming
#pragma mark -

-(void)gettingTimingAPI
{
    companyArray=[[NSMutableArray alloc] init];
    WebService *api = [WebService alloc];
    
    NSString *url= [NSString stringWithFormat:@"%@?",CompanyListURL];
    
    [api call_API:url OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     
     {
         
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             
             companyArray=[response valueForKey:@"companies"];
             [table reloadData];
         }
         else
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
     }];
}




#pragma mark- BAck_methods
#pragma mark-
-(IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:false];
}

#pragma mark - picker_methods
#pragma mark -
- (IBAction)selectStatrtTime:(id)sender
{
    timetapped=@"start";
    [shadowView setHidden:false];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    [dataPicker setDate:[NSDate date]];
    [UIView animateWithDuration:0.2f animations:^{
        dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,self.view.frame.size.height-dataPickerView.frame.size.height,dataPickerView.frame.size.width,dataPickerView.frame.size.height);
    }];
    
    
}
- (IBAction)selectEndTime:(id)sender
{
    timetapped=@"end";
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
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    SelectdDate=[outputFormatter stringFromDate:dataPicker.date];
    if ([timetapped isEqualToString:@"start"])
    {
        txtStartTiime.text=SelectdDate;
        
    }
    if ([timetapped isEqualToString:@"end"])
    {
       txtEndTime.text=SelectdDate;
    }
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


#pragma mark- HeaderMethods_methods
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

# pragma mark -SaveRide
# pragma mark -
-(IBAction)saveRide:(id)sender
{
    
    
    if ([self saveValidation])
    {
        
        [self kmWeekendApi];
    }
    
    
    
    
}
-(BOOL)saveValidation
{
    
    BOOL isValid = false;
    if (txtVehicle.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Vehicle" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
    }
    else if (txtVehiclType.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Vehicle type" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
    }
    else if (txtStartLocation.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Start Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
        
    }
    else if (txtEndLocation.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter End Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
        
    }
    else if (txtStartTiime.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Start Time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
    }
    else if (txtEndTime.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter End Time" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
    }
    else if (txtOpeningKm.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Opening Km" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
    }
    else if (txtClosingKm.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Closing Km" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
    }
    else if (txtTotalKm.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Total Km" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
    }
    else if (txtDutyH.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Duty Hours" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
    }
    else if (stausSelected.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Select Status" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
    }
    else
    {
        isValid = true;
    }
    
    return isValid;
}

# pragma mark -CallSaveAPI
# pragma mark -
-(void)kmWeekendApi
{
    NSString *str = [NSString stringWithFormat:@"%@?vehicle=%@&vehicle_type=%@&start_location=%@&end_location=%@&start_time=%@&end_time=%@&opening_km=%@&closing_km=%@&total_km=%@&driver_id=%@&weekend_ride_status=%@&duty_hours=%@&company_id=%@",AddWeekendRide,txtVehicle.text,txtVehiclType.text,txtStartLocation.text,txtEndLocation.text,txtStartTiime.text,txtEndTime.text,txtOpeningKm.text,txtClosingKm.text,txtTotalKm.text,driverId,stausSelected,txtDutyH.text,companyID];
    
    WebService *api = [WebService alloc];
    
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Kruze" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
         else
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Kruze" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
     }];
}


# pragma mark - StatusButtonTapped
# pragma mark -
-(IBAction)statusTapped:(id)sender
{
    if (infoTap==false)
    {
        imgArrow.image=[UIImage imageNamed:@"up_arrow"];
        tableStatus.hidden=false;
        infoTap=true;
        
    }
    else
    {
        
        infoTap=false;
        tableStatus.hidden=true;
        [tableStatus reloadData];
        imgArrow.image=[UIImage imageNamed:@"down_arrow.png"];
        
    }
 
}
# pragma mark - tableViewMethods
# pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (tableView==table)
    {
        return companyArray.count;
    }
    else return arryList.count;
   
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (tableView==table)
    {
    NSDictionary *d=[companyArray objectAtIndex:indexPath.row];
    cell.textLabel.text=[d objectForKey:@"company_name"];
    }
    else
    {
    cell.textLabel.text=[arryList objectAtIndex:indexPath.row];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:14.0];
   return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
if (tableView==table)
 {
        
    NSDictionary *d=[companyArray objectAtIndex:indexPath.row];
    NSString *name=[d objectForKey:@"company_name"];
    companyID=[d objectForKey:@"company_id"];
    [_companyName setTitleColor:text_gray_color forState:UIControlStateNormal];
    
    [_companyName setTitle:name forState:UIControlStateNormal];
     bgView.hidden=true;
     isCompanyShow=!isCompanyShow;
 }
else
 {
    [btnStatus setTitle:[NSString stringWithFormat:@" %@",[arryList objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    if (indexPath.row==0)
    {
    stausSelected=@"1";
    }
   else if (indexPath.row==1)
    {
     stausSelected=@"2";
    }
    else if (indexPath.row==2)
    {
      stausSelected=@"3";
        
    }
    
    tableStatus.hidden=true;
    
    infoTap=false;
 }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
