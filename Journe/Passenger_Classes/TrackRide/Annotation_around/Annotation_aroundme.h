//
//  Annotation.h
//  map
//
//  Created by universal informatics on 02/03/15.
//  Copyright (c) 2015 universal informatics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Annotation_aroundme : NSObject<MKAnnotation>
//@property NSString *add;
@property(nonatomic,readonly)CLLocationCoordinate2D coordinate;
@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *subtitle;
@property (copy,nonatomic)NSString *state;
@property (copy,nonatomic)NSString *street;

@property (copy,nonatomic) UIButton *button;
@property NSString *img;
@property UILabel *name;
@property int ratingCount;
@property int tags;
-(id)initWithTitle :(NSString *)newtitle  Location:(CLLocationCoordinate2D)coordinate imagename:img;
-(id)initWithTitle :(NSString *)newtitle  Location:(CLLocationCoordinate2D)coordinate imagename:(id)img Ratings:(int)rating Tag:(int)tag state:(NSString*)state street:(NSString*)street;
-(MKAnnotationView *)annotationView;

@end
