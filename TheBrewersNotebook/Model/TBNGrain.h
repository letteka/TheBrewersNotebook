//
//  TBNGrain.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/19/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBNRecipe;

@interface TBNGrain : NSManagedObject

@property (nonatomic, retain) NSNumber * addAfterBoil;
@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSDecimalNumber * coarseFineDiff;
@property (nonatomic, retain) NSDecimalNumber * color;
@property (nonatomic, retain) NSDecimalNumber * diastaticPower;
@property (nonatomic, retain) NSDecimalNumber * ibuGalPerLB;
@property (nonatomic, retain) NSDecimalNumber * inventory;
@property (nonatomic, retain) NSDecimalNumber * maxInBatch;
@property (nonatomic, retain) NSDecimalNumber * moisture;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * origin;
@property (nonatomic, retain) NSDecimalNumber * potential;
@property (nonatomic, retain) NSDecimalNumber * protein;
@property (nonatomic, retain) NSNumber * recommendMash;
@property (nonatomic, retain) NSString * supplier;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDecimalNumber * yield;
@property (nonatomic, retain) NSSet *recipes;
@end

@interface TBNGrain (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(TBNRecipe *)value;
- (void)removeRecipesObject:(TBNRecipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;

@end
