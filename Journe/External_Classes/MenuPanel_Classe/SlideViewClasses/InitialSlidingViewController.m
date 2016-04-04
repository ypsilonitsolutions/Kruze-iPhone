//
//  InitialSlidingViewController.m
//  ECSlidingViewController
//
//  Created by Administrator on 28/02/15.
//  Copyright (c) 2014 MaheshDhakad. All rights reserved.
//

#import "InitialSlidingViewController.h"

@implementation InitialSlidingViewController

- (void)viewDidLoad {
    
  [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
 }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return YES;
}

@end
