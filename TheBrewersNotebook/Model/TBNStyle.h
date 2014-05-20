//
//  TBNStyle.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/19/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBNRecipe;

@interface TBNStyle : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * abvMax;
@property (nonatomic, retain) NSDecimalNumber * abvMin;
@property (nonatomic, retain) NSDecimalNumber * carbMax;
@property (nonatomic, retain) NSDecimalNumber * carbMin;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSNumber * categoryNumber;
@property (nonatomic, retain) NSDecimalNumber * colorMax;
@property (nonatomic, retain) NSDecimalNumber * colorMin;
@property (nonatomic, retain) NSString * examples;
@property (nonatomic, retain) NSDecimalNumber * finalGravityMax;
@property (nonatomic, retain) NSDecimalNumber * finalGravityMin;
@property (nonatomic, retain) NSDecimalNumber * ibuMax;
@property (nonatomic, retain) NSDecimalNumber * ibuMin;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDecimalNumber * originalGravityMax;
@property (nonatomic, retain) NSDecimalNumber * originalGravityMin;
@property (nonatomic, retain) NSString * profile;
@property (nonatomic, retain) NSString * styleGuide;
@property (nonatomic, retain) NSString * styleLetter;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *recipes;
@end

@interface TBNStyle (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(TBNRecipe *)value;
- (void)removeRecipesObject:(TBNRecipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;

@end
