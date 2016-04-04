//
//  DashboardVC.h
//  Journe
//
//  Created by admin on 20/01/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <CoreLocation/CoreLocation.h>
#import "RouteCell.h"

@interface DashboardVC : UIViewController <UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>
{
    IBOutlet UITextField *txtSource;
    IBOutlet UITextField *txtDestination;
    NSUserDefaults *nsud;
    MBProgressHUD *HUD;
    NSMutableArray *ResponseArray,*landmarkArray,*searchArray;
    NSString *cell_nib;
    NSMutableDictionary *userDict;
    NSMutableArray *city_array;
    IBOutlet UILabel *lbl_city;
    NSString *cityId,*latitude,*longitude,*cityName;
    NSString *tapCheck,*LocType,*setCityId;
    NSString *searchTxt,*selectedSource,*selectedDestination;
    IBOutlet UILabel *lblNoResult;
    IBOutlet UITableView *tableLandmark;
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UITableView *routeTable;

@end
