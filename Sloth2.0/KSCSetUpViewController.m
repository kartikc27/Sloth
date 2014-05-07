//
//  KSCSetUpViewController.m
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/1/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import "KSCSetUpViewController.h"
#import <Parse/Parse.h>


@interface KSCSetUpViewController () 

@property (weak, nonatomic) IBOutlet UIStepper *absencesStepper;
@property (weak, nonatomic) IBOutlet UILabel *absencesLabel;

@property (weak, nonatomic) IBOutlet UIView *textMessageView;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;

@property (weak, nonatomic) IBOutlet UITextField *messageTF;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *punishmentSegControl;

@end

@implementation KSCSetUpViewController

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
    self.saveButton.enabled = NO;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)punishmentsControl:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSInteger segment = segmentedControl.selectedSegmentIndex;
    if (segment == 0)
        [self.textMessageView setHidden:NO];
    else
        [self.textMessageView setHidden:YES];
}


- (IBAction)stepperChanged:(id)sender {
    UIStepper *absencesStepper = (UIStepper *) sender;
    int stepperNum = (int)absencesStepper.value;
    NSString *num = [[NSString alloc] initWithFormat:@"%d", stepperNum];
    self.absencesLabel.text = num;

}



- (IBAction)textFieldExit:(id)sender {
    [sender resignFirstResponder];
    
    if ((self.phoneNumberTF.text.length > 0) && (self.messageTF.text.length > 0)) {
        self.saveButton.enabled=YES;
        self.saveButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.812 blue:0.471 alpha:1] CGColor];
    }
    else {
        self.saveButton.enabled=NO;
    }
}


- (IBAction)textFieldDidBeginEditing:(UITextField *)sender {
    [self animateTextField: sender up: YES];
    
}


- (IBAction)textFieldDidEndEditing:(UITextField *)sender {
    [self animateTextField: sender up: NO];
   }

- (void) animateTextField: (UITextField*) textField up: (BOOL) up {
    
    const int movementDistance = 160;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
    
    
}


- (IBAction)backgroundTouched:(id)sender {
    [self.messageTF resignFirstResponder];
    [self.phoneNumberTF resignFirstResponder];
    
    if ((self.phoneNumberTF.text.length > 0) && (self.messageTF.text.length > 0)) {
        self.saveButton.enabled=YES;
        self.saveButton.layer.backgroundColor = [[UIColor colorWithRed:0 green:0.812 blue:0.471 alpha:1] CGColor];
    }
    else {
        self.saveButton.enabled=NO;
    }

}


- (IBAction)saveButtonTouched:(id)sender {
    NSString* punishment;
    NSInteger numberOfAbsences;
    NSString* textMessage;
    NSString* phoneNumber;
    
    numberOfAbsences = (int)_absencesStepper.value;
    

    numberOfAbsences = _absencesStepper.value;
    textMessage = _messageTF.text;
    phoneNumber =  _messageTF.text;
    if (_punishmentSegControl.selectedSegmentIndex == 0) {
        punishment = @"textmessage";
        
    }
    
    [[PFUser currentUser] setObject:punishment forKey:@"punishment"];
    [[PFUser currentUser] setObject:[NSNumber numberWithInteger:numberOfAbsences] forKey:@"allowedAbsences"];
    [[PFUser currentUser] setObject:textMessage forKey:@"textMessage"];
    [[PFUser currentUser] setObject:phoneNumber forKey:@"phoneNumber"];
    [[PFUser currentUser] saveInBackground];
    [[PFUser currentUser] fetchIfNeeded];
    /*NSString *nameString = [[PFUser currentUser] objectForKey:@"name"];
    NSLog(@"%@", nameString);*/
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
