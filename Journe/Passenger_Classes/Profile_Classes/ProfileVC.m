//
//  ProfileVC.m
//  Journe
//
//  Created by admin on 04/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "ProfileVC.h"


@interface ProfileVC ()

@end

@implementation ProfileVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"ProfileVC";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"ProfileVC_4";
         
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"ProfileVC_6";
           
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"ProfileVC_6plus";
           
            
        }
    }
    else
    {
        nibName=@"ProfileVC_ipad";

        
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
    
    
    def=[NSUserDefaults standardUserDefaults];
    imgUser.layer.borderWidth=1;
    imgUser.clipsToBounds = YES;
    imgUser.layer.cornerRadius=imgUser.frame.size.height/2.0f;
    imgUser.layer.borderColor=sky_blue_color;
    cityArray=[[NSMutableArray alloc]init];
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
    SelectdDate=@"";
    btnEdit.enabled=true;
    btnEdit.backgroundColor=[UIColor whiteColor];
    btnEdit.clipsToBounds = YES;
    btnEdit.layer.cornerRadius=btnEdit.frame.size.height/2.0f;
    tableCity.layer.borderWidth=1;
    tableCity.layer.borderColor=sky_blue_color;
    [self settingView];
   
  }
-(void)viewWillAppear:(BOOL)animated

{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
  [[self navigationController] setNavigationBarHidden:YES animated:YES];
     [self call_UserProfile];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    ScrollView.contentSize=CGSizeMake(ScrollView.frame.size.width,ScrollView.frame.size.height+320);
}


#pragma  mark - SettingView_methods
#pragma mark -
-(void)settingView
{
    
    txtMAil.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtNo.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Phone Number" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtCompany.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Company Name" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtReferalCode.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Referal Code" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtEmergencyNo.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Emergency No." attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    txtWorkLoc.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Work Location" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
    txtHomeLoc.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Home Location" attributes:@{NSForegroundColorAttributeName: text_gray_color}];
    
   
    
    
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
             txtNo.text=[response valueForKey:@"passenger_mobile"];
        txtHomeLoc.text=[response valueForKey:@"passenger_hose_loac"];
        txtEmergencyNo.text=[response valueForKey:@"passenger_emergency_num"];
        txtCompany.text=[response valueForKey:@"passenger_company"];
        
        txtReferalCode.text=[response valueForKey:@"passenger_referral_code"];
        txtWorkLoc.text=[response valueForKey:@"passenger_work_loac"];
             if ([[response valueForKey:@"passenger_dob"] isEqualToString:@""])
             {
              [btnDob setTitle:@"Date Of Birth" forState:UIControlStateNormal];
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
                 userGender=0;
                 
                 
                 
               
             }
         }
         else
             
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
         }

     }];
  
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
#pragma  mark - ChangePassword_methods
#pragma mark -

- (IBAction)changePassword:(id)sender
{
    
    shadow.hidden=false;
    tableCity.hidden=true;
 
    
}
-(IBAction)doneChangePwdpressed:(id)sender
{
    
    if (txtOld.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Old Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
   else if (txtNew.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Confirm Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
   else if (txtConfirm.text.length==0)
    {
        
        [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Please Enter Confirm Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    }
   else if (![txtNew.text isEqualToString:txtConfirm.text])
   {
       
       [[[UIAlertView alloc] initWithTitle:@"Warning!" message:@"Password Not Matched" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
       
   }
    
    else
    {
        [self add_progress_view];
        NSString *str = [NSString stringWithFormat:@"%@?passenger_id=%@&old_pass=%@&new_pass=%@",PsgChangePwd_Url,User_Id,txtOld.text,txtNew.text];
        
        WebService *api = [WebService alloc];
        [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
         {
             [HUD hide:true];
             if ([[response objectForKey:@"status"] isEqualToString:@"true"])
             {
                 shadow.hidden=true;
                 UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [a show];
                 
             }
             else
                 
             {
                 shadow.hidden=true;
                 UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [a show];
                 
                 
             }
             
             
             
             
         }];
        
        
        
        
        
    }
    
    
    
}
-(IBAction)closeShadow:(id)sender
{
    
    txtOld.text=@"";
    txtNew.text=@"";
    txtConfirm.text=@"";
    shadow.hidden=true;
    
    
}

#pragma  mark - ChangePassword_methods
#pragma mark -

- (IBAction)changeCity:(id)sender
{
    
    if (InfoTap2==false)
    {
        
        [self add_progress_view];
        NSString *str = [NSString stringWithFormat:@"%@",City_list_Url];
        WebService *api = [WebService alloc];
        [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
         {
             [HUD hide:true];
             if ([[response objectForKey:@"status"] isEqualToString:@"true"])
             {
                 cityArray=[response objectForKey:@"city"];
                 [tableCity reloadData];
                 shadow.hidden=true;
                 tableCity.hidden=false;
                 InfoView.hidden=true;
                  InfoTap2=true;
                 
                 
             }
             else
                 
             {
                 shadow.hidden=true;
                 
                 UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [a show];
                 
                 
                 
             }
             
             
             
             
         }];
        

        
    }
    else
    {
        
        shadow.hidden=true;
        tableCity.hidden=true;
        InfoView.hidden=true;
         InfoTap2=false;
        
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
    return [cityArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    NSMutableDictionary *dict=[cityArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[dict valueForKey:@"city_name"];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSMutableDictionary *dict=[cityArray objectAtIndex:indexPath.row];
    [def setObject:[dict objectForKey:@"city_id"] forKey:@"CityId"];
    [def setObject:[dict objectForKey:@"city_name"] forKey:@"CityName"];
    [btnCity setTitle:[NSString stringWithFormat:@"    %@",[dict objectForKey:@"city_name"]] forState:UIControlStateNormal];
   
    shadow.hidden=true;
    tableCity.hidden=true;
    UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[NSString stringWithFormat:@"%@ Selected Succesfully",[dict objectForKey:@"city_name"] ] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [a show];
    
    
    
}


#pragma  mark - Slider_methods
#pragma mark -
- (IBAction)gotoSlider:(id)sender
{
   [self.slidingViewController anchorTopViewTo:ECRight];
    [self.view endEditing:true];
    
    
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



#pragma mark - EditProfile_methods
#pragma mark -
- (IBAction)editProfile:(id)sender
{
    

    
    EditProfileVC *nav = [[EditProfileVC alloc]initWithNibName:@"EditProfileVC" bundle:nil];
    
    [self.navigationController pushViewController:nav animated:YES];
  
    
    
    
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
