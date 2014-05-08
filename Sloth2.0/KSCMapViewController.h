//  Created by Kartik Chillakanti (chillaka@usc.edu) on 5/3/14.
//  Copyright (c) 2014 KSC. All rights reserved.

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "KSCInputClassesTableViewController.h"


@interface KSCMapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
+(CLLocationCoordinate2D) coordinateOfAnnotation;

@end
