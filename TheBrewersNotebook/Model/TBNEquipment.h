//
//  TBNEquipment.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/19/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBNRecipe;

@interface TBNEquipment : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * batchSize;
@property (nonatomic, retain) NSDecimalNumber * boilSize;
@property (nonatomic, retain) NSDecimalNumber * boilTime;
@property (nonatomic, retain) NSDecimalNumber * calcBoilVolume;
@property (nonatomic, retain) NSDecimalNumber * evapRate;
@property (nonatomic, retain) NSDecimalNumber * hopUtilization;
@property (nonatomic, retain) NSDecimalNumber * lauterDeadspace;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDecimalNumber * topUpKettle;
@property (nonatomic, retain) NSDecimalNumber * topUpWater;
@property (nonatomic, retain) NSDecimalNumber * trubChillerLoss;
@property (nonatomic, retain) NSDecimalNumber * tunSpecificHeat;
@property (nonatomic, retain) NSDecimalNumber * tunVolume;
@property (nonatomic, retain) NSDecimalNumber * tunWeight;
@property (nonatomic, retain) NSSet *recipes;
@end

@interface TBNEquipment (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(TBNRecipe *)value;
- (void)removeRecipesObject:(TBNRecipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;

@end
