//
//  HistoryDetails.m
//  Journe
//
//  Created by admin on 29/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "HistoryDetails.h"

@interface HistoryDetails ()

@end

@implementation HistoryDetails

- (void)viewDidLoad
{
    [super viewDidLoad];
    def=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDict=[def objectForKey:@"LoginUserDict"];
    User_Id=[userDict valueForKey:@"passenger_id"];
lblBusnumber.layer.cornerRadius = lblBusnumber.frame.size.height/2;
lblBusnumber.layer.borderWidth = 1;
lblBusnumber.layer.borderColor = [UIColor whiteColor].CGColor;
    NSMutableDictionary *dict=[def objectForKey:@"historydetailDict"];
    lblBookingId.text=[dict valueForKey:@"b_id"];
    bId=[dict valueForKey:@"b_id"];
    lblBusnumber.text=[dict valueForKey:@"bus_no"];
    lblDestinationAdd.text=[dict valueForKey:@"destination"];
    lblDetinationTime.text=[dict valueForKey:@"destination_time"];
    lblSeatNo.text=[NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"seats"],[dict valueForKey:@"ac_type"]];
    lblSourceAdd.text=[dict valueForKey:@"source"];
    lblSourceTime.text=[dict valueForKey:@"source_time"];
    lblTotalCost.text=[NSString stringWithFormat:@"Rs %@.00",[dict valueForKey:@"price"]];
    NSString *status=[dict valueForKey:@"status"];
    if ([status isEqualToString:@"Completed"])
    {
    
    if ([[dict valueForKey:@"feedback_status"] isEqualToString:@"0"])
    {
        btnfeedback.enabled=true;
        [btnfeedback setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [btnfeedback setImage:[UIImage imageNamed:@"feeback_active.png"] forState:UIControlStateNormal];
        [btnfeedback setBackgroundColor:[HexColorToUIColor colorFromHexString:@"#303030"]];
        
        
    }
    if ([[dict valueForKey:@"feedback_status"] isEqualToString:@"1"])
    {
        btnfeedback.enabled=false;
        [btnfeedback setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btnfeedback setImage:[UIImage imageNamed:@"feeback_inactive.png"] forState:UIControlStateNormal];
        [btnfeedback setBackgroundColor:[UIColor blackColor]];
        
    }
    }
    else
    {
        
        btnfeedback.enabled=false;
        [btnfeedback setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btnfeedback setBackgroundColor:[UIColor lightGrayColor]];
       
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Feedback
#pragma  mark -
-(IBAction)feedback:(id)sender
{
   [def setObject:lblBookingId.text forKey:@"feedback_bId"];
    FeedbackVC *Cp = [[FeedbackVC alloc] initWithNibName:@"FeedbackVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    [self.navigationController pushViewController:objISVC animated:YES];
    
    
}
#pragma  mark - MenuMethods
#pragma  mark -
-(IBAction)actionMenu:(id)sender
{
   
    [self.navigationController popViewControllerAnimated:true];
}
@end
