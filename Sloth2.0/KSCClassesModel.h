//  Created by Kartik Chillakanti (chillaka@usc.edu) on 5/3/14. 
//  Copyright (c) 2014 KSC. All rights reserved.

#import <Foundation/Foundation.h>
#import "KSCClass.h"


@interface KSCClassesModel : NSObject

- (NSUInteger) numberOfClasses;
- (KSCClass *) classAtIndex: (NSUInteger) index;
- (void) removeClassAtIndex: (NSUInteger) index;
- (void) insertClass: (KSCClass *) className atIndex: (NSUInteger) index;
- (void) removeAllClasses;
+ (instancetype) sharedModel;


@end

