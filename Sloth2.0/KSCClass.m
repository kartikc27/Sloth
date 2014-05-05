//
//  KSCClass.m
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/3/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import "KSCClass.h"

@implementation KSCClass

@synthesize sectionName;
@synthesize startTime;
@synthesize endTime;
@synthesize xLocation;
@synthesize yLocation;
@synthesize daysOfClass;



static NSMutableArray* setOfSections;



-(id) init
{
    self = [super init];
    if(setOfSections == nil)
    {
        setOfSections = [[NSMutableArray alloc] init];
    }
    
    if(self)
    {
        //do something
    }
    [setOfSections addObject:self];
    return self;
}

-(id) initWithSectionName: (NSString *) name
             andStartTime: (NSDate *) start
                  andxLoc: (double) x
                  andyLoc: (double) y
               andEndTime: (NSDate *) end
                  andDays: (NSString * ) days
{
    self = [super init];
    
    self.sectionName = name;
    self.startTime = start;
    self.endTime = end;
    self.xLocation = x;
    self.yLocation = y;
    self.daysOfClass = days;
    
    if(setOfSections == nil)
    {
        setOfSections = [[NSMutableArray alloc] init];
    }
    
    [setOfSections addObject:self];
    
    [KSCClass getFormattedString];
    return self;
}

+(NSMutableArray*) getSections
{
    return setOfSections;
}

+(NSMutableString *) getFormattedString
{
    NSMutableString* formattedString = [[NSMutableString alloc]init];
    
        
    
    NSString *_formattedString = (NSString*)formattedString;
    
    /*PFObject *userInfo = [PFObject objectWithClassName:@"UserInfo"];
    userInfo[@"formattedString"] = _formattedString;
    [userInfo saveInBackground];*/
    
    return formattedString;
}





@end
