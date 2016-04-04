//
//  SignUpVc.m
//  Journe
//
//  Created by admin on 19/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//
//ah6GKkx1

#import "SignUpVc.h"

@interface SignUpVc ()

@end

@implementation SignUpVc
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"SignUpVc";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"SignUpVc_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"SignUpVc_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"SignUpVc_6plus";
            
        }
    }
    else
    {
        nibName=@"SignUpVc_ipad";
        
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
    // Do any additional setup after loading the view from its nib.
    nsud=[NSUserDefaults standardUserDefaults];
    signUpTypeCheck=@"";
    tb_company.layer.borderColor=sky_blue_color;
    tb_company.layer.borderWidth=1;
    [self setting_view];
    [self getCompanyList];
}
-(void)viewDidAppear:(BOOL)animated{
    
    scrollView.contentSize=CGSizeMake(scrollView.frame.size.width,scrollView.frame.size.height+400);
}

-(void)getCompanyList
{
    
    
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@",CompanyListURL];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             companyArray=[response objectForKey:@"companies"];
             [tb_company reloadData];
             
         }
         else
             
         {
            
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
             
         }
         
         
         
         
     }];
  
    
    
    
    
}
#pragma mark- SettingView_methods
#pragma mark-
-(void)setting_view
{
    termsConditionsStatus=0;
    img_user.layer.borderWidth=1;
    img_user.clipsToBounds = YES;
    img_user.layer.cornerRadius=img_user.frame.size.height/2.0f;
    img_user.layer.borderColor=sky_blue_color;
    btnSubmit.layer.borderWidth=1;
    btnSubmit.clipsToBounds = YES;
    btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2.0f;
    btnSubmit.layer.borderColor=sky_blue_color;
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtPwd.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtConfirmPwd.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtTelephone.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Telephone" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
      txtName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Full Name" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
     txtComapnyName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Company Name" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtempId.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Employee Id" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtName.text=  [nsud objectForKey:@"UserName"];
    txtEmail.text=[nsud objectForKey:@"UserMail"];
    [self individualActive];
}

#pragma mark- AcceptingTerms_methods
#pragma mark-
-(IBAction)Acceting_terms:(id)sender
{
    if (terms_check==NO)
    {
        [btnterms_check setImage:[UIImage imageNamed:@"check_box_active"] forState:UIControlStateNormal];
        terms_check=YES;
        termsConditionsStatus=1;
    }
    else
    {
    [btnterms_check setImage:[UIImage imageNamed:@"check_box_inactive"] forState:UIControlStateNormal];
         terms_check=NO;
        termsConditionsStatus=0;
    }
   
}
#pragma mark- Terms_popUp_methods
#pragma mark-
-(IBAction)Open_terms:(id)sender
{
    
NSURL *url=[NSURL URLWithString:@"http://72.167.41.165/journe/webservices/passenger/privacy-container.html"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
[web_view loadRequest:request];
    shadow_view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.5/1.2 animations:^{
        
        shadow_view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3/2 animations:^{
            
            shadow_view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.3/2 animations:^{
                
                shadow_view.transform = CGAffineTransformIdentity;
                
            }];
            
        }];
        
    }];
    shadow_view.hidden=false;



}

#pragma mark- Close_Terms_popUp_methods
#pragma mark-
-(IBAction)Close_terms:(id)sender
{
    shadow_view.hidden=true;
   
}

#pragma mark- SignUp_methods
#pragma mark-
-(IBAction)goto_Sign_Up:(id)sender
{
    
    if ([self signup_Validation])
    {
        
        [self call_SignUp_API];
    }
   
}

-(void)call_SignUp_API
{
    [self add_progress_view];
    NSString *deviceToken = [nsud valueForKey:@"DEVICE_TOKEN"];
    if (deviceToken.length==0)
    {
   deviceToken=@"fdsjkhfshsdkjdhfk4";
    }
    NSURL *url=[NSURL URLWithString:Sign_Up];
    NSMutableDictionary *requestDict=[[NSMutableDictionary alloc]init];
    [requestDict setObject:txtEmail.text forKey:@"passenger_email"];
    [requestDict setObject:txtName.text forKey:@"passenger_name"];
    [requestDict setObject:txtTelephone.text forKey:@"passenger_mobile"];
    [requestDict setObject:txtPwd.text forKey:@"passenger_password"];
    [requestDict setObject:deviceToken forKey:@"device_token"];
    [requestDict setObject:@"2" forKey:@"device_type"];
     [requestDict setObject:signUpTypeCheck forKey:@"passenger_type"];
     [requestDict setObject:companyId forKey:@"passenger_company"];
     [requestDict setObject:txtempId.text forKey:@"passenger_emp_id"];
     [requestDict setObject:txtReferCode.text forKey:@"referal_code"];
    

    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:requestDict constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        
        if (imagedata.length!=0)
        {
         [formData appendPartWithFileData:imagedata name:@"passenger_image" fileName:imageName mimeType:@"image/jpg"];
        }
        
            
        
    }];
    
AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        [HUD hide:true];
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        if ([[response objectForKey:@"status"] isEqualToString:@"true"])
        {
            resp_Check=[NSString stringWithFormat:@"%@",[response objectForKey:@"verify_status"]];
            user_ID=[response objectForKey:@"passenger_id"];
            [nsud setObject:response forKey:@"LoginUserDict"];
           
            [nsud setObject:@"passenger" forKey:@"UserType"];
             [nsud synchronize];
            UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[NSString stringWithFormat:@"Verification code is sent to your registered mobile for now please use 123456 as default otp"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [a show];
            a.tag=1;
        }
        else
            
        {
            UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [a show];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [HUD hide:true];

        NSLog(@"Error=%@",error);
        
    }];
    
    
    [operation start];
    
}

-(BOOL)signup_Validation
{
    
    BOOL isValid = false;
    if (txtName.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Full Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
    
    else if (txtEmail.text.length==0){
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
     else if (![self isValidEmail:txtEmail.text]){
         
         [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Valid Email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         
     }
     else if (txtPwd.text.length==0){
         
         [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         
     }else  if (txtPwd.text.length<6){
         
         [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Atleast 6 Digit Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         
     }else if (txtConfirmPwd.text.length==0){
         
         [txtConfirmPwd becomeFirstResponder];
         [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Confirm Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         
     }
     else if (txtConfirmPwd.text.length<6){
         
         [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Atleast 6 Digit Confirm Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         
     }else if (![txtPwd.text isEqualToString:txtConfirmPwd.text]){
         
         [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Password Not Matched" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         
     }
     else if (txtTelephone.text.length==0)
     {
         
         [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Contact No." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
         
     }
   else if (txtTelephone.text.length>10||txtTelephone.text.length<10){
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Valid Contact No." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
   else if ([signUpTypeCheck isEqualToString:@"2"]&&txtComapnyName.text.length==0)
   {
       
       [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Company Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
       
   }
   else if ([signUpTypeCheck isEqualToString:@"2"]&&txtempId.text.length==0)
   {
       
       [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Employee ID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
       
   }
   else if (termsConditionsStatus == 0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Accept The Terms & Conditions" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }else{
        
        isValid = true;
    }
    
    return isValid;
}
#pragma mark- gotoLogin_methods
#pragma mark-
-(IBAction)Login:(id)sender
{
    
    LoginVC *nav = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
    [UIView setAnimationDuration:0.75];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
    [self.navigationController pushViewController:nav animated:YES];
  
    
    
    
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
#pragma mark - AlertView_Delegate Method
#pragma mark -
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            
            if ([resp_Check isEqualToString:@"1"])
            {
                [nsud setObject:txtTelephone.text forKey:@"MobileNumber"];
                VerifyOtpVC *nav = [[VerifyOtpVC alloc]initWithNibName:@"VerifyOtpVC" bundle:nil];
                [UIView  beginAnimations:nil context:NULL];
                [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
                [UIView setAnimationDuration:0.75];
                
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
                [UIView commitAnimations];
                [self.navigationController pushViewController:nav animated:YES];
            }
            
            
            else
            {
                [nsud setObject:user_ID forKey:@"UserID"];
                DashboardVC *nav = [[DashboardVC alloc]initWithNibName:@"DashboardVC" bundle:nil];
                [UIView  beginAnimations:nil context:NULL];
                [UIView setAnimationCurve:UIViewAnimationOptionTransitionCrossDissolve];
                [UIView setAnimationDuration:0.75];
                
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
                [UIView commitAnimations];
                [self.navigationController pushViewController:nav animated:YES];
                
                
                
                
            }
            
            
  
            
        }
    }
    
  if (alertView.tag==2)
    {
        
        
        
        UIImagePickerController *imageCon=[[UIImagePickerController alloc]init];
        if (buttonIndex==0) {
            return;
        }
        else if (buttonIndex==1)
        {
            imageCon.sourceType=UIImagePickerControllerSourceTypeCamera;
            
        }
        else if (buttonIndex==2)
        {
            imageCon.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        }
        imageCon.allowsEditing=true;
        
        imageCon.delegate=self;
        [self presentViewController:imageCon animated:true completion:nil];
        
        
        
        
        
    }
    
    
    
    
    
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
    img_user.image=image;
    imageflag=1;
    imagedata=UIImageJPEGRepresentation(image,1.0);
    [picker dismissViewControllerAnimated:true completion:nil];
    
}

#pragma mark - Email Validation Method
#pragma mark -

-(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}



#pragma mark- Capture_image_methods
#pragma mark-
-(IBAction)captureImage:(id)sender
{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select" message:@"Choose Action" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Gallery", nil];
    [alert show];
    alert.tag=2;
    
    
}


#pragma mark- SignUpTypeSelection_methods
#pragma mark-
-(IBAction)comanySelected:(id)sender
{
    
    [self comapnyActive];
    
}
-(IBAction)individualSelected:(id)sender
{
   
  [self individualActive];
}

-(void)comapnyActive
{
    
    signUpTypeCheck=@"2";
    [btnCompany setImage:[UIImage imageNamed:@"radio_btn_active.png"] forState:UIControlStateNormal];
    [btnSingle setImage:[UIImage imageNamed:@"radio_btn.png"] forState:UIControlStateNormal];
    txtComapnyName.enabled=false;
    btnTapCompany.enabled=true;
    txtempId.enabled=true;
    txtComapnyName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Company Name" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtempId.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Employee Id" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    lblCompany.backgroundColor=[HexColorToUIColor colorFromHexString:@"#26A9E0"];
    lblEmpid.backgroundColor=[HexColorToUIColor colorFromHexString:@"#26A9E0"];
    
}
-(void)individualActive
{
    
    signUpTypeCheck=@"1";
    companyId=@"";
    btnTapCompany.enabled=false;
    txtComapnyName.text=@"";
    txtempId.text=@"";
    tb_company.hidden=true;
    [btnCompany setImage:[UIImage imageNamed:@"radio_btn.png"] forState:UIControlStateNormal];
    [btnSingle setImage:[UIImage imageNamed:@"radio_btn_active.png"] forState:UIControlStateNormal];
    txtComapnyName.text=@"";
    txtempId.text=@"";
    txtComapnyName.enabled=false;
    txtempId.enabled=false;
    txtComapnyName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Company Name" attributes:@{NSForegroundColorAttributeName: [HexColorToUIColor colorFromHexString:@"#b3b3b3"]}];
    txtempId.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Employee Id" attributes:@{NSForegroundColorAttributeName: [HexColorToUIColor colorFromHexString:@"#b3b3b3"]}];
    lblCompany.backgroundColor=[HexColorToUIColor colorFromHexString:@"#b3b3b3"];
    lblEmpid.backgroundColor=[HexColorToUIColor colorFromHexString:@"#b3b3b3"];
    
}
#pragma mark -  TextFielddelegate methods
#pragma mark -
- (IBAction)textFieldTap:(id)sender
{
    tb_company.hidden=true;
}

#pragma mark -  GetCompanyTap methods
#pragma mark -
- (IBAction)companyTapped:(id)sender
{
    
    
    
    if (infoTap==false)
    {
        [tb_company reloadData];
        tb_company.hidden=false;
        [btnTapCompany setImage:[UIImage imageNamed:@"up_arrow"] forState:UIControlStateNormal];
        infoTap=true;
        
    }
    else
    {
        
        infoTap=false;
        tb_company.hidden=true;
        [btnTapCompany setImage:[UIImage imageNamed:@"down_arrow.png"] forState:UIControlStateNormal];

        
    }
    
    
 
    
}
#pragma mark - Tableview delegate methods
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
   
        return [companyArray count];
   
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
 
        UITableViewCell *celll=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        NSMutableDictionary *dict=[companyArray objectAtIndex:indexPath.row];
        celll.textLabel.textAlignment=UITextAlignmentCenter;
        celll.textLabel.font=[UIFont fontWithName:@"Roboto Regular" size:14.0];
    celll.textLabel.textColor=text_gray_color;
        celll.textLabel.text=[NSString stringWithFormat: @"%@",[dict objectForKey:@"company_name"] ];
        return celll;
        
   }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
NSMutableDictionary *dict=[companyArray objectAtIndex:indexPath.row];
    companyId=[dict valueForKey:@"company_id"];
    txtComapnyName.text=[dict objectForKey:@"company_name"];
    tb_company.hidden=true;
   
}
#pragma mark -  PasswordCheck methods
#pragma mark -


- (IBAction)passwordCheck:(id)sender
{
    
    if ([txtPwd.text isEqualToString:txtConfirmPwd.text])
    {
        imgTick.hidden=false;
    }
    else
    {
      imgTick.hidden=true;
        
    }
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
