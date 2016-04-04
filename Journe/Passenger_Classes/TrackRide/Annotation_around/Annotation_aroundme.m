//
//  Annotation.m
//  map
//
//  Created by universal informatics on 02/03/15.
//  Copyright (c) 2015 universal informatics. All rights reserved.
//

#import "Annotation_aroundme.h"

@implementation Annotation_aroundme
-(id)initWithTitle :(NSString *)newtitle  Location:(CLLocationCoordinate2D)coordinate imagename:(id)img
{
    if(self)
    {
    _title = newtitle;
    _coordinate = coordinate;
    //_subtitle = @"";
    _img = img;
    }
    return self;
}
-(id)initWithTitle :(NSString *)newtitle  Location:(CLLocationCoordinate2D)coordinate imagename:(id)img Ratings:(int)rating Tag:(int)tag state:(NSString*)state street:(NSString*)street
{
    if(self)
    {
        _title = newtitle;
        _coordinate = coordinate;
        _img = img;
        _ratingCount=rating;
        _tags=tag;
        _state=state;
        _street=street;
    }
    return self;
}


-(MKAnnotationView *)annotationView
{
    MKAnnotationView *annotationView=[[MKAnnotationView alloc]initWithAnnotation: self reuseIdentifier:@"Annotation"];
    
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:_img];
        UIView *vw=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    annotationView.leftCalloutAccessoryView=vw;
    return annotationView;
}



@end
