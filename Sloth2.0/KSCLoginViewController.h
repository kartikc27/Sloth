//  Created by Kartik Chillakanti (chillaka@usc.edu) on 5/3/14.
//  Copyright (c) 2014 KSC. All rights reserved.
#import <UIKit/UIKit.h>

@interface KSCLoginViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)loginButtonTouchHandler:(id)sender;

@end
