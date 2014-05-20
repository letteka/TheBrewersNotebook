//
//  TBNMash.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/19/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBNMashSteps, TBNRecipe;

@interface TBNMash : NSManagedObject

@property (nonatomic, retain) NSNumber * equipAdjust;
@property (nonatomic, retain) NSDecimalNumber * grainTemp;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDecimalNumber * ph;
@property (nonatomic, retain) NSDecimalNumber * spargeTemp;
@property (nonatomic, retain) NSDecimalNumber * tunSpecificHeat;
@property (nonatomic, retain) NSDecimalNumber * tunTemp;
@property (nonatomic, retain) NSDecimalNumber * tunWeight;
@property (nonatomic, retain) NSSet *recipes;
@property (nonatomic, retain) NSSet *steps;
@end

@interface TBNMash (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(TBNRecipe *)value;
- (void)removeRecipesObject:(TBNRecipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;

- (void)addStepsObject:(TBNMashSteps *)value;
- (void)removeStepsObject:(TBNMashSteps *)value;
- (void)addSteps:(NSSet *)values;
- (void)removeSteps:(NSSet *)values;

@end
