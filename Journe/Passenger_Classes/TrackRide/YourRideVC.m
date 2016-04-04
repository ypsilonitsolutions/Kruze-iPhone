//
//  YourRideVC.m
//  Journe_Driver
//
//  Created by admin on 07/03/16.
//  Copyright (c) 2016 apra.gj@gmail.com. All rights reserved.
//

#import "YourRideVC.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface YourRideVC ()

@end

@implementation YourRideVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibName=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height==568)
        {
            nibName=@"YourRideVC";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==480)
        {
            nibName=@"YourRideVC_4";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==667)
        {
            nibName=@"YourRideVC_6";
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height==736)
        {
            nibName=@"YourRideVC_6plus";
            
        }
    }
    else
    {
        nibName=@"YourRideVC_ipad";
        
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
lblBusnumber.layer.cornerRadius = lblBusnumber.frame.size.width / 2;
lblBusnumber.layer.borderWidth = 1;
lblBusnumber.layer.borderColor = [UIColor colorWithRed:0.149 green:0.663 blue:0.878 alpha:1] .CGColor;
    
    
    NSMutableDictionary *dict=[def objectForKey:@"detailDict"];
    lblBusnumber.text=[dict valueForKey:@"bus_no"];
    lblDestinationAdd.text=[dict valueForKey:@"destination"];
    lblDetinationTime.text=[dict valueForKey:@"destination_time"];
    lblSourceAdd.text=[dict valueForKey:@"source"];
    lblSourceTime.text=[dict valueForKey:@"source_time"];
    [map setZoomEnabled:YES];
    [map setScrollEnabled:YES];
    [map setUserInteractionEnabled:true];
// Do any additional setup after loading the view from its nib.
}

 - (void)applicationWillEnterForeground:(UIApplication *)application
{
 [NSTimer scheduledTimerWithTimeInterval:60.0
                                     target:self selector:@selector(fetchLocation)
                                   userInfo:nil
                                    repeats:YES];
    
}



-(void)fetchLocation
{
    bID=[def objectForKey:@"bookingID"];
    [self add_progress_view];
    NSString *str = [NSString stringWithFormat:@"%@?&b_id=%@",TrackRide_Url,bID];
    WebService *api = [WebService alloc];
    [api call_API:str OnResultBlock:^(id response, MDDataTypes mdDataType, NSString *status)
     {
         [HUD hide:true];
         if ([[response objectForKey:@"status"] isEqualToString:@"true"])
         {
        RespArray=[[NSMutableArray alloc]init];
        RespArray=[response objectForKey:@"logs"];
        LatLongArray=[[NSMutableArray alloc]init];
        for (int i=0; i<[RespArray count]; i++)
        {
        NSDictionary *dict=[RespArray objectAtIndex:i];
        float lat=[[dict valueForKey:@"gps_lat"]floatValue];
        float longi=[[dict valueForKey:@"gps_long"]floatValue];
        NSString *title=[dict valueForKey:@"gps_location"];
            
            if (lat!=0.0&&longi!=0.0)
            {
               
                CLLocationCoordinate2D myCord=CLLocationCoordinate2DMake(lat, longi);
                MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(myCord, 10000,10000);
                [map setRegion:region animated:YES];
                Annotation_aroundme  *A=[[Annotation_aroundme alloc]initWithTitle:title Location:myCord imagename:@"pin_icon"];
                [LatLongArray addObject:A];
                
                
                
            }
            
        
        }
        
        [self set_all_annotations];
             
         }
         else
         {
             
             UIAlertView *a=[[UIAlertView alloc] initWithTitle:@"Message!!" message:[response objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [a show];
         }
     }];
}

#pragma mark PolyLine_Method
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKTileOverlay class]])
    {
        return [[MKTileOverlayRenderer alloc] initWithOverlay:overlay];
    }
    else if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineRenderer* aView = [[MKPolylineRenderer alloc] initWithPolyline:(MKPolyline*)overlay];
         aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
            
            aView.lineWidth = 2;
       
        return aView;
    }
    return nil;
    
}

- (MKPolyline *)polyLine
{
    int im=(int)[LatLongArray count];
    CLLocationCoordinate2D coords[im];
    
    for (int i = 0; i < LatLongArray.count; i++) {
        CLLocation *location = [LatLongArray objectAtIndex:i];
        CLLocationCoordinate2D theLocation = location.coordinate;
        coords[i] = CLLocationCoordinate2DMake(theLocation.latitude, theLocation.longitude);
    }
    return [MKPolyline polylineWithCoordinates:coords count:LatLongArray.count];
}
#pragma mark - MAP METHOD's
#pragma mark -
- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString *TealAnnotationIdentifier = @"tealPin";
    
    MKAnnotationView *tealPinView =
    (MKAnnotationView *) [map dequeueReusableAnnotationViewWithIdentifier:TealAnnotationIdentifier];
    if (tealPinView == nil)
    {
        MKAnnotationView *tealAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:TealAnnotationIdentifier];
        tealAnnotationView.canShowCallout=YES;
        Annotation_aroundme *myLocation = (Annotation_aroundme *)annotation;
        //tealAnnotationView.frame=myLocation.annotationView.frame;
        tealAnnotationView = myLocation.annotationView;
        //tealAnnotationView.leftCalloutAccessoryView=nil;
        tealAnnotationView.image=[UIImage imageNamed:@"pin_icon"];
        return myLocation.annotationView;
    }
    else
    {
        tealPinView.annotation = annotation;
    }
    return tealPinView;
}


-(void)set_all_annotations
{
    [map addAnnotations:LatLongArray];
    [map addOverlay:[self polyLine]];
}



#pragma mark - REMOVE ALL ANNOTATIONS
#pragma mark -
-(void)remove_all_annotations
{
    [map removeAnnotations:LatLongArray];
    [LatLongArray removeAllObjects];
}

-(void)viewWillAppear:(BOOL)animated
{
[self fetchLocation];
[NSTimer scheduledTimerWithTimeInterval:60.0
                                     target:self
                                   selector:@selector(fetchLocation)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)callWebservice
{
    
    
    
}
-(IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)actionMonthlyPass:(id)sender
{
 
    
    
  
    
    
    
    
   
}
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
