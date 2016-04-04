//
//  ProfileVC.m
//  Journe
//
//  Created by admin on 04/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "EditProfileVC.h"
@interface EditProfileVC ()
@end
@implementation EditProfileVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"EditProfileVC";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"EditProfileVC_4";
         
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"EditProfileVC_6";
           
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"EditProfileVC_6plus";
           
            
        }
    }
    else
    {
        nibName=@"EditProfileVC_ipad";

        
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
    
    txtEmergencyNo.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Emergency No." attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtHomeLoc.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Home Location" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtWorkLoc.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Work Location" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    [btnDob setTitle:@"Select Date Of Birth" forState:UIControlStateNormal];
    def=[NSUserDefaults standardUserDefaults];
    imgUser.layer.borderWidth=1;
    imgUser.clipsToBounds = YES;
    imgUser.layer.cornerRadius=imgUser.frame.size.height/2.0f;
    imgUser.layer.borderColor=sky_blue_color;
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
    SelectdDate=@"";
    btnEdit.enabled=true;
    [self call_UserProfile];
  }


-(void)viewDidAppear:(BOOL)animated{
    
    ScrollView.contentSize=CGSizeMake(ScrollView.frame.size.width,ScrollView.frame.size.height+400);
}

#pragma  mark - GetUserProfile_methods
#pragma mark -
-(void)call_UserProfile
{
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?passenger_id=%@",UserProfile_Url,User_Id];
    
    WebService *api = [WebService alloc];
    
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             
        [def setObject:response forKey:@"LoginUserDict"];
        txtName.text=[response valueForKey:@"passenger_name"];
        txtMAil.text=[response valueForKey:@"passenger_email"];
        txtHomeLoc.text=[response valueForKey:@"passenger_hose_loac"];
        txtEmergencyNo.text=[response valueForKey:@"passenger_emergency_num"];
    txtCompany.text=[response valueForKey:@"passenger_company"];
        txtNo.text=[response valueForKey:@"passenger_mobile"];
        txtReferalCode.text=[response valueForKey:@"passenger_referral_code"];
        txtWorkLoc.text=[response valueForKey:@"passenger_work_loac"];
             if ([[response valueForKey:@"passenger_dob"] isEqualToString:@""])
             {
                 [btnDob setTitle:@"Select Date Of Birth" forState:UIControlStateNormal];
             }
             else
             {
        [btnDob setTitle:[response valueForKey:@"passenger_dob"] forState:UIControlStateNormal];
             }
        NSURL *Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[response objectForKey:@"passenger_image"]]];
             [imgUser setImageWithURL:Url placeholderImage:[UIImage imageNamed:@"profile-1.png"]];
             
            if ([[response valueForKey:@"passenger_gender"]isEqualToString:@"2"])
             {
                 [btnFemale setImage:[UIImage imageNamed:@"radio_btn_active"] forState:UIControlStateNormal];
                 [btnMale setImage:[UIImage imageNamed:@"radio_btn"] forState:UIControlStateNormal];
                 userGender=@"2";
                 
             }
             
            else if ([[response valueForKey:@"passenger_gender"]isEqualToString:@"1"])
             {
                 [btnFemale setImage:[UIImage imageNamed:@"radio_btn"] forState:UIControlStateNormal];
                 [btnMale setImage:[UIImage imageNamed:@"radio_btn_active"] forState:UIControlStateNormal];
                 userGender=@"1";

                 
             }
             
             else
             {
                 
                 
                 [btnFemale setImage:[UIImage imageNamed:@"radio_btn"] forState:UIControlStateNormal];
                 [btnMale setImage:[UIImage imageNamed:@"radio_btn"] forState:UIControlStateNormal];
                 userGender=@"0";
                 
                 
                 
               
             }
         }
         else
             
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
         }

     }];
  
}




#pragma  mark - GenderSelection_methods
#pragma mark -
- (IBAction)maleSelected:(id)sender
{
    
    [btnFemale setImage:[UIImage imageNamed:@"radio_btn"] forState:UIControlStateNormal];
    [btnMale setImage:[UIImage imageNamed:@"radio_btn_active"] forState:UIControlStateNormal];
     userGender=@"1";
}

- (IBAction)femaleSelected:(id)sender
{
    
    [btnMale setImage:[UIImage imageNamed:@"radio_btn"] forState:UIControlStateNormal];
    [btnFemale setImage:[UIImage imageNamed:@"radio_btn_active"] forState:UIControlStateNormal];
     userGender=@"2";
    
}
#pragma  mark - AdditonalInfo_methods
#pragma mark -
- (IBAction)additionalPressed:(id)sender
{
    
    if (infoTap==false)
    {
        imgAddInfo.image=[UIImage imageNamed:@"up_arrow"];
        InfoView.hidden=false;
        infoTap=true;
    
    }
    else
    {
        
     infoTap=false;
     InfoView.hidden=true;
        imgAddInfo.image=[UIImage imageNamed:@"down_arrow.png"];
        
    }
 
    
    
    
    
}

#pragma  mark - Slider_methods
#pragma mark -
- (IBAction)gotoSlider:(id)sender
{
   


    
[self.navigationController popViewControllerAnimated:TRUE];
    
    
    
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
    imgUser.image=image;
    imageflag=1;
    imagedata=UIImageJPEGRepresentation(image,1.0);
    [picker dismissViewControllerAnimated:true completion:nil];
    
}





-(IBAction)captureImage:(id)sender
{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select" message:@"Choose Action" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera",@"Gallery", nil];
    [alert show];
    alert.tag=1;
    
    
}
#pragma mark - AlertView_Delegate Method
#pragma mark -
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (alertView.tag==1)
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
    
    if (alertView.tag==2)
    {
        
        
        ProfileVC *Cp = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
        InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        
        objISVC.topViewController = Cp;
        
        
        [self.navigationController pushViewController:objISVC animated:YES];
        
        
        
        
        
    }
   
    
}
#pragma mark - picker_methods
#pragma mark -
- (IBAction)selectDOB:(id)sender
{
    [shadowView setHidden:false];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    [dataPicker setDate:[NSDate date]];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDat = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDat options:0];
    [comps setYear:0];
    
    [dataPicker setMaximumDate:maxDate];
    [UIView animateWithDuration:0.2f animations:^{
        dataPickerView.frame=CGRectMake(dataPickerView.frame.origin.x,self.view.frame.size.height-dataPickerView.frame.size.height,dataPickerView.frame.size.width,dataPickerView.frame.size.height);
    }];
    
    
}
- (IBAction)dateSelected:(id)sender
{
    CGRect screenSize=[[UIScreen mainScreen]bounds];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd-MM-YYYY"];
    SelectdDate=[format stringFromDate:dataPicker.date];
    [btnDob setTitle:SelectdDate forState:UIControlStateNormal];
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


#pragma mark - EditProfile_methods
#pragma mark -
- (IBAction)editProfile:(id)sender
{
    

    if ([self editValidation])
    {
        
        [self call_editProfile_API];
    }
    
  
}

-(void)call_editProfile_API
{
    [self add_progress_view];
    NSURL *url=[NSURL URLWithString:UpdateUserProfile_Url];
    NSMutableDictionary *requestDict=[[NSMutableDictionary alloc]init];
    [requestDict setObject:User_Id forKey:@"passenger_id"];
    [requestDict setObject:txtNo.text forKey:@"passenger_mobile"];
    [requestDict setObject:txtCompany.text forKey:@"company_name"];
    [requestDict setObject:userGender forKey:@"passenger_gender"];
    [requestDict setObject:txtName.text forKey:@"passenger_name"];
    [requestDict setObject:txtHomeLoc.text forKey:@"passenger_hose_loac"];
    [requestDict setObject:txtWorkLoc.text forKey:@"passenger_work_loac"];
    [requestDict setObject:btnDob.titleLabel.text forKey:@"passenger_dob"];
    [requestDict setObject:txtEmergencyNo.text forKey:@"passenger_emergency_num"];
    
   
    
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
            
            UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [a show];
            a.tag=2;
            
            
            
            
           
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

-(BOOL)editValidation
{
    
    BOOL isValid = false;
    if (txtName.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Full Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
        
    }
    
    else if (txtNo.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Contact No." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return false;
    }
    else if (!txtEmergencyNo.text.length==0)
    {
        if (txtEmergencyNo.text.length>10||txtEmergencyNo.text.length<10)
        {
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Valid Energency Contact No." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            return false;
            
        }
        else
        {
         return true;
            
        }
       
        
    }
    else
    {
        
        isValid = true;
    }
    
    return isValid;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
