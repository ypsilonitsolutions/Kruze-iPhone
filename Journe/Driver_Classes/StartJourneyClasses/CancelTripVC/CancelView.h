//
//  CancelView.h
//  Journe
//
//  Created by admin on 30/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CancelView : UIView
@property (weak, nonatomic) IBOutlet UILabel *trip_name;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UILabel *tripID;
+ (id)cancelViewSet;
@end
