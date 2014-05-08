//  Created by Kartik Chillakanti (chillaka@usc.edu) on 5/3/14.
//  Copyright (c) 2014 KSC. All rights reserved.

#import <Parse/Parse.h>

@interface KSCUserDetailsViewController : UITableViewController <NSURLConnectionDelegate>

// UITableView header view properties
@property (nonatomic, strong) IBOutlet UIView *headerView;
@property (nonatomic, strong) IBOutlet UILabel *headerNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *headerImageView;

// UITableView row data properties
@property (nonatomic, strong) NSArray *rowTitleArray;
@property (nonatomic, strong) NSMutableArray *rowDataArray;
@property (nonatomic, strong) NSMutableData *imageData;


// UINavigationBar button touch handler
- (void)logoutButtonTouchHandler:(id)sender;
+ (NSString*) getName;


@end
