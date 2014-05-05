//
//  KSCClass.h
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/3/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSCClass : NSObject


@property (nonatomic) double xLocation;
@property (nonatomic) double yLocation;
@property (nonatomic,retain) NSString *sectionName;
@property (nonatomic,retain) NSDate *startTime;
@property (nonatomic,retain) NSDate *endTime;
@property (nonatomic) NSString* daysOfClass;

-(id) initWithSectionName: (NSString *) name
             andStartTime: (NSDate *) start
                  andxLoc: (double) x
                  andyLoc: (double) y
               andEndTime: (NSDate *) end
                  andDays: (NSString * ) days;
+(NSMutableArray *) getSections;
+(NSString *) getFormattedString;

@end
