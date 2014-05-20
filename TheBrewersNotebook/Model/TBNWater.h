//
//  TBNWater.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/19/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBNRecipe;

@interface TBNWater : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSDecimalNumber * bicarbonate;
@property (nonatomic, retain) NSDecimalNumber * calcium;
@property (nonatomic, retain) NSDecimalNumber * chloride;
@property (nonatomic, retain) NSDecimalNumber * magnesium;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDecimalNumber * ph;
@property (nonatomic, retain) NSDecimalNumber * sodium;
@property (nonatomic, retain) NSDecimalNumber * sulfate;
@property (nonatomic, retain) NSSet *recipes;
@end

@interface TBNWater (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(TBNRecipe *)value;
- (void)removeRecipesObject:(TBNRecipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;

@end
