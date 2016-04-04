//
//  Recent_TransVC.m
//  Journe_Driver
//
//  Created by admin on 19/02/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "Recent_TransVC.h"

@interface Recent_TransVC ()
{
    IBOutlet UITableView *TB;
}

@end

@implementation Recent_TransVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"Recent_TransVC";
            cellNib=@"RecentTransTVCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"Recent_TransVC_4";
             cellNib=@"RecentTransTVCell";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"Recent_TransVC_6";
             cellNib=@"RecentTransTVCell_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"Recent_TransVC_6plus";
             cellNib=@"RecentTransTVCell_6plus";
            
        }
    }
    else
    {
        nibName=@"Recent_TransVC_ipad";
         cellNib=@"RecentTransTVCell_ipad";
        
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Back_methods
#pragma mark -
-(IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - TableView_methods
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 4;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    static NSString *simpleTableIdentifier = @"TableCellCustom";
    RecentTransTVCell *cell = [TB dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:cellNib owner:self options:nil];
         cell = [nib objectAtIndex:0];
       
        
        
    }
    return cell;

    
   
    
}

#pragma  mark - Home_methods
#pragma mark -
- (IBAction)gohome:(id)sender
{
    DashboardVC *Cp = [[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
    InitialSlidingViewController *objISVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
    
    objISVC.topViewController = Cp;
    
    
    [self.navigationController pushViewController:objISVC animated:YES];
    
    
    
    
}



@end
