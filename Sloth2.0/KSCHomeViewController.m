//
//  KSCHomeViewController.m
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/5/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import "KSCHomeViewController.h"
#import "KSCClassesModel.h"
#import "Parse/Parse.h"




@interface KSCHomeViewController ()
@property (strong) NSMutableArray* todaysClasses;
@property (strong,nonatomic) KSCClassesModel *model;
@property (weak, nonatomic) IBOutlet UITableView *todaysClassesTable;
@property (weak, nonatomic) IBOutlet UIButton *checkInButton;

@end

NSInteger absences;
BOOL checkedIn = NO;

@implementation KSCHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
           }
    return self;
}

-(void)doTimedAction:(NSTimer *)timer {
    NSLog(@"1 minute past class. Time check user.");
    if (checkedIn == NO) {
        absences++;
        NSLog(@"ABSENCES: %d", absences);
        [_todaysClasses removeObjectAtIndex:0];
        
        [_todaysClassesTable reloadData];
        NSString* number = [[PFUser currentUser] objectForKey:@"phoneNumber"];
        NSLog(@"Sending text to %@", number);
        
        NSString* message = [[PFUser currentUser] objectForKey:@"textMessage"];

        NSString *phoneNumber = @"+1";
        phoneNumber = [phoneNumber stringByAppendingString:number];
        
       // NSString* number = @"+15102833032";
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:phoneNumber forKey:@"number"];
        [params setObject:message forKey:@"message"];
        
        [PFCloud callFunctionInBackground:@"inviteWithTwilio" withParameters:params block:^(id object, NSError *error) {
            NSString *message = @"";
            if (!error) {
                message = @"Dear Sloth: Work Harder!";
            } else {
                message = @"Uh oh, something went wrong :(";
            }
            
            [[[UIAlertView alloc] initWithTitle:@"Invite Sent!"
                                        message:message
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil, nil] show];
        }];
        
    }
    else {
        checkedIn = NO;
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.model = [KSCClassesModel sharedModel];
    
    PFQuery *classQuery = [PFQuery queryWithClassName:@"Class"];
    
    // Follow relationship
    [classQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    
    NSArray* objects = [classQuery findObjects];
    
    
            NSLog(@"SIZE OF PARSE ARRAY %d", objects.count);
            for (int i = 0; i < objects.count; i++)
            {
                
                PFObject *class = [objects objectAtIndex:i];
                NSString* className = [class objectForKey:@"name"];
                double xLoc = [[class objectForKey:@"xlocation"] doubleValue];
                double yLoc = [[class objectForKey:@"ylocation"] doubleValue];
                NSString* days = [class objectForKey:@"days"];
                NSDate* start = [class objectForKey:@"start"];
                NSDate* end = [class objectForKey:@"end"];

                 [self.model insertClass: [[KSCClass alloc] initWithSectionName:className andStartTime:start andxLoc:xLoc andyLoc:yLoc andEndTime:end andDays:days] atIndex:i];

                
            }
     
    
    
  
    
    _todaysClasses = [[NSMutableArray alloc] init];
    [self.checkInButton setEnabled:NO];
    NSDate *today = [NSDate date];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
    [myFormatter setDateFormat:@"c"]; // day number, like 7 for saturday
    NSString *dayOfWeek = [myFormatter stringFromDate:today];
    //NSLog(@"Today is: %@", dayOfWeek);
    
    
    
    
    //NSString * firstLetter = [_model. substringToIndex:1];
    
    for (int i = 0; i < _model.numberOfClasses; i++) {
        if ([_model classAtIndex:i]) {
            NSString* firstDay = [[_model classAtIndex:i].daysOfClass substringToIndex:1];
            NSString* secondDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(1, 1)];
            NSString* thirdDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(2, 1)];
            NSString* fourthDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(3, 1)];
            NSString* fifthDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(4, 1)];
            
            if ([dayOfWeek isEqualToString:@"2"] && [firstDay isEqualToString:@"1"]) {
                NSLog(@"Monday Class");
                [_todaysClasses addObject:[_model classAtIndex:i]];
                
                           }
            else if ([dayOfWeek isEqualToString:@"3"] && [secondDay isEqualToString:@"1"]) {
                NSLog(@"Tuesday Class");
                [_todaysClasses insertObject:[_model classAtIndex:i] atIndex:[_todaysClasses count]];
            }
            else if ([dayOfWeek isEqualToString:@"4"] && [thirdDay isEqualToString:@"1"]) {
                NSLog(@"Wednesday Class");
                [_todaysClasses insertObject:[_model classAtIndex:i] atIndex:[_todaysClasses count]];
            }
            else if ([dayOfWeek isEqualToString:@"5"] && [fourthDay isEqualToString:@"1"]) {
                NSLog(@"Thursday Class");
                [_todaysClasses insertObject:[_model classAtIndex:i] atIndex:[_todaysClasses count]];
            }
            else if ([dayOfWeek isEqualToString:@"6"] && [fifthDay isEqualToString:@"1"]) {
                NSLog(@"Friday Class");
                [_todaysClasses insertObject:[_model classAtIndex:i] atIndex:[_todaysClasses count]];
            }

        }

    }
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES];
    [_todaysClasses sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    [self.todaysClassesTable reloadData];
    
    NSDate *startTime = [[_todaysClasses objectAtIndex:0] startTime];
    NSTimeInterval secondsIn15MinutesAfter = 60;
    NSDate *missedClass = [startTime dateByAddingTimeInterval:secondsIn15MinutesAfter];
    
    
    NSTimer *timer = [[NSTimer alloc]
                      initWithFireDate:missedClass
                      interval:0.0
                      target:self
                      selector:@selector(doTimedAction:)
                      userInfo:nil
                      repeats:NO];
    
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:timer forMode: NSDefaultRunLoopMode];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.todaysClasses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ClassCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[_todaysClasses objectAtIndex:[indexPath row]] sectionName];
    
    NSDate *startTime = [[_todaysClasses objectAtIndex:[indexPath row]] startTime];
    NSDateFormatter *startTimeFormat = [[NSDateFormatter alloc] init];
    [startTimeFormat setDateFormat:@"hh:mm a"];
    cell.detailTextLabel.text = [startTimeFormat stringFromDate:startTime];
    
    return cell;
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        NSDate* now = [NSDate date];
        NSTimeInterval secondsIn15MinutesAfter = 60*15;
        NSDate *startTime = [[_todaysClasses objectAtIndex:0] startTime];
        NSTimeInterval timeFromClass = [now timeIntervalSinceDate:startTime];
        NSTimeInterval secondsIn15MinutesBefore = -1*60*15;

        if ((timeFromClass < secondsIn15MinutesAfter) && (timeFromClass > secondsIn15MinutesBefore))  {
            self.checkInButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.478 blue:1 alpha:1] CGColor];
            self.checkInButton.enabled = YES;
            
        }
    }
    
}

- (IBAction)checkButtonPressed:(id)sender {
    
    CLLocationCoordinate2D coordinate = [self getLocation];

    double currentX = coordinate.latitude;
    double currentY = coordinate.longitude;
    double classXLocation = [[_todaysClasses objectAtIndex:0] xLocation];
    double classYLocation = [[_todaysClasses objectAtIndex:0] yLocation];
    if ((abs(currentX-classXLocation) < .0002) && (abs(currentY-classYLocation))) {
        checkedIn = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Checked In!"
                                                    message:@"Congrats on not being a Sloth"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
        [alert show];
        [_todaysClasses removeObjectAtIndex:0];
        [_todaysClassesTable reloadData];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"LOL"
                                                        message:@"Nice try. Get to Class!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }

}


-(CLLocationCoordinate2D) getLocation{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
