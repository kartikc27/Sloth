//
//  KSCMapViewController.m
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/4/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import "KSCMapViewController.h"

@interface KSCMapViewController ()

@end

@implementation KSCMapViewController

@synthesize mapView;

static CLLocationCoordinate2D coordinateOfAnnotation;
bool placeSelected = false;
MKPointAnnotation *dropPin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:longPressGesture];
    //mapView.userTrackingMode=YES;
    MKCoordinateRegion mapRegion;
    mapRegion.center = CLLocationCoordinate2DMake(34.068908, -118.445192);
    mapRegion.span.latitudeDelta = 0.02;
    mapRegion.span.longitudeDelta = 0.02;
    
    [mapView setRegion:mapRegion animated: YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)handleLongPressGesture:(UIGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        //[self.mapView removeGestureRecognizer:sender];
    }
    else
    {
        // Here we get the CGPoint for the touch and convert it to latitude and longitude coordinates to display on the map
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        // Then all you have to do is create the annotation and add it to the map
        if(dropPin == NULL)
        {
            dropPin = [[MKPointAnnotation alloc] init];
        }
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(locCoord.latitude, locCoord.longitude);
        dropPin.coordinate = coord;
        placeSelected = true;
        coordinateOfAnnotation = coord;
        
        [self.mapView addAnnotation:dropPin];
    }
    
}

- (IBAction)saveTheLocation:(id)sender
{
    if(!placeSelected)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:@"You didn't drop a pin"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

+ (CLLocationCoordinate2D)coordinateOfAnnotation {
    return (coordinateOfAnnotation);
}




#pragma mark - Navigation




@end
