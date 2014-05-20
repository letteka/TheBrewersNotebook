//
//  TBNMisc.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/19/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBNRecipe;

@interface TBNMisc : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSNumber * amountIsWeight;
@property (nonatomic, retain) NSDecimalNumber * inventory;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDecimalNumber * time;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * use;
@property (nonatomic, retain) NSString * useFor;
@property (nonatomic, retain) NSSet *recipes;
@end

@interface TBNMisc (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(TBNRecipe *)value;
- (void)removeRecipesObject:(TBNRecipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;

@end
