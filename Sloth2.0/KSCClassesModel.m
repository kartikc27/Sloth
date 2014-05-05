//
//  KSCClassesModel.m
//  Sloth2.0
//
//  Created by Kartik Chillakanti on 5/3/14.
//  Copyright (c) 2014 KSC. All rights reserved.
//

#import "KSCClassesModel.h"

@interface KSCClassesModel ()

@property (strong, nonatomic) NSMutableArray *classes;

@end

@implementation KSCClassesModel

- (id) init {
    self = [super init];
    if(self) {
        _classes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSUInteger) numberOfClasses {
    return [self.classes count];
}

- (NSString *) answerAtIndex: (NSUInteger) index {
    return [self.classes objectAtIndex:index];
}

- (void) removeClassAtIndex: (NSUInteger) index {
    NSUInteger numOfClasses = [self numberOfClasses];
    if (index < numOfClasses) {
        [self.classes removeObjectAtIndex:index];
    }
}

- (void) insertClass: (KSCClass *) className atIndex: (NSUInteger) index{
    NSUInteger numOfClasses = [self numberOfClasses];
    if (index <= numOfClasses) {
        NSLog(@"TESTING INSERT CLASS");
        NSLog (@"%@", className.sectionName);
        NSLog (@"%@", className.daysOfClass);
        NSLog (@"%@", className.startTime);
        NSLog (@"%@", className.endTime);
        NSLog (@"%f", className.xLocation);
        NSLog (@"%f", className.yLocation);
        [self.classes insertObject:className atIndex:index];
        
        NSLog(@"count is %d and index is %d", _classes.count, index);
    }
}

- (KSCClass *) classAtIndex: (NSUInteger) index {
    return [self.classes objectAtIndex:index];
}

+ (instancetype) sharedModel {
    static KSCClassesModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}


@end
