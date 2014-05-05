//
//  KSCAddClassesTableViewController.m
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/2/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import "KSCAddClassesTableViewController.h"
#import "KSCClassesModel.h"

@interface KSCAddClassesTableViewController ()

@property (strong,nonatomic) KSCClassesModel *model;

@end

@implementation KSCAddClassesTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.model = [[KSCClassesModel alloc] init];
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
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    /*NSMutableString *labelString = [[NSMutableString alloc] init];
    [labelString appendString:[[[KSCClassesModel getSections] objectAtIndex:indexPath.row] sectionName]];
    [labelString appendString: @": "];
    [labelString appendString:[[[KSCClassesModel getSections] objectAtIndex:indexPath.row] startTime]];
    [labelString appendString: @" - "];
    [labelString appendString:[[[SectionModel getSections] objectAtIndex:indexPath.row] endTime]];
    cell.textLabel.text = labelString;*/
    //  cell.detailTextLabel.text = [[[SectionModel getSections] objectAtIndex:indexPath.row] startTime] ,"asdf", [[[SectionModel getSections] objectAtIndex:indexPath.row] startTime];
    
    
    // Configure the cell...
    
    return cell;
}

- (void) removeClassAtIndex: (NSUInteger) index {
    NSUInteger numOfClasses = [self.model numberOfClasses];
    if (index < numOfClasses) {
        [self.model removeClassAtIndex:index];
    }
}




@end
