//  Created by Kartik Chillakanti (chillaka@usc.edu) on 5/3/14.
//  Copyright (c) 2014 KSC. All rights reserved.

#import "KSCStatisticsViewController.h"
#import "KSCHomeViewController.h"

@interface KSCStatisticsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *absencesLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyWastedLabel;

@end

NSInteger absences;

@implementation KSCStatisticsViewController

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
    NSString *num = [[NSString alloc] initWithFormat:@"%d", absences];
    self.absencesLabel.text = num;
    
    NSInteger money;
    money = absences*2000;
    NSString *num2 = [[NSString alloc] initWithFormat:@"%d", money];
    self.moneyWastedLabel.text = num2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setAbsences:(NSInteger)abs {
    NSLog(@"TESTING");
    absences = abs;

}

- (IBAction)backButtonTouched:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KSCHomeViewController *viewController = (KSCHomeViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self presentViewController:viewController animated:YES completion:nil];
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
