//
//  ExpenseAddMore.m
//  Journe
//
//  Created by admin on 09/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "ExpenseAddMore.h"

@interface ExpenseAddMore ()
{
    MBProgressHUD *HUD;
}
@end

@implementation ExpenseAddMore
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"ExpenseAddMore";
            cell_nib=@"ExpenseCell";
            ExpensesTypeView_x=13;
            ExpensesTypeView_y=66;
            ExpensesTypeView_w=294;
            ExpensesTypeView_h=5;
            ExpensesTypeView_IncreamentValue=181;
            
            
            ExpensesDetailsView_x=13;
            ExpensesDetailsView_y=117;
            ExpensesDetailsView_w=294;
            ExpensesDetailsView_h=607;
            ExpensesDetailsView_IncreamentValue=185;
            newYvalueOfDetailsView=60;
          
            
            
            
            
            FuelTypeView_x=13;
            FuelTypeView_y=66;
            FuelTypeView_w=294;
            FuelTypeView_h=49;
            FuelTypeView_IncreamentValue=186;
            
            scrollIncrementSize=400;
            scrollViewResize=200;
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"ExpenseAddMore_iPhone4";
            cell_nib=@"ExpenseCell";
            
            ExpensesTypeView_x=13;
            ExpensesTypeView_y=66;
            ExpensesTypeView_w=294;
            ExpensesTypeView_h=5;
            ExpensesTypeView_IncreamentValue=181;
            
            ExpensesDetailsView_x=13;
            ExpensesDetailsView_y=117;
            ExpensesDetailsView_w=294;
            ExpensesDetailsView_h=564;
            ExpensesDetailsView_IncreamentValue=185;
            newYvalueOfDetailsView=60;
            
            FuelTypeView_x=13;
            FuelTypeView_y=66;
            FuelTypeView_w=294;
            FuelTypeView_h=49;
            FuelTypeView_IncreamentValue=186;
            
            scrollIncrementSize=500;
            scrollViewResize=280;
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"ExpenseAddMore_iPhone6";
            cell_nib=@"ExpenseCell";
            
            ExpensesTypeView_x=41;
            ExpensesTypeView_y=66;
            ExpensesTypeView_w=294;
            ExpensesTypeView_h=5;
            ExpensesTypeView_IncreamentValue=181;
            
            ExpensesDetailsView_x=41;
            ExpensesDetailsView_y=117;
            ExpensesDetailsView_w=294;
            ExpensesDetailsView_h=665;
            ExpensesDetailsView_IncreamentValue=185;
            newYvalueOfDetailsView=60;
            
            FuelTypeView_x=41;
            FuelTypeView_y=66;
            FuelTypeView_w=294;
            FuelTypeView_h=49;
            FuelTypeView_IncreamentValue=186;
            
            scrollIncrementSize=500;
            scrollViewResize=250;
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"ExpenseAddMore_iPhone6plus";
            cell_nib=@"ExpenseCell_iPhone6plus";
            
            ExpensesTypeView_x=41;
            ExpensesTypeView_y=66;
            ExpensesTypeView_w=332;
            ExpensesTypeView_h=5;
            ExpensesTypeView_IncreamentValue=181;
            
            ExpensesDetailsView_x=41;
            ExpensesDetailsView_y=117;
            ExpensesDetailsView_w=332;
            ExpensesDetailsView_h=763;
            ExpensesDetailsView_IncreamentValue=185;
            newYvalueOfDetailsView=60;
            
            FuelTypeView_x=41;
            FuelTypeView_y=66;
            FuelTypeView_w=332;
            FuelTypeView_h=49;
            FuelTypeView_IncreamentValue=186;
            
            scrollIncrementSize=500;
            scrollViewResize=220;
        }
    }
    else
    {
        nibName=@"ExpenseAddMore_iPad";
        cell_nib=@"ExpenseCell_iPad";
        
        ExpensesTypeView_x=41;
        ExpensesTypeView_y=104;
        ExpensesTypeView_w=687;
        ExpensesTypeView_h=5;
        ExpensesTypeView_IncreamentValue=181;
        
        ExpensesDetailsView_x=41;
        ExpensesDetailsView_y=164;
        ExpensesDetailsView_w=687;
        ExpensesDetailsView_h=921;
       ExpensesDetailsView_IncreamentValue=185;
        newYvalueOfDetailsView=150;
        
        FuelTypeView_x=41;
        FuelTypeView_y=111;
        FuelTypeView_w=569;
        FuelTypeView_h=49;
        FuelTypeView_IncreamentValue=250;
        
        scrollIncrementSize=530;
        scrollViewResize=130;
    }
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ExpensesBtn addTarget:self action:@selector(didPressExpensesButton) forControlEvents:UIControlEventTouchUpInside];
    
    FuelSelected=true;
    
    cat_selected_id=@"1";
    
    options=@"";
    
    expensesTypesArray=[[NSMutableArray alloc] init];
    
    description.layer.cornerRadius = 3;
    description.layer.borderWidth = 1;
    description.layer.borderColor = [UIColor  colorWithRed:0.149 green:0.663 blue:0.878 alpha:1].CGColor ;
    
    [self get_expense_types_list];
    
    [BtnPetrol addTarget:self action:@selector(didPressPetrolButton) forControlEvents:UIControlEventTouchUpInside];
    
    [BtnDiesel addTarget:self action:@selector(didPressDieselButton) forControlEvents:UIControlEventTouchUpInside];
    
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

#pragma mark- ProgressBar_methods
#pragma mark-
-(void)progressBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Processing...";
    HUD.square = YES;
    [HUD show:YES];
}


-(void)get_expense_types_list
{
    [self progressBar];
    NSString *str = [NSString stringWithFormat:@"%@",ExpensesTypeURL];
    WebService *api = [WebService alloc];
    
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             expensesTypesArray=[response objectForKey:@"category_list"];
             [table reloadData];
         }
         else
         {
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Category not found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert show];
         }
     }];
}

#pragma mark - Tableview delegate methods
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
            return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return [expensesTypesArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *simpleTableIdentifier = @"TableCellCustom";
    ExpenseCell *cell = [table dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
    NSArray * nib = [[NSBundle mainBundle]loadNibNamed:cell_nib owner:self options:nil];
    cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    NSDictionary *d=[expensesTypesArray objectAtIndex:indexPath.row];
    NSString *cat_name=[d objectForKey:@"ec_name"];
    cell.lblExpenseType.text=cat_name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *d=[expensesTypesArray objectAtIndex:indexPath.row];
    NSString *cat_name=[NSString stringWithFormat:@"  %@",[d objectForKey:@"ec_name"] ];
    cat_selected_id=[NSString stringWithFormat:@"%@",[d objectForKey:@"ec_id"] ];
    if (![cat_name isEqualToString:@"  Fuel"])
    {
        [UIView transitionWithView:ExpensesBtn duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            
            [ExpensesBtn setTitle:cat_name forState:UIControlStateNormal];
            
        } completion:nil];
        //[ExpensesBtn setTitle:@"  Fuel" forState:UIControlStateNormal];
        FuelSelected=false;
        FuelTypeView.hidden=true;
        
        ExpensesDetailsView_y=newYvalueOfDetailsView;
        [self didPressExpensesButton];
    }
    else
    {
        [UIView transitionWithView:ExpensesBtn duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            
            [ExpensesBtn setTitle:cat_name forState:UIControlStateNormal];
            
        } completion:nil];
        
        //[ExpensesBtn setTitle:@"  Maintenence" forState:UIControlStateNormal];
        FuelTypeView.hidden=false;
        FuelSelected=true;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
        ExpensesDetailsView_y=117;
        }else
        {
         ExpensesDetailsView_y=164;
        }
        [self didPressExpensesButton];
    }
}

#pragma mark - FuelTypesSelection
#pragma mark -

-(void)didPressPetrolButton
{
    options=@"petrol";
    [BtnPetrol setImage:[UIImage imageNamed:@"radio_btn_active"] forState:UIControlStateNormal];
    [BtnDiesel setImage:[UIImage imageNamed:@"radio_btn"] forState:UIControlStateNormal];
}
-(void)didPressDieselButton
{
    options=@"diesel";
    [BtnPetrol setImage:[UIImage imageNamed:@"radio_btn"] forState:UIControlStateNormal];
    [BtnDiesel setImage:[UIImage imageNamed:@"radio_btn_active"] forState:UIControlStateNormal];
}
#pragma mark -


#pragma mark - viewWillAppear
#pragma mark -
-(void)viewWillAppear:(BOOL)animated
{
    ExpensesTypeView.hidden=true;
    
    FuelTypeView.frame=CGRectMake(FuelTypeView_x, FuelTypeView_y, FuelTypeView_w, FuelTypeView_h);
    
    ExpensesDetailsView.frame=CGRectMake(ExpensesDetailsView_x, ExpensesDetailsView_y, ExpensesDetailsView_w, ExpensesDetailsView_h);
    
    
    scroll.contentSize=CGSizeMake(scroll.frame.size.width,scroll.frame.size.height+scrollViewResize);
    
    Btnsave.layer.borderWidth=1;
    Btnsave.clipsToBounds = YES;
    Btnsave.layer.cornerRadius = Btnsave.frame.size.height/2.0f;
    Btnsave.layer.borderColor=sky_blue_color;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d.M.yyyy";
    currentDate = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    lblDate.text=[NSString stringWithFormat:@"%ld",(long)day];
    
}
#pragma mark -



#pragma mark - ExpenseButtonTapMethod
#pragma mark -
-(void)didPressExpensesButton
{
    
    ExpensesBtnTapped=!ExpensesBtnTapped;
    if (ExpensesBtnTapped)
    {
        //For Showing the view
        ExpensesTypeView.alpha=0.0f;
        
        ExpensesTypeView.frame=CGRectMake(ExpensesTypeView_x, ExpensesTypeView_y, ExpensesTypeView_w, ExpensesTypeView_h);
        
        FuelTypeView.frame=CGRectMake(FuelTypeView_x, FuelTypeView_y, FuelTypeView_w, FuelTypeView_h);
        
        ExpensesDetailsView.frame=CGRectMake(ExpensesDetailsView_x, ExpensesDetailsView_y, ExpensesDetailsView_w, ExpensesDetailsView_h);
        
        scroll.contentSize=CGSizeMake(scroll.frame.size.width,scroll.frame.size.height+scrollViewResize);
        
      [UIView animateWithDuration:.5 animations:^{
          ExpensesTypeView.hidden=false;
          
          ExpensesTypeView.frame=CGRectMake(ExpensesTypeView_x, ExpensesTypeView_y, ExpensesTypeView_w, ExpensesTypeView_h+ExpensesTypeView_IncreamentValue);
          FuelTypeView.frame=CGRectMake(FuelTypeView_x, FuelTypeView_y+FuelTypeView_IncreamentValue, FuelTypeView_w,FuelTypeView_h);
          
          ExpensesDetailsView.frame=CGRectMake(ExpensesDetailsView_x, ExpensesDetailsView_y+ExpensesDetailsView_IncreamentValue, ExpensesDetailsView_w, ExpensesDetailsView_h);
          
          scroll.contentSize=CGSizeMake(scroll.frame.size.width,scroll.frame.size.height+scrollIncrementSize);
          
      }completion:^(BOOL finished) {
          ExpensesTypeView.alpha=1.0f;
      }];
    }
    else
    {
        ExpensesTypeView.alpha=1.0f;
        ExpensesTypeView.frame=CGRectMake(ExpensesTypeView_x, ExpensesTypeView_y, ExpensesTypeView_w, ExpensesTypeView_h+ExpensesTypeView_IncreamentValue);
        
        FuelTypeView.frame=CGRectMake(FuelTypeView_x, FuelTypeView_y+FuelTypeView_IncreamentValue, FuelTypeView_w, FuelTypeView_h);
        
        ExpensesDetailsView.frame=CGRectMake(ExpensesDetailsView_x, ExpensesDetailsView_y+ExpensesDetailsView_IncreamentValue, ExpensesDetailsView_w, ExpensesDetailsView_h);
        
        scroll.contentSize=CGSizeMake(scroll.frame.size.width,scroll.frame.size.height+scrollIncrementSize);
        
        
        [UIView animateWithDuration:.5 animations:^{
            ExpensesTypeView.alpha=0.0f;
            
            ExpensesTypeView.frame=CGRectMake(ExpensesTypeView_x, ExpensesTypeView_y, ExpensesTypeView_w, ExpensesTypeView_h);
            
            FuelTypeView.frame=CGRectMake(FuelTypeView_x, FuelTypeView_y, FuelTypeView_w, FuelTypeView_h);
            
            
            ExpensesDetailsView.frame=CGRectMake(ExpensesDetailsView_x, ExpensesDetailsView_y, ExpensesDetailsView_w, ExpensesDetailsView_h);
            
            scroll.contentSize=CGSizeMake(scroll.frame.size.width,scroll.frame.size.height+scrollViewResize);
            
        } completion:^(BOOL finished) {
            ExpensesTypeView.hidden=true;
        }];
    }
}
#pragma mark - 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UploadBillCopyToServer
#pragma mark -
- (IBAction)UploadBill:(id)sender {
    UIActionSheet *act=[[UIActionSheet alloc] initWithTitle:@"Select Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery", nil];
    act.tag=1;
    [act showInView:self.view];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1)
    {
       
        
            if (buttonIndex==0)
            {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self openCamera];
                }];
            }
            else if (buttonIndex==1)
            {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self openGallery];
                }];
            }
            else
            {
                return;
            }
        
    }
}

-(void)openCamera
{
    UIImagePickerController *imageCon=[[UIImagePickerController alloc]init];
    imageCon.sourceType=UIImagePickerControllerSourceTypeCamera;
    imageCon.allowsEditing=true;
    
    imageCon.delegate=self;
    [self presentViewController:imageCon animated:true completion:nil];
}
-(void)openGallery
{
    UIImagePickerController *imageCon=[[UIImagePickerController alloc]init];
    imageCon.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imageCon.allowsEditing=true;
    
    imageCon.delegate=self;
    [self presentViewController:imageCon animated:true completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        imageName  = [imageRep filename];
        NSString *timeStamp =[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        imageName=[NSString stringWithFormat:@"%@.jpg",timeStamp];
    };
    // get the asset library and fetch the asset based on the ref url
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
    imgView.image=image;
    imageflag=1;
    imagedata=UIImageJPEGRepresentation(image,1.0);
    [picker dismissViewControllerAnimated:true completion:nil];
    
}
#pragma mark -

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    imageflag=0;
}
-(BOOL)Validations
{
    NSString *type=ExpensesBtn.titleLabel.text;
    if ([type containsString:@"Fuel"] && [options isEqualToString:@""])
    {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please select fuel type" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
        return NO;
 
    }
    else if ([txtAmount.text isEqualToString:@""])
    {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please enter amount" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
        return NO;
        
    }
    else if ([txtKM.text isEqualToString:@""])
    {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please enter kilometers" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
        return NO;
        
    }
    else if (imageflag==0)
    {
        UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Please select bill to upload" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [a show];
        return NO;
    }
    
    return YES;
}
- (IBAction)uploadDataToServer:(id)sender {
    if (![self Validations])
    {
        return;
    }
    [self progressBar];
    
    if (![ExpensesBtn.titleLabel.text isEqualToString:@"  Fuel"])
    {
        options=@"";
    }
    
 
 NSMutableDictionary *userDict=[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginDriverDict"];
    NSString *driver_id=[userDict objectForKey:@"driver_id"];
    NSURL *url=[NSURL URLWithString:AddExpensesURL];
    
    NSMutableDictionary *requestDict=[[NSMutableDictionary alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d.M.yyyy";
    NSString *date = [formatter stringFromDate:[NSDate date]];
    
    [requestDict setObject:driver_id forKey:@"driver_id"];
    [requestDict setObject:cat_selected_id forKey:@"category_id"];
    [requestDict setObject:txtAmount.text forKey:@"cost"];
    [requestDict setObject:txtKM.text forKey:@"kms"];
    [requestDict setObject:options forKey:@"options"];
    [requestDict setObject:description.text forKey:@"desc"];
    [requestDict setObject:date forKey:@"date"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:requestDict constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        if (imagedata.length!=0)
        {
            [formData appendPartWithFileData:imagedata name:@"image" fileName:imageName mimeType:@"image/jpg"];
        }
    }];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        [HUD hide:true];
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        if ([[response objectForKey:@"status"] isEqualToString:@"true"])
        {
            UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [a show];
            description.text=@"Description...";
            txtAmount.text=@"";
            txtKM.text=@"";
            FuelSelected=true;
            cat_selected_id=@"1";
            imagedata=[NSData new];
            options=@"";
            [BtnPetrol setImage:[UIImage imageNamed:@"radio_btn"] forState:UIControlStateNormal];
            [BtnDiesel setImage:[UIImage imageNamed:@"radio_btn"] forState:UIControlStateNormal];
            imgView.image=[UIImage imageNamed:@""];
            //[ExpensesBtn setTitle:@"  Fuel" forState:UIControlStateNormal];
        }
        else
        {
            UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [a show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [HUD hide:true];
         NSLog(@"Error=%@",error);
     }];
    [operation start];
}


- (IBAction)backBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Date Picker
#pragma mark -
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
    //[datePicker setMinimumDate:maxDate];
    
    
    NSDate *today = [NSDate date]; // This is 'now'
    
    NSDateComponents *components = [NSDateComponents new];
    
    [components setDay:-3];
    
    NSDate *yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:today options:kNilOptions];
    datePicker.minimumDate = yesterday;
    
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
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    
    
    [timeFormatter setDateFormat:@"dd-MM-YYYY"];
    
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

#pragma mark -
- (IBAction)selectDate:(id)sender {
    [self setdatePickerView];
}


@end
