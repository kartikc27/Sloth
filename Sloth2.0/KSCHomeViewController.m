//
//  KSCHomeViewController.m
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/5/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import "KSCHomeViewController.h"
#import "KSCStatisticsViewController.h"
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
        [[PFUser currentUser] setObject:[NSNumber numberWithInteger:absences] forKey:@"allowedAbsences"];
        
        PFQuery *classQuery = [PFQuery queryWithClassName:@"Class"];
        [classQuery whereKey:@"user" equalTo:[PFUser currentUser]];
        //NSArray* objects = [classQuery findObjects];
        
        PFQuery *missedClassQuery = [PFQuery queryWithClassName:@"Class"];
        [missedClassQuery whereKey:@"name" equalTo:[[_todaysClasses objectAtIndex:0] sectionName]];
        
        PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[classQuery,missedClassQuery]];
        PFObject* object = [mainQuery getFirstObject];
        [object deleteInBackground];
        
        
        
        if (_todaysClasses.count > 0) {
            [_todaysClasses removeObjectAtIndex:0];
        }
        
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
                message = @"Work Harder!";
            } 
            
            [[[UIAlertView alloc] initWithTitle:@"Dear Sloth"
                                        message:message
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil] show];
        }];
        
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    checkedIn = NO;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.model = [KSCClassesModel sharedModel];
    
    PFQuery *classQuery = [PFQuery queryWithClassName:@"Class"];
    
    // Follow relationship
    [classQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    
    NSArray* objects = [classQuery findObjects];
    
    if (objects.count > 0)
    {
   
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
    
    int total = [self.model numberOfClasses];
    if (objects.count >1) {
        for (int i = (total-objects.count); i<total; i++) {
            [self.model removeClassAtIndex:i];
        }
    }
    
    
  
    
    _todaysClasses = [[NSMutableArray alloc] init];
    [self.checkInButton setEnabled:NO];
    NSDate *today = [NSDate date];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
    [myFormatter setDateFormat:@"c"]; // day number, like 7 for saturday
    NSString *dayOfWeek = [myFormatter stringFromDate:today];

    
    for (int i = 0; i < _model.numberOfClasses; i++) {
        if ([_model classAtIndex:i]) {
            NSString* firstDay = [[_model classAtIndex:i].daysOfClass substringToIndex:1];
            NSString* secondDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(1, 1)];
            NSString* thirdDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(2, 1)];
            NSString* fourthDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(3, 1)];
            NSString* fifthDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(4, 1)];
            
            if ([dayOfWeek isEqualToString:@"2"] && [firstDay isEqualToString:@"1"]) {
                [_todaysClasses addObject:[_model classAtIndex:i]];
                
                           }
            else if ([dayOfWeek isEqualToString:@"3"] && [secondDay isEqualToString:@"1"]) {
                [_todaysClasses insertObject:[_model classAtIndex:i] atIndex:[_todaysClasses count]];
            }
            else if ([dayOfWeek isEqualToString:@"4"] && [thirdDay isEqualToString:@"1"]) {
                [_todaysClasses insertObject:[_model classAtIndex:i] atIndex:[_todaysClasses count]];
            }
            else if ([dayOfWeek isEqualToString:@"5"] && [fourthDay isEqualToString:@"1"]) {
                [_todaysClasses insertObject:[_model classAtIndex:i] atIndex:[_todaysClasses count]];
            }
            else if ([dayOfWeek isEqualToString:@"6"] && [fifthDay isEqualToString:@"1"]) {
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
    
    [locationManager startUpdatingLocation];


    /*double currentX = coordinate.latitude;
    double currentY = coordinate.longitude;
    NSLog(@"%f %f", currentX, currentY);
    double classXLocation = [[_todaysClasses objectAtIndex:0] xLocation];
    double classYLocation = [[_todaysClasses objectAtIndex:0] yLocation];
    if ((abs(currentX-classXLocation) < 2) && (abs(currentY-classYLocation) < 2)) {
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
        
    }*/

}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
    double currentX = newLocation.coordinate.latitude;
    double currentY = newLocation.coordinate.longitude;
    NSLog(@"%f %f", currentX, currentY);
    double classXLocation = [[_todaysClasses objectAtIndex:0] xLocation];
    double classYLocation = [[_todaysClasses objectAtIndex:0] yLocation];
    if ((abs(currentX-classXLocation) < 2) && (abs(currentY-classYLocation) < 2)) {
        checkedIn = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Checked In!"
                                                        message:@"Congrats on not being a Sloth"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [locationManager stopUpdatingLocation];
        
        if (_todaysClasses.count > 0) {
            PFQuery *classQuery = [PFQuery queryWithClassName:@"Class"];
            [classQuery whereKey:@"user" equalTo:[PFUser currentUser]];
            //NSArray* objects = [classQuery findObjects];
            
            PFQuery *missedClassQuery = [PFQuery queryWithClassName:@"Class"];
            [missedClassQuery whereKey:@"name" equalTo:[[_todaysClasses objectAtIndex:0] sectionName]];
            
            PFQuery *mainQuery = [PFQuery orQueryWithSubqueries:@[classQuery,missedClassQuery]];
            PFObject* object = [mainQuery getFirstObject];
            [object deleteInBackground];
            [_todaysClasses removeObjectAtIndex:0];
        }
        [_todaysClassesTable reloadData];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"LOL"
                                                        message:@"Nice try. Get to Class!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [locationManager stopUpdatingLocation];
    }

}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    KSCStatisticsViewController*  viewController =  [segue destinationViewController];
    //viewController.title = @"TESTING";
    [viewController setAbsences:absences];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
