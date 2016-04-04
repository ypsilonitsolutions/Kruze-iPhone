
//  Dvr_CashVC.m
//  Journe_Driver
//  Created by admin on 02/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.

#import "Dvr_CashVC.h"
#import "Dvr_CashTVCell.h"
@interface Dvr_CashVC ()<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UILabel *lblPayment;
     IBOutlet UILabel *lblDate;
     NSMutableArray *arrayForBool;
}

@property (weak, nonatomic) IBOutlet UITableView *tblCash;

@end

@implementation Dvr_CashVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Dvr_CashVC_5";
            cellNib=@"cashId";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Dvr_CashVC";
            cellNib=@"cashId";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Dvr_CashVC_6";
            cellNib=@"cashId_667";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Dvr_CashVC_6plus";
            cellNib=@"cashId_736";
        }
    }
    else
    {
        nibName=@"Dvr_CashVC_ipad";
        cellNib=@"cashId_768";
    }
    
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    dateHeader.text=[NSString stringWithFormat:@"%ld",(long)day];
    
    
    
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    
    [dateformate setDateFormat:@"dd/MM/YYYY"];
    
    NSString *date_String=[dateformate stringFromDate:[NSDate date]];
    
    NSString *strDAte = @"Date: ";
    
    NSString *strDateValu = [strDAte stringByAppendingString:date_String];
    
    
    NSLog(@"%@",strDateValu);
    
    
    
    lblDate.text = strDateValu;
    
    NSDateFormatter *dateformate1=[[NSDateFormatter alloc]init];
    
    [dateformate1 setDateFormat:@"dd-MM-YYYY"];
    
    NSString *date_String1=[dateformate1 stringFromDate:[NSDate date]];

    
    
    
    [self CashA_Dvr_Api:date_String1];
    
    arrayForBool=[[NSMutableArray alloc]init];
    
    for (int i=0;i<4;i++)
    {
        [arrayForBool addObject:[NSNumber numberWithBool:NO]];
    }
    self.mArayDetail=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    
  
    //------
    
    UINib *nib=[UINib nibWithNibName:@"Dvr_CashTVCell" bundle:nil];
    
    [self.tblCash registerNib:nib forCellReuseIdentifier:@"cashId"];
    
    UINib *nib_667=[UINib nibWithNibName:@"Dvr_CashTVCell_6" bundle:nil];
    
    [self.tblCash registerNib:nib_667 forCellReuseIdentifier:@"cashId_667"];
    
    UINib *nib_736=[UINib nibWithNibName:@"Dvr_CashTVCell_6plus" bundle:nil];
    
    [self.tblCash registerNib:nib_736 forCellReuseIdentifier:@"cashId_736"];
    
    UINib *nib_768=[UINib nibWithNibName:@"Dvr_CashTVCell_ipad" bundle:nil];
    
    [self.tblCash registerNib:nib_768 forCellReuseIdentifier:@"cashId_768"];
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
-(IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- API for Cash --
-(void)CashA_Dvr_Api:(NSString*)date
{
    [self add_progress_view];
    NSUserDefaults *nsud=[NSUserDefaults standardUserDefaults];
   NSDictionary *userDict=[nsud objectForKey:@"LoginDriverDict"];
   NSString *driverId=[userDict objectForKey:@"driver_id"];
    WebService *api = [WebService alloc];
    NSString *url= [NSString stringWithFormat:@"%@?driver_id=%@&user_date=%@",Cash_Api,driverId,date];
    self.mArrayCash=[NSMutableArray new];
    self.mArayDetail=[NSMutableArray new];
   // arrayForBool=[NSMutableArray new];
    //[self.tblCash reloadData];
    
    [api call_API:url OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     
     {
         [HUD hide:YES];
         NSString *st=[response objectForKey:@"status"];
         
         if ([st isEqualToString:@"true"])
             
         {
             self.mArrayCash=[response valueForKey:@"trip_list"];
             
             int total = 0;
             
             for (int i=0; self.mArrayCash.count>i ; i++) {
                 
                 NSMutableDictionary *dict  = [self.mArrayCash objectAtIndex:i];
                 
                 NSMutableArray *arrayDetail = [dict valueForKey:@"passenger_details"];
                 
                 for (int j = 0; arrayDetail.count>j; j++)
                 {
                    
                     NSMutableDictionary *dict1  = [arrayDetail objectAtIndex:j];
                     
                     NSString *strAmount = [dict1 valueForKey:@"amount"];
                     
                     total = total + [strAmount intValue];
                     
                 }
             }
             if (total!=0)
             {
           lblPayment.text = [@"Rs." stringByAppendingString:[NSString stringWithFormat:@"%d",total] ];      
             }

             
             NSLog(@"%@",response);
           //  strTripId = [self.mArrayRide valueForKey:@"trip_id"];
           //  NSLog( @"%@",strTripId);
             [self.tblCash reloadData];
         }else
         {
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Kruze" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [alert show];
             lblPayment.text=@"";
             self.mArrayCash=[NSMutableArray new];
             [self.tblCash reloadData];
         }
     }];
}


# pragma mark - table expand

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.mArrayCash.count;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if([[arrayForBool objectAtIndex:section] boolValue])
    {
        return self.mArayDetail.count;
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *CellIdentifier = @"cashId";
    
    Dvr_CashTVCell *cell = (Dvr_CashTVCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellNib owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    NSMutableDictionary *dictDetail = [self.mArayDetail objectAtIndex:indexPath.row];
    
    
  //  NSMutableDictionary *dict = self.mArayDetail objectAtIndex:
        cell.lblName.text = [dictDetail valueForKey:@"passenger_name"];
        cell.lblPrice.text = [dictDetail valueForKey:@"amount"];
        
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        
        return 60;
        
    }
    
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 65;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section



{
    
    UIView *headerView ;
    
    
    
    UILabel *headerString;
    
    
    
    UILabel *headerAdd;
    
    
    
    UILabel *cashLbl;
    
    
    
    UILabel *lblStartTm;
    
    
    
    UILabel *lblEndTm;
    
    
    
    UIImageView *imageview ;
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        
        
        
    {
        
        
        
        if ([[UIScreen mainScreen] bounds].size.height==667)
            
            
            
        {
            
            
            
            headerView      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self
                                                                       
                                                                       .tblCash.frame.size.width,40)];
            
            
            
            imageview     =[[UIImageView alloc] initWithFrame:CGRectMake(325, 14, 25, 25)];
            
            
            
        }
        
        
        
        else if ([[UIScreen mainScreen] bounds].size.height==736)
            
            
            
        {
            
            
            
            headerView      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self
                                                                       
                                                                       .tblCash.frame.size.width,40)];
            
            
            
            imageview     =[[UIImageView alloc] initWithFrame:CGRectMake(360,16,25,25)];
            
            
            
        }
        
        
        
        else
            
            
            
        {
            
            
            
            headerView     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tblCash.frame.size.width,40)];
            
            
            
            imageview     =[[UIImageView alloc] initWithFrame:CGRectMake(270,14,25,25)];
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    else
        
        
        
    {
        
        
        
        headerView      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self
                                                                   
                                                                   .tblCash.frame.size.width,40)];
        
        
        
        imageview     =[[UIImageView alloc] initWithFrame:CGRectMake(self
                                                                     
                                                                     .tblCash.frame.size.width-30,16,25,25)];
        
        
        
    }
    
    
    
    headerView.tag = section;
    
    
    
    headerView.backgroundColor= [UIColor whiteColor];
    
    
    
    headerView.layer.borderColor = [UIColor colorWithRed:0.149 green:0.663 blue:0.878 alpha:1].CGColor ;
    
    
    
    
    
    headerView.layer.borderWidth=1.0f;
    
    
    
    
    
    headerView.layer.cornerRadius=3.0;
    
    
    
    
    
    headerView.layer.masksToBounds=YES;
    
    
    
    
    
    headerString = [[UILabel alloc] initWithFrame:CGRectMake(15, 2, _tblCash.frame.size.width-20, 25)];
    
    
    
    
    
    headerAdd = [[UILabel alloc]initWithFrame:CGRectMake(70, 2, 140, 25)];
    
    
    
    
    
    cashLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 43, 140, 25)];
    
    
    
    
    
    lblStartTm = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 140, 25)];
    
    
    
    
    
    lblEndTm = [[UILabel alloc]initWithFrame:CGRectMake(80, 25, 140, 25)];
    
    
    
    
    
    headerString.numberOfLines = 1;
    
    
    
    cashLbl.numberOfLines = 1;
    
    headerAdd.numberOfLines =1;
    
    
    
    
    
    lblStartTm.numberOfLines = 1;
    
    
    
    
    
    lblEndTm.numberOfLines = 1;
    
    
    
    UIFont *myFont = [ UIFont fontWithName: @"Roboto" size: 15.0 ];
    
    
    
    [headerString setFont:myFont];
    
    
    
    [headerAdd setFont:myFont];
    
    
    
    [lblStartTm setFont:myFont];
    
    
    
    [lblEndTm setFont:myFont];
    
    [cashLbl setFont:myFont];
    
    
    
    cashLbl.textColor=completed_text_color;
    
    
    
    // NSMutableDictionary *dict2;//=[ResponseArray objectAtIndex:section];
    
    
    
    [headerString setBackgroundColor:[UIColor clearColor]];
    
    
    
    [headerAdd setBackgroundColor:[UIColor clearColor]];
    
    
    
    [lblStartTm setBackgroundColor:[UIColor clearColor]];
    
    
    
    [lblEndTm setBackgroundColor: [UIColor clearColor]];
    
    
    
    // headerString.text=[dict2 objectForKey:@"advertise_project_title"];
    
    
    
    self.DictCash =[self.mArrayCash objectAtIndex:section];
    
    
    
    cashLbl.text=[NSString stringWithFormat:@"Rs. %@", [self.DictCash objectForKey:@"total_amount"] ];
    
    NSString *from= [self.DictCash valueForKey:@"bus_route_from_title"];
    
    
    
    NSString *to = [self.DictCash valueForKey:@"bus_route_to_title"];
    
    headerString.text=[NSString stringWithFormat:@"%@ to %@",from,to];
    
    lblStartTm.text = [self.DictCash valueForKey:@"trip_start_time"];
    
    
    lblEndTm.text = [@" - " stringByAppendingString:[self.DictCash valueForKey:@"trip_end_time"] ];
    
    
    
    headerString.textAlignment = NSTextAlignmentLeft;
    
    
    
    headerAdd.textAlignment = NSTextAlignmentLeft;
    
    
    
    lblStartTm.textAlignment = NSTextAlignmentLeft;
    
    
    
    lblEndTm.textAlignment = NSTextAlignmentLeft;
    
    
    
    headerString.textColor = [UIColor grayColor];
    
    
    
    headerAdd.textColor = [UIColor grayColor];
    
    
    
    lblStartTm.textColor = [UIColor grayColor];
    
    
    
    lblEndTm.textColor = [UIColor grayColor];
    
    
    
    [headerView addSubview:headerString];
    
    
    
    [headerView addSubview:headerAdd];
    
    
    
    [headerView addSubview:lblStartTm];
    
    
    
    [headerView addSubview:lblEndTm];
    
    
    
    [headerView addSubview:cashLbl];
    
    
    
    imageview.image=[UIImage imageNamed:@"down_arrow.png"];
    
    
    
    [headerView addSubview:imageview];
    
    
    
    //[headerString.layer setBorderWidth: 2.0];
    
    
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    
    
    
    [headerView addGestureRecognizer:headerTapped];
    
    
    
    return headerView;
    
}


#pragma mark - gesture tapped

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    
    if (indexPath.row == 0) {
        NSMutableDictionary *dictValu = [self.mArrayCash objectAtIndex:indexPath.section];
        self.mArayDetail=[NSMutableArray new];
        self.mArayDetail = [[dictValu valueForKey:@"passenger_details"]mutableCopy];
        
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        
        collapsed  = !collapsed;
        [arrayForBool enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BOOL isOpen=[obj boolValue];
            if (isOpen)
            {
                [arrayForBool replaceObjectAtIndex:idx withObject:[NSNumber numberWithBool:false]];
                NSRange range   = NSMakeRange(idx, 1);
                
                NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
                
                [self.tblCash reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
        [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        //reload specific section animated
        
        NSRange range   = NSMakeRange(indexPath.section, 1);
        
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.tblCash reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
       
        //[self.tblCash reloadData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)setdatePickerView

{
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-176-44, self.view.bounds.size.width, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-176, self.view.bounds.size.width, 180);
    darkView1 = [[UIView alloc] initWithFrame:self.view.bounds] ;
    darkView1.alpha = 0;
    darkView1.backgroundColor = [UIColor clearColor];
    darkView1.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PickerCancel)] ;
    [darkView1 addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView1];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+84, self.view.bounds.size.width, 186)] ;
    
    
    
    /*Setting Date Manuallyy
     
     NSDate * now = [[NSDate alloc] init];
     NSCalendar *cal = [NSCalendar currentCalendar];
     NSDateComponents * comps = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
     [comps setMonth:2];
     [comps setYear:1991];
     [comps setDay:23];
     NSDate * date1 = [cal dateFromComponents:comps];
     [datePicker setDate:date1 animated:TRUE];
     
     */
    
    // Setting minimum and maximum year
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDat = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDat options:0];
    [comps setYear:0];
    
    [datePicker setMaximumDate:maxDate];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    datePicker.tag = 10;
    
    datePicker.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:datePicker];
    
    
    
    //toolbar for country picker view
    
    toolBar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44)] ;
    
    toolBar1.tag = 11;
    
    toolBar1.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    
    
    
    // UIImage* image3 = [UIImage imageNamed:@"confirm.png"];
    
    CGRect frameimg = CGRectMake(0, 0, 50, 40);
    
    
    
    
    
    //done button
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    
    
    
    //[someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    
    
    
    [someButton setTitle:@"Done" forState:UIControlStateNormal];
    
    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [someButton addTarget:self action:@selector(datepickeDone)
     
         forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    //[someButton setShowsTouchWhenHighlighted:YES];
    
    
    
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    
    
    
    [toolBar1 setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    
    [toolBar1 setBarTintColor:Background_blue_color];
    
    [self.view addSubview:toolBar1];
    
    
    
    toolBar1.frame = toolbarTargetFrame;
    
    datePicker.frame = datePickerTargetFrame;
    
    
    
    darkView1.alpha = 0.5;
    
    toolBar1.alpha = 1;
    
    datePicker.alpha = 1;
    
    
    
}

-(void)datepickeDone

{
    
    dateStatus=@"YES";
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    
    
    [timeFormatter setDateFormat:@"dd-MM-YYYY"];
    
    currentDate= [timeFormatter stringFromDate:datePicker.date];
    
    [self CashA_Dvr_Api:currentDate];
    
    
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 200);
    
    
    
    CGAffineTransform transfrom1 = CGAffineTransformMakeTranslation(0, 260);
    
    
    
    datePicker.transform = transfrom;
    
    datePicker.alpha = datePicker.alpha * (-1) + 1;
    
    
    
    toolBar1.transform = transfrom1;
    
    toolBar1.alpha = toolBar1.alpha * (-1) + 1;
    
    
    
    [UIView commitAnimations];
    
    //[self scrollContent];
    
    darkView1.hidden=YES;
    
}

-(void) PickerMethod

{
    
    // [self HideKeyBoard];
    
    
    
    toolBar1.alpha=1;
    
    datePicker.alpha=1;
    
    
    
    darkView1.hidden=NO;
    
    datePicker.hidden=NO;
    
    toolBar1.hidden=NO;
    
    
    
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 0);
    
    
    
    toolBar1.transform = transfrom;
    
    toolBar1.alpha = toolBar1.alpha * (1) + 1;
    
    
    
    datePicker.transform = transfrom;
    
    datePicker.alpha = datePicker.alpha * (1) ;
    
}

-(void)PickerCancel

{
    
    //ScrollView.contentSize = CGSizeMake(320,700);//850
    
    
    
    //[ScrollView setScrollEnabled:YES];
    
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 200);
    
    
    
    CGAffineTransform transfrom1 = CGAffineTransformMakeTranslation(0, 260);
    
    
    
    datePicker.transform = transfrom;
    
    datePicker.alpha = datePicker.alpha * (-1) + 1;
    
    
    
    toolBar1.transform = transfrom1;
    
    toolBar1.alpha = toolBar1.alpha * (-1) + 1;
    
    
    
    [UIView commitAnimations];
    
    
    
    // [self scrollContent];
    darkView1.hidden=YES;
}

- (IBAction)setDate:(id)sender {
    [self setdatePickerView];
}


@end
