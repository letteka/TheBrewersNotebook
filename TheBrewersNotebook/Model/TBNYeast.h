//
//  TBNYeast.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/19/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBNRecipe;

@interface TBNYeast : NSManagedObject

@property (nonatomic, retain) NSNumber * addToSecondary;
@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSNumber * amountIsWeight;
@property (nonatomic, retain) NSDecimalNumber * attenuation;
@property (nonatomic, retain) NSString * bestFor;
@property (nonatomic, retain) NSDate * cultureDate;
@property (nonatomic, retain) NSString * flocculation;
@property (nonatomic, retain) NSString * form;
@property (nonatomic, retain) NSString * laboratory;
@property (nonatomic, retain) NSNumber * maxReuse;
@property (nonatomic, retain) NSDecimalNumber * maxTemp;
@property (nonatomic, retain) NSDecimalNumber * minTemp;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * productId;
@property (nonatomic, retain) NSNumber * timesCultured;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *recipes;
@end

@interface TBNYeast (CoreDataGeneratedAccessors)

- (void)addRecipesObject:(TBNRecipe *)value;
- (void)removeRecipesObject:(TBNRecipe *)value;
- (void)addRecipes:(NSSet *)values;
- (void)removeRecipes:(NSSet *)values;

@end
