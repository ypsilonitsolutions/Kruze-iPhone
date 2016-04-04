//
//  MemberIdentificationVC.m
//  Journe
//
//  Created by admin on 28/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "MemberIdentificationVC.h"

@interface MemberIdentificationVC ()

@end

@implementation MemberIdentificationVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"MemberIdentificationVC";
          
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"MemberIdentificationVC_4";
            
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"MemberIdentificationVC_6";
      
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"MemberIdentificationVC_6plus";
         
            
            
        }
    }
    else
    {
        nibName=@"MemberIdentificationVC_ipad";
        
        
        
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
    [self setting_view];
    userDict=[nsud objectForKey:@"LoginUserDict"];
    lbl_comapny.text=[userDict valueForKey:@"passenger_company"];
    lbl_mail.text=[userDict valueForKey:@"passenger_email"];
    lbl_name.text=[userDict valueForKey:@"passenger_name"];
    NSURL *Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[userDict objectForKey:@"passenger_qrcode_image"]]];
    [imgQRCode setImageWithURL:Url placeholderImage:[UIImage imageNamed:@"qrcode_img_i.png"]];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated

{
    NSURL *Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[userDict objectForKey:@"passenger_image"]]];
    [img_user setImageWithURL:Url placeholderImage:[UIImage imageNamed:@"profile-1.png"]];
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
   
    
}


#pragma mark- SettingView_methods
#pragma mark-
-(void)setting_view
{
    img_user.layer.borderWidth=1;
    img_user.clipsToBounds = YES;
    img_user.layer.cornerRadius=img_user.frame.size.height/2.0f;
    img_user.layer.borderColor=sky_blue_color;
    nsud=[NSUserDefaults standardUserDefaults];
    [self getCompanyInfo];
    
}
#pragma mark- ProgressViewMethods
#pragma mark-
-(void)add_progress_view
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Processing...";
    HUD.square = YES;
    [HUD show:YES];
    
    
}
#pragma  mark - SendMessage_methods
#pragma mark -

-(void)getCompanyInfo
{
    [self add_progress_view];
    NSString *str=[NSString stringWithFormat:@"%@",CompanyDetails_Url];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             
             NSMutableDictionary *Dict=[response objectForKey:@"details"];
    lblHelp.text=[Dict valueForKey:@"c_detail_helpline_no"];
    mail.text=[Dict valueForKey:@"c_detail_email"];
        website.text=[Dict valueForKey:@"c_detail_website"];
             
         }
         else
             
         {
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
             
             
         }
         
     }];
    
    
    
    
    
    
    
}
#pragma mark- Print_methods
#pragma mark-

-(IBAction)printScreen:(id)sender
{
    
    UIImage *img=[self imageWithView:self.view];
    NSData *data=UIImageJPEGRepresentation(img, 1.0);
    if(![MFMailComposeViewController canSendMail]) {
        
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"No Mail Accounts" message:@"Please set up a Mail account in order to send email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSString *emailTitle = @"Kruze";
    NSArray *toRecipents = [NSArray arrayWithObject:[userDict valueForKey:@"passenger_email"]];
    NSString *htmlMsg = @"<html><body><p>Hey, check this out!</p></body></html>";
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc addAttachmentData:data mimeType:@"image/jpeg" fileName:@"test.jpeg"];
    [mc setMessageBody:htmlMsg isHTML:YES];
    [mc setToRecipients:toRecipents];
    [self presentViewController:mc animated:YES completion:nil];
    
    
    
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
  
        case MFMailComposeResultSent:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Message!!" message:@"Mail Sent Successfully.." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            NSLog(@"Mail sent");
            break;
        }
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:nil];
}


    
    
    
    
    
    
    
    
    




-(UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark- MenuPanel_methods
#pragma mark-
- (IBAction)slider:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
    [self.view endEditing:true];
}

@end
