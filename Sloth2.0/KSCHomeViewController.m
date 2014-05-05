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
@property (strong, nonatomic) NSMutableArray* todaysClasses;
@property (strong,nonatomic) KSCClassesModel *model;

@end

@implementation KSCHomeViewController

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
    // Do any additional setup after loading the view.
    
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
            }
            else if ([dayOfWeek isEqualToString:@"3"] && [secondDay isEqualToString:@"1"]) {
                NSLog(@"Tuesday Class");
            }
            else if ([dayOfWeek isEqualToString:@"4"] && [thirdDay isEqualToString:@"1"]) {
                NSLog(@"Wednesday Class");
            }
            else if ([dayOfWeek isEqualToString:@"5"] && [fourthDay isEqualToString:@"1"]) {
                NSLog(@"Thursday Class");
            }
            else if ([dayOfWeek isEqualToString:@"6"] && [fifthDay isEqualToString:@"1"]) {
                NSLog(@"Friday Class");
            }

        }
    }
   
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
