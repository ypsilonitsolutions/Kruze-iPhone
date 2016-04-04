//
//  HexColorToUIColor.m
//  YourPlate
//
//  Created by universal informatics on 12/03/15.
//  Copyright (c) 2015 Imran Malik. All rights reserved.
//

#import "HexColorToUIColor.h"

@interface HexColorToUIColor ()

@end

@implementation HexColorToUIColor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (UIColor *)colorFromHexString:(NSString *)hex
    {
        unsigned rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hex];
        [scanner setScanLocation:1]; // bypass '#' character
        [scanner scanHexInt:&rgbValue];
        return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
@end
