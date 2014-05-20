//
//  TBNMashSteps.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/19/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBNMash;

@interface TBNMashSteps : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * decoctionAmount;
@property (nonatomic, retain) NSDecimalNumber * endTime;
@property (nonatomic, retain) NSDecimalNumber * infuseAmount;
@property (nonatomic, retain) NSDecimalNumber * infuseTemp;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * rampTime;
@property (nonatomic, retain) NSString * stepDescription;
@property (nonatomic, retain) NSDecimalNumber * stepTemp;
@property (nonatomic, retain) NSDecimalNumber * stepTime;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDecimalNumber * waterGrainRatio;
@property (nonatomic, retain) TBNMash *mash;

@end
