//
//  QRCodeClass.m
//  Journe
//
//  Created by admin on 11/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "QRCodeClass.h"

@interface QRCodeClass ()

@end

@implementation QRCodeClass
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"QRCodeClass";
            cell_nib=@"QRCodeCustomerCell";
            seat_cell_nib=@"QRCheckSeatCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"QRCodeClass_iPhone4";
            cell_nib=@"QRCodeCustomerCell";
            seat_cell_nib=@"QRCheckSeatCell";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"QRCodeClass_iPhone6";
            cell_nib=@"QRCodeCustomerCell_iPhone6";
            seat_cell_nib=@"QRCheckSeatCell";
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"QRCodeClass_iPhone6plus";
            cell_nib=@"QRCodeCustomerCell_iPhone6plus";
            seat_cell_nib=@"QRCheckSeatCell";
        }
    }
    else
    {
        nibName=@"QRCodeClass_iPad";
        cell_nib=@"QRCodeCustomerCell_iPad";
        seat_cell_nib=@"QRCheckSeatCell";
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
    BtnProceed.layer.borderWidth=1;
    BtnProceed.clipsToBounds = YES;
    BtnProceed.layer.cornerRadius = BtnProceed.frame.size.height/2.0f;
    BtnProceed.layer.borderColor=sky_blue_color;
    
    
    BtnVerfyUserNumber.layer.borderWidth=1;
    BtnVerfyUserNumber.clipsToBounds = YES;
    BtnVerfyUserNumber.layer.cornerRadius = BtnVerfyUserNumber.frame.size.height/2.0f;
    BtnVerfyUserNumber.layer.borderColor=sky_blue_color;
    seatsArray=[[NSMutableArray alloc] init];
    [BtnVerfyUserNumber addTarget:self action:@selector(verifyMobileNumber) forControlEvents:UIControlEventTouchUpInside];
    [seatCheckDoneBtn addTarget:self action:@selector(didPressSeatsDoneButton) forControlEvents:UIControlEventTouchUpInside];
    
    verifidUsers=[[NSMutableArray alloc]init];
    absentUsers=[[NSMutableArray alloc]init];
    
    verfyingIndex=-1;
    [self getPassengerList];
    [self Scan_QRCode];
}


#pragma mark- Passenger List
#pragma mark-
-(void)getPassengerList
{
    [self add_progress_view];
    NSString *trip_id=[def objectForKey:@"trip_id"];
    NSString *bus_id=[def objectForKey:@"bus_id"];
    NSString *stop_id=[def objectForKey:@"stop_id"];
    NSString *str = [NSString stringWithFormat:@"%@?b_trip_id=%@&b_bus_id=%@&stop_id=%@",Passenger_booking_URL,trip_id,bus_id,stop_id];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:YES];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
             customersArray=[response objectForKey:@"booking_list"];
             mainArray=[[NSMutableArray alloc] initWithArray:customersArray];
             [_table reloadData];
         }
     }];
}



#pragma mark- Send Verify Users To Server
#pragma mark-
-(void)send_verifiedUsers
{
    [self add_progress_view];
   
    NSError *error;
    NSData *postData1 = [NSJSONSerialization dataWithJSONObject:verifidUsers options:0 error:&error];
    
    NSString *jsonString1 = [[NSString alloc] initWithData:postData1 encoding:NSUTF8StringEncoding];
    
    NSString *str = [NSString stringWithFormat:@"%@?booking_json=%@",BoardedPassengerURL,jsonString1];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes data, NSString *status) {
        [HUD hide:YES];
        
        
        
        
        if([[response objectForKey:@"status"] isEqualToString:@"true"])
        {
            [def setObject:@"1" forKey:@"shouldShowNext"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [al show];
        }
    }];
}



#pragma mark- Send Absent Users To Server
#pragma mark-
-(void)send_absentUsers
{
    [self add_progress_view];
    NSError *error;
    NSData *postData1 = [NSJSONSerialization dataWithJSONObject:absentUsers options:0 error:&error];
    
    NSString *jsonString1 = [[NSString alloc] initWithData:postData1 encoding:NSUTF8StringEncoding];
    
    NSString *str = [NSString stringWithFormat:@"%@?booking_json=%@",AbsentPassengerURL,jsonString1];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes data, NSString *status) {
        [HUD hide:YES];
        if ([[response objectForKey:@"status"] isEqualToString:@"true"])
        {
            UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [al show];
        }
        else
        {
            UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [al show];
        }
    }];
}

#pragma mark-


#pragma mark- Scan QRCode
#pragma mark-
-(void)Scan_QRCode
{
    // _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    
    
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = _highlightView.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_highlightView.layer addSublayer:_prevLayer];
    
    [_session startRunning];
    
    //[self.view bringSubviewToFront:_highlightView];
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        if (detectionString != nil)
        {
            _label = detectionString;
            [self match_code];
            
        }
        else
            _label = @"";
    }
    //_highlightView.frame = highlightViewRect;
}
#pragma mark-




#pragma mark- Matching code with user's code
#pragma mark-
-(void)match_code
{
   [_session stopRunning];
   
    
    passengerArray=[[NSMutableArray alloc] init];
    
  __block NSArray *bookID=[verifidUsers valueForKey:@"booking_id"];
    
  __block BOOL alreadyDone;
    
    
    [customersArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        NSMutableDictionary *d=obj;
        
        NSString *code=[d objectForKey:@"b_qr_code"];
        
        NSString *payment_status=[d objectForKey:@"b_payment_status"];
        NSString *passenger_phone=[d objectForKey:@"passenger_mobile"];
        
        NSString *bookingID=[d objectForKey:@"b_id"];

        NSString *seatStings=[d objectForKey:@"seats"];
        
        NSArray *ar=[seatStings componentsSeparatedByString:@","];
       
        if ([code isEqualToString:_label])
        {
            [passengerArray addObject:d];
        
        if (passengerArray.count==1)
        {
            if ([bookID containsObject:bookingID])
            {
                alreadyDone=true;
            }
            else if (ar.count>0)
            {
                lblTicketPassengerName.text=[d objectForKey:@"passenger_name"];
                
                for (int i=0; i<ar.count; i++)
                {
                
                NSString *str=[ar objectAtIndex:i];
                NSMutableDictionary *dicti=[NSMutableDictionary new];
                [dicti setObject:str forKey:@"seat"];
                [dicti setObject:@"1" forKey:@"status"];
                [dicti setObject:bookingID forKey:@"booking_id"];
                [seatsArray addObject:dicti];
                    
                }
                
                if ([payment_status isEqualToString:@"2"])
                {
                    verfyingIndex=idx;
                }
            
            }else{
                
            if ([payment_status isEqualToString:@"2"])
            {
                verfyingIndex=idx;
            }
            else
            {
                
            [customersArray removeObjectAtIndex:idx];
            [d setValue:@"2" forKey:@"b_status"];
            [customersArray insertObject:d atIndex:idx];
            [_table reloadData];
            }
           }
          }
        }
        else if ([passenger_phone isEqualToString:passenger_mobile])
        {
            [passengerArray addObject:d];
            
        if (passengerArray.count==1)
          {
            if ([bookID containsObject:bookingID])
            {
                alreadyDone=true;
            }
            else if (ar.count>0)
            {
                //NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
                
                lblTicketPassengerName.text=[d objectForKey:@"passenger_name"];
                //passenger_mobile=@"";
                for (int i=0; i<ar.count; i++)
                {
                    NSMutableDictionary *dicti=[NSMutableDictionary new];
                    NSString *str=[ar objectAtIndex:i];
                    [dicti setObject:str forKey:@"seat"];
                    [dicti setObject:@"1" forKey:@"status"];
                    [dicti setObject:bookingID forKey:@"booking_id"];
                    [seatsArray addObject:dicti];
                }
                
                if ([payment_status isEqualToString:@"2"])
                {
                    verfyingIndex=idx;
                }
                
            }else
            {
                
            if ([payment_status isEqualToString:@"2"])
            {
                verfyingIndex=idx;
            }
            else
            {
                [customersArray removeObjectAtIndex:idx];
                [d setValue:@"2" forKey:@"b_status"];
                [customersArray insertObject:d atIndex:idx];
                [_table reloadData];
            }
           }
          }
        }
    }];

    if (seatsArray.count>0)
    {
        seatCheckBgView.hidden=false;
        [seatsTable reloadData];
    }
//    else if (seatsArray.count==1)
//    {
//        
//        [_session stopRunning];
//        NSMutableDictionary *di=[customersArray objectAtIndex:verfyingIndex];
//        NSString *payment_msg=[NSString stringWithFormat:@"Did you get %@ amount from this user",[di objectForKey:@"b_payment_amount"]];
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:payment_msg delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
//        alert.tag=3;
//        [alert show];
//        
//        
//    }
    else if(alreadyDone)
    {
        alreadyDone=false;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"User not matched!!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        alert.tag=5;
        [alert show];
    }
    else if (verfyingIndex!=-1)
    {
        
         [_session stopRunning];
        NSMutableDictionary *d=[mainArray objectAtIndex:verfyingIndex];
        NSString *payment_msg=[NSString stringWithFormat:@"Did you get %@ amount from this user",[d objectForKey:@"b_payment_amount"]];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:payment_msg delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        alert.tag=3;
        [alert show];
    }
    
}

#pragma mark -



#pragma mark- TableView Delegates
#pragma mark-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==seatsTable)
    {
        return [seatsArray count];
    }
    else
    {
        return [customersArray count];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==seatsTable)
    {
    static NSString *simpleTableIdentifier = @"TableCellCustom";
    
    QRCheckSeatCell *cell = [seatsTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
    NSArray * nib = [[NSBundle mainBundle]loadNibNamed:seat_cell_nib owner:self options:nil];
    cell = [nib objectAtIndex:0];
    }
   NSMutableDictionary *d=[seatsArray objectAtIndex:indexPath.row];
        NSString *status=[d objectForKey:@"status"];
        NSString *seatNo=[d objectForKey:@"seat"];
        cell.lbl_seatNo.text=seatNo;
        if ([status isEqualToString:@"1"])
        {
            cell.img.image=[UIImage imageNamed:@""];
            
        }else
        {
            cell.img.image=[UIImage imageNamed:@"doneGreen"];
        }
        cell.selectionStyle=UITableViewCellEditingStyleNone;
      return cell;
    }
    
    else
    {
    static NSString *simpleTableIdentifier = @"TableCellCustom";
    
    QRCodeCustomerCell *cell = [_table dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:cell_nib owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    NSMutableDictionary *d=[customersArray objectAtIndex:indexPath.row];
    
    NSString *code=[d objectForKey:@"b_qr_code"];
    cell.QR_Code.text=code;
    NSString *status=[d objectForKey:@"b_status"];
    if ([status isEqualToString:@"1"])
    {
     cell.verify_Image.image=[UIImage imageNamed:@""];
    }
    else if ([status isEqualToString:@"2"])
    {
     cell.verify_Image.image=[UIImage imageNamed:@"doneGreen"];
    }
    cell.lblName.text=[d objectForKey:@"passenger_name"];
    cell.lblSource.text=[d objectForKey:@"from_stop"];
    cell.lblDestination.text=[d objectForKey:@"to_stop"];
    
    return cell;
    }
}

#pragma mark -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==seatsTable)
    {
        NSMutableDictionary *d=[seatsArray objectAtIndex:indexPath.row];
        NSString *status=[d objectForKey:@"status"];
        if ([status isEqualToString:@"1"])
        {
            [d setObject:@"2" forKey:@"status"];
            [seatsArray removeObjectAtIndex:indexPath.row];
            [seatsArray insertObject:d atIndex:indexPath.row];
            [seatsTable reloadData];
        }else if ([status isEqualToString:@"2"])
        {
            [d setObject:@"1" forKey:@"status"];
            [seatsArray removeObjectAtIndex:indexPath.row];
            [seatsArray insertObject:d atIndex:indexPath.row];
            [seatsTable reloadData];
        }
    }
}

-(void)didPressSeatsDoneButton
{
    NSArray *bookingIDArr=[seatsArray valueForKey:@"booking_id"];
    
    NSString *booking_id=[bookingIDArr firstObject];
    
    dict=[NSMutableDictionary new];
    
    dict1=[NSMutableDictionary new];
    
    [dict setObject:booking_id forKey:@"booking_id"];
   
    [dict1 setObject:booking_id forKey:@"booking_id"];
    
    __block  NSMutableArray *tempArr=[NSMutableArray new];

  
    __block  NSMutableArray *tempArr1=[NSMutableArray new];
    
    [seatsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *st=[obj objectForKey:@"status"];
        
        if ([st isEqualToString:@"2"])
        {
        
        //For verified users
        [tempArr addObject:[obj objectForKey:@"seat"]];
            
        }
        
        else if ([st isEqualToString:@"1"])
        {
        
        //For absent users
        [tempArr1 addObject:[obj objectForKey:@"seat"]];
            
        }
        
    }];
    if (tempArr.count>0) {
     [dict setObject:tempArr forKey:@"seat"];
    }
    else
    {
        dict=[NSMutableDictionary new];
    }
    
    if (tempArr1.count>0)
    {
        [dict1 setObject:tempArr1 forKey:@"seat"];
    }
    else
    {
        dict1=[NSMutableDictionary new];
    }
    
    [seatCheckBgView setHidden:YES];

    if (verfyingIndex!=-1 && dict.count>0)
    {
        [_session stopRunning];
        NSMutableDictionary *di=[customersArray objectAtIndex:verfyingIndex];
        NSString *payment_msg=[NSString stringWithFormat:@"Did you get %@ amount from this user",[di objectForKey:@"b_payment_amount"]];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:payment_msg delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        alert.tag=4;
        [alert show];
    }
    else
    {
        [_session startRunning];
        seatsArray=[NSMutableArray new];
        if (dict.count>0)
        {
            
         [verifidUsers addObject:dict];
            
        }
        else if(dict1.count>0)
        {
            
        [absentUsers addObject:dict1];
        
        }
        if (passengerArray.count>1)
        {
         NSLog(@"%@",passengerArray);
        }
    }
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark- Getting Absent users
#pragma mark-
- (IBAction)ContactCustomerCare:(id)sender
{
    
    int total=(int)[mainArray count];
    int absent=(int)[absentUsers count];
    //int absent=total-verified;
    if (absent==0)
    {
        return;
    }
    NSLog(@"absent passengers %d %@",absent,absentUsers);
    
   UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Message!!" message:[NSString stringWithFormat:@"%d out of %d passengers are absent.\nDo you want to proceed now?",absent,total] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] ;
    alert.tag=2;
    [alert show];
    
}

#pragma mark -

#pragma mark- Proceed Action
#pragma mark-
- (IBAction)Proceed:(id)sender
{
   
    

    int total=(int)[mainArray count];
    int verified=(int)[verifidUsers count];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[NSString stringWithFormat:@"%d out of %d passengers are boarded.\nDo you want to proceed now?",verified,total] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alert.tag=1;
    [alert show];
}


#pragma mark -


#pragma mark- AlertView Delegate
#pragma mark-
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)
    {
        [_session startRunning];
        if (buttonIndex==1)
        {
            [self send_verifiedUsers];
        }
    }
    else if (alertView.tag==2)
    {
        [_session startRunning];
        if (buttonIndex==1)
        {
            [self send_absentUsers];
        }
    }
    else if (alertView.tag==3)
    {
        [_session startRunning];
        if (buttonIndex==1)
        {
            NSMutableDictionary *d=[customersArray objectAtIndex:verfyingIndex];
            [customersArray removeObjectAtIndex:verfyingIndex];
            [d setValue:@"2" forKey:@"b_status"];
            [customersArray insertObject:d atIndex:verfyingIndex];
            [_table reloadData];
        }
    }
    else if (alertView.tag==4)
    {
        
        [_session startRunning];
        
        if (buttonIndex==1)
        {

            [verifidUsers addObject:dict];

            [absentUsers addObject:dict1];

            [customersArray removeObjectAtIndex:verfyingIndex];
            
            [_table reloadData];
            
            seatsArray=[NSMutableArray new];
            
        }
        else
        {
            seatsArray=[NSMutableArray new];
        }
        if (passengerArray.count>1)
        {
            [passengerArray removeObjectAtIndex:verfyingIndex];
            [self match_code];
        }
    }else if (alertView.tag==5)
    {
        [_session startRunning];
    }
}

#pragma mark -



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
#pragma mark -




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)verifyUserAction:(id)sender
{
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
    [verifyBgView addGestureRecognizer:singleFingerTap];
    verifyBgView.hidden=false;
    verifyBgView.alpha=0;
    verifyInnerView.layer.borderWidth=2.0f;
    verifyInnerView.layer.borderColor=sky_blue_color;
    verifyInnerView.frame=CGRectMake(0, -verifyInnerView.frame.size.height, verifyInnerView.frame.size.width, verifyInnerView.frame.size.height);
    
    [UIView animateWithDuration:.8 animations:^{
           verifyBgView.alpha=1;
           verifyInnerView.frame=CGRectMake(0, (self.view.frame.size.height/2)-(verifyInnerView.frame.size.height/2), verifyInnerView.frame.size.width, verifyInnerView.frame.size.height);
       }];
}



//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    verifyBgView.alpha=1;
    [UIView animateWithDuration:.8 animations:^{
        verifyBgView.alpha=0;
        verifyInnerView.frame=CGRectMake(0, -verifyInnerView.frame.size.height, verifyInnerView.frame.size.width, verifyInnerView.frame.size.height);
    }completion:^(BOOL finished) {
        verifyBgView.hidden=true;
    }];

}


-(void)verifyMobileNumber
{
    [self handleSingleTap:nil];
    passenger_mobile=txtPassengerNumber.text;
    txtPassengerNumber.text=@"";
    [self match_code];
}
@end
