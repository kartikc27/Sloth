//
//  KSCHomeViewController.h
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/5/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface KSCHomeViewController : UIViewController <UITableViewDelegate, CLLocationManagerDelegate>

@end

CLLocationManager *locationManager;

