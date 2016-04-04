//
//  ExpensesDetailsView.m
//  Journe
//
//  Created by admin on 10/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "ExpensesDetailsVC.h"

@interface ExpensesDetailsVC ()

@end

@implementation ExpensesDetailsVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"ExpensesDetailsVC";
           
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"ExpensesDetailsVC_iPhone4";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"ExpensesDetailsVC_iPhone6";
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"ExpensesDetailsVC_iPhone4plus";
        }
    }
    else
    {
        nibName=@"ExpensesDetailsVC_iPad";
        
        
    }
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    def=[NSUserDefaults standardUserDefaults];
    ImagebackGroundView.layer.borderWidth=1.0f;
    ImagebackGroundView.layer.borderColor=sky_blue_color;
    txtDesc.layer.cornerRadius = 3;
    txtDesc.layer.borderWidth = 1;
    txtDesc.layer.borderColor = sky_blue_color ;
    NSString *day=[def objectForKey:@"today"];
    today.text=day;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSMutableDictionary *dict=[def objectForKey:@"selected_expense"];
    
    lblExpense.text=[dict objectForKey:@"ec_name"];
    lblCost.text=[dict objectForKey:@"e_detail_cost"];
    lblDate.text=[dict objectForKey:@"e_detail_datetime"];
    lblKm.text=[dict objectForKey:@"e_detail_kms"];
    txtDesc.text=[dict objectForKey:@"e_desc"];
    
    [imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"e_detail_image"]]] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
