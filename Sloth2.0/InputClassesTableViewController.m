//
//  InputClassesTableViewController.m
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/4/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import "InputClassesTableViewController.h"
#import "KSCMapViewController.h"
#import "KSCClass.h"
#import "KSCClassesModel.h"
#import "KSCAddClassesTableViewController.h"

@interface InputClassesTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *startTimeCell;
@property (weak, nonatomic) IBOutlet UIDatePicker *startPickerCell;
@property (weak, nonatomic) IBOutlet UIDatePicker *endPickerCell;

@property (weak, nonatomic) IBOutlet UIButton *monButton;
@property (weak, nonatomic) IBOutlet UIButton *tueButton;
@property (weak, nonatomic) IBOutlet UIButton *wedButton;
@property (weak, nonatomic) IBOutlet UIButton *thuButton;
@property (weak, nonatomic) IBOutlet UIButton *friButton;

@property (weak, nonatomic) IBOutlet UITextField *classNameTF;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *setLocationButton;

@property (strong,nonatomic) KSCClassesModel *model;

@end

BOOL editingStartTime = NO;
BOOL editingEndTime = NO;
BOOL monSelected = NO;
BOOL tueSelected = NO;
BOOL wedSelected = NO;
BOOL thuSelected = NO;
BOOL friSelected = NO;
double xLoc;
double yLoc;


@implementation InputClassesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.model = [KSCClassesModel sharedModel];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _endPickerCell.alpha = 0.0;
    
    NSDate *startTime = _startPickerCell.date;
    NSDateFormatter *startTimeFormat = [[NSDateFormatter alloc] init];
    [startTimeFormat setDateFormat:@"hh:mm a"];
    _startTimeLabel.textAlignment=NSTextAlignmentLeft;
    _startTimeLabel.text = [startTimeFormat stringFromDate:startTime];
    
    NSDate *endTime = _endPickerCell.date;
    NSDateFormatter *endTimeFormat = [[NSDateFormatter alloc] init];
    [endTimeFormat setDateFormat:@"hh:mm a"];
    _endTimeLabel.textAlignment=NSTextAlignmentLeft;
    _endTimeLabel.text = [endTimeFormat stringFromDate:endTime];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldExit:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)startTimePickerChanged:(id)sender {
    NSDate *startTime = _startPickerCell.date;
    NSDateFormatter *startTimeFormat = [[NSDateFormatter alloc] init];
    [startTimeFormat setDateFormat:@"hh:mm a"];
    _startTimeLabel.textAlignment=NSTextAlignmentLeft;
    _startTimeLabel.text = [startTimeFormat stringFromDate:startTime];
}

- (IBAction)endTimePickerChanged:(id)sender {
    NSDate *endTime = _endPickerCell.date;
    NSDateFormatter *endTimeFormat = [[NSDateFormatter alloc] init];
    [endTimeFormat setDateFormat:@"hh:mm a"];
    _endTimeLabel.textAlignment=NSTextAlignmentLeft;
    _endTimeLabel.text = [endTimeFormat stringFromDate:endTime];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
        return 1 ;
    else if (section == 1)
        return 5;
    else if (section == 2)
        return 1;
    else
        return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1 ) { // this is my picker cell
        if (editingStartTime) {
            return 200;
        } else {
            return 0;
        }
    }
    if (indexPath.section == 1 && indexPath.row == 3) {
        if (editingEndTime) {
            return 200;
        } else {
            return 0;
            NSLog (@"TESTING");
        }
    }
    else {
        return self.tableView.rowHeight;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) { // this is my date cell above the picker cell
        editingStartTime = !editingStartTime;
        [UIView animateWithDuration:.4 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        }];
    }
    else if (indexPath.section == 1 && indexPath.row == 2) { // this is my date cell above the picker cell
        editingEndTime = !editingEndTime;
        [UIView animateWithDuration:.4 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
            if (editingEndTime) {_endPickerCell.alpha = 1.0 ;}
            else {_endPickerCell.alpha = 0.0;}
        }];
                

    }

}


- (IBAction)dayButtonTouched:(id)sender {
    
    if (sender == _monButton) {
        if (monSelected) {
            monSelected = NO;
            self.monButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.478 blue:1 alpha:1] CGColor];
        }
        else {
            monSelected = YES;
            self.monButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.812 blue:0.471 alpha:1] CGColor];
        }
    }
    else if (sender == _tueButton) {
        if (tueSelected) {
            tueSelected = NO;
            self.tueButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.478 blue:1 alpha:1] CGColor];
        }
        else {
            tueSelected = YES;
            self.tueButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.812 blue:0.471 alpha:1] CGColor];
        }

    }
    else if (sender == _wedButton) {
        if (wedSelected) {
            wedSelected = NO;
            self.wedButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.478 blue:1 alpha:1] CGColor];
        }
        else {
            wedSelected = YES;
            self.wedButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.812 blue:0.471 alpha:1] CGColor];
        }

    }
    else if (sender == _thuButton) {
        if (thuSelected) {
            thuSelected = NO;
            self.thuButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.478 blue:1 alpha:1] CGColor];
        }
        else {
            thuSelected = YES;
            self.thuButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.812 blue:0.471 alpha:1] CGColor];
        }

    }
    else if (sender == _friButton) {
        if (friSelected) {
            friSelected = NO;
            self.friButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.478 blue:1 alpha:1] CGColor];
        }
        else {
            friSelected = YES;
            self.friButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.812 blue:0.471 alpha:1] CGColor];
        }
    }
    
    
    //self.saveButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.812 blue:0.471 alpha:1] CGColor];
}


- (IBAction)doneButtonTapped:(id)sender {
    
    NSString* className = self.classNameTF.text;
    NSDate *startTime = _startPickerCell.date;
    NSDate *endTime = _endPickerCell.date;
    NSString *days = @"";
    
    for (int i = 0; i < 6; i++) {
        if ((i == 0) && (monSelected)) {
            days = [NSString stringWithFormat:@"%@%@", days, @"1"];
        }
        else if ((i == 0) && (!monSelected)){
            days = [NSString stringWithFormat:@"%@%@", days, @"0"];
        }
        else if ((i == 2) && (tueSelected)) {
            days = [NSString stringWithFormat:@"%@%@", days, @"1"];
        }
        else if ((i == 2) && (!tueSelected)){
            days = [NSString stringWithFormat:@"%@%@", days, @"0"];
        }
        else if ((i == 3) && (wedSelected)) {
            days = [NSString stringWithFormat:@"%@%@", days, @"1"];
        }
        else if ((i == 3) && (!wedSelected)) {
            days = [NSString stringWithFormat:@"%@%@", days, @"0"];
        }
        else if ((i == 4) && (thuSelected)) {
            days = [NSString stringWithFormat:@"%@%@", days, @"1"];
        }
        else if ((i == 4) && (!thuSelected)){
            days = [NSString stringWithFormat:@"%@%@", days, @"0"];
        }
        else if ((i == 5) && (friSelected)) {
            days = [NSString stringWithFormat:@"%@%@", days, @"1"];
        }
        else if ((i == 5) && (!friSelected)) {
            days = [NSString stringWithFormat:@"%@%@", days, @"0"];
        }
    }
    
    if (monSelected) {
        monSelected = NO;
    }
    if (tueSelected) {
        tueSelected = NO;
    }
    if (wedSelected) {
        wedSelected = NO;
    }
    if (thuSelected) {
        thuSelected = NO;
    }
    if (friSelected) {
        friSelected = NO;
    }
    
    
    
    xLoc = [KSCMapViewController coordinateOfAnnotation].latitude;
    yLoc = [KSCMapViewController coordinateOfAnnotation].longitude;
    
    
    NSLog (@"%@", className);
    NSLog (@"%@", days);
    NSLog (@"%@", startTime);
    NSLog (@"%@", endTime);
    NSLog (@"%f", xLoc);
    NSLog (@"%f", yLoc);
    
    if ((className.length == 0) || ([startTime isEqual:endTime]) || (xLoc == 0) || (yLoc == 0) || ([days isEqual:@"00000"])) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:@"Please complete all the fields"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
    
        NSInteger classIndex = [self.model numberOfClasses];
        [self.model insertClass: [[KSCClass alloc] initWithSectionName:className andStartTime:startTime andxLoc:xLoc andyLoc:yLoc andEndTime:endTime andDays:days] atIndex:classIndex];
    
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *viewController = (UINavigationController *)[storyboard  instantiateViewControllerWithIdentifier:@"ClassesNavController"];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    
    //NSLog (@"%d", _model.numberOfClasses);
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *viewController = (UINavigationController *)[storyboard  instantiateViewControllerWithIdentifier:@"ClassesNavController"];
    [self presentViewController:viewController animated:YES completion:nil];
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
