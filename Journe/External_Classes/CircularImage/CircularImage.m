//
//  CircularImage.m
//  YourPlate
//
//  Created by universal informatics on 11/03/15.
//  Copyright (c) 2015 Imran Malik. All rights reserved.
//

#import "CircularImage.h"

@interface CircularImage ()

@end

@implementation CircularImage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
+ (instancetype)maskedImageWithImage:(UIImage *)image
{
    if (!image)
        return nil;
    CGFloat dim = MIN(image.size.width, image.size.height);
    CGSize size = CGSizeMake(dim, dim);
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:(CGRect){ CGPointZero, size }];
    [bezierPath fill];
    [bezierPath addClip];
    CGPoint offset = CGPointMake((dim - image.size.width) * 0.5, (dim - image.size.height) * 0.5);
    [image drawInRect:(CGRect){ offset, image.size }];
    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ret;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
