//
//  YourRideVC.h
//  Journe_Driver
//
//  Created by admin on 07/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Constant.h"
#import "Annotation_aroundme.h"

@interface YourRideVC : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MBProgressHUD *HUD;
    NSUserDefaults *def;
    NSString *bID;
    NSMutableArray *RespArray,*LatLongArray;
      IBOutlet MKMapView *map;
    float latitud,Longitud;
    CLLocationCoordinate2D coordinate;
        IBOutlet UILabel *lblBusnumber;
        IBOutlet UILabel *lblDestinationAdd;
        IBOutlet UILabel *lblDetinationTime;
    
    IBOutlet UILabel *lblSourceAdd;
    IBOutlet UILabel *lblSourceTime;
    CLLocationManager *location;

    
}

@end
