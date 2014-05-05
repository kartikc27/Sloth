//
//  KSCHomeViewController.m
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/5/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import "KSCHomeViewController.h"
#import "KSCClassesModel.h"



@interface KSCHomeViewController ()
@property (strong) NSMutableArray* todaysClasses;
@property (strong,nonatomic) KSCClassesModel *model;
@property (weak, nonatomic) IBOutlet UITableView *todaysClassesTable;

@end

@implementation KSCHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
           }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    
    _todaysClasses = [[NSMutableArray alloc] init];

    NSDate *today = [NSDate date];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
    [myFormatter setDateFormat:@"c"]; // day number, like 7 for saturday
    NSString *dayOfWeek = [myFormatter stringFromDate:today];
    NSLog(@"Today is: %@", dayOfWeek);
    
    
    self.model = [KSCClassesModel sharedModel];
    
    //NSString * firstLetter = [_model. substringToIndex:1];
    
    for (int i = 0; i < _model.numberOfClasses; i++) {
        if ([_model classAtIndex:i]) {
            NSString* firstDay = [[_model classAtIndex:i].daysOfClass substringToIndex:1];
            NSString* secondDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(1, 1)];
            NSString* thirdDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(2, 1)];
            NSString* fourthDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(3, 1)];
            NSString* fifthDay = [[_model classAtIndex:i].daysOfClass substringWithRange:NSMakeRange(4, 1)];
            
            /*NSLog(@"%@", firstDay);
            NSLog(@"%@", secondDay);
            NSLog(@"%@", thirdDay);
            NSLog(@"%@", fourthDay);
            NSLog(@"%@", fifthDay);*/
            
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
    
    for (int j = 0; j < _todaysClasses.count; j++) {
        NSLog(@"%@", [[_todaysClasses objectAtIndex:j] sectionName]);
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
