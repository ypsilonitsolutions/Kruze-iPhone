//
//  Dvr_Expense_ListVC.m
//  Journe_Driver
//
//  Created by admin on 01/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "Dvr_Expense_ListVC.h"

@interface Dvr_Expense_ListVC ()

@end

@implementation Dvr_Expense_ListVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Dvr_Expense_ListVC_5";
            cellNib=@"ExpenseListCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Dvr_Expense_ListVC";
             cellNib=@"ExpenseListCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Dvr_Expense_ListVC_6";
             cellNib=@"ExpenseListCell_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Dvr_Expense_ListVC_6plus";
             cellNib=@"ExpenseListCell_6plus";
            
        }
    }
    else
    {
        nibName=@"Dvr_Expense_ListVC_ipad";
        cellNib=@"ExpenseListCell_ipad";
        
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
    expArray=[[NSMutableArray alloc]init];
    def=[NSUserDefaults standardUserDefaults];
    driverDict=[def objectForKey:@"LoginDriverDict"];
    driverID=[driverDict valueForKey:@"driver_id"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d.M.yyyy";
    currentDate = [formatter stringFromDate:[NSDate date]];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    lblDate.text=[NSString stringWithFormat:@"%d",day];
    
    
  
}

-(void)viewWillAppear:(BOOL)animated
{
  [self getExpListing];
}
#pragma mark - GetExpenseListing_methods
#pragma mark -
-(void)getExpListing
{
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?driver_id=%@&date=%@",DriverExpList_Url,driverID,currentDate];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
            expArray=[response objectForKey:@"expenses_details"];
            [tableExpense reloadData];
         }
         else
         {
             expArray=[[NSMutableArray alloc]init];
            [tableExpense reloadData];
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
     }];
 }



#pragma mark - AddExpense_methods
#pragma mark -

-(IBAction)actionAddMore:(id)sender
{
    ExpenseAddMore *startJourny = [[ExpenseAddMore alloc]initWithNibName:@"ExpenseAddMore" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:YES];
}



#pragma mark - Back_methods
#pragma mark -
-(IBAction)actionBack
{
   [self.navigationController popViewControllerAnimated:true];
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
    //[datePicker setMinimumDate:minDate];
    
    
    
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
    

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //CurrentTime=[dateFormatter stringFromDate:now];
    NSLog(@"The Date is %@",[timeFormatter stringFromDate:datePicker.date]);
    
    
    
    
   currentDate= [timeFormatter stringFromDate:datePicker.date];
    
    
    
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 200);
    
    
    
    CGAffineTransform transfrom1 = CGAffineTransformMakeTranslation(0, 260);
    
    
    
    datePicker.transform = transfrom;
    
    datePicker.alpha = datePicker.alpha * (-1) + 1;
    
    
    
    toolBar1.transform = transfrom1;
    
    toolBar1.alpha = toolBar1.alpha * (-1) + 1;
    
    
    
    [UIView commitAnimations];
    
    //[self scrollContent];
    
    darkView1.hidden=YES;
    [self getExpListing];
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


#pragma mark - Tableview delegate methods
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return [expArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *simpleTableIdentifier = @"TableCellCustom";
    ExpenseListCell *cell = [tableExpense dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:cellNib owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    NSDictionary *di=[expArray objectAtIndex:indexPath.row];
    cell.lblExpAmount.text=[NSString stringWithFormat:@"Rs%ld",(long)[[di valueForKey:@"e_detail_cost"]integerValue ]];
    cell.lblExpenseTitle.text=[di valueForKey:@"ec_name"];
    cell.lblExpSubtitle.text=[NSString stringWithFormat:@"%ld Kms",(long)[[di valueForKey:@"e_detail_kms"]integerValue ]];
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *di=[expArray objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:di forKey:@"selected_expense"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    ExpensesDetailsVC *startJourny = [[ExpensesDetailsVC alloc]initWithNibName:@"ExpensesDetailsVC" bundle:nil];
    [self.navigationController pushViewController:startJourny animated:YES];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.7 animations:^{
        cell.transform = CGAffineTransformIdentity;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
