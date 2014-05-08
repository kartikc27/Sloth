//  Created by Kartik Chillakanti (chillaka@usc.edu) on 5/3/14.
//  Copyright (c) 2014 KSC. All rights reserved.

#import "KSCAddClassesTableViewController.h"
#import "KSCClassesModel.h"

@interface KSCAddClassesTableViewController ()

@property (strong,nonatomic) KSCClassesModel *model;

@property (weak, nonatomic) IBOutlet UITableView *scheduleTable;
@end

@implementation KSCAddClassesTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.model = [KSCClassesModel sharedModel];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.scheduleTable reloadData];
    NSLog(@"TESTING %d", _model.numberOfClasses);
    
    if (_model.numberOfClasses > 0) {
     NSLog (@"%@", [self.model classAtIndex:0].sectionName);
     NSLog (@"%@", [self.model classAtIndex:0].daysOfClass);
     NSLog (@"%@", [self.model classAtIndex:0].startTime);
     NSLog (@"%@", [self.model classAtIndex:0].endTime);
     NSLog (@"%f", [self.model classAtIndex:0].xLocation);
     NSLog (@"%f", [self.model classAtIndex:0].yLocation);
    }
    
    //self.model = [[KSCClassesModel alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.model numberOfClasses];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ScheduleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.model classAtIndex:[indexPath row]].sectionName;
    return cell;
}


- (void) removeClassAtIndex: (NSUInteger) index {
    NSUInteger numOfClasses = [self.model numberOfClasses];
    if (index < numOfClasses) {
        [self.model removeClassAtIndex:index];
    }
}




@end
