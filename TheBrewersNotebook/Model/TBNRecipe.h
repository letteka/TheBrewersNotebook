//
//  TBNRecipe.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/19/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TBNEquipment, TBNGrain, TBNHop, TBNMash, TBNMisc, TBNStyle, TBNWater, TBNYeast;

@interface TBNRecipe : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * abv;
@property (nonatomic, retain) NSDecimalNumber * actualEfficiency;
@property (nonatomic, retain) NSDecimalNumber * age;
@property (nonatomic, retain) NSDecimalNumber * ageTemp;
@property (nonatomic, retain) NSString * asstBrewer;
@property (nonatomic, retain) NSDecimalNumber * batchSize;
@property (nonatomic, retain) NSDecimalNumber * boilSize;
@property (nonatomic, retain) NSDecimalNumber * boilTime;
@property (nonatomic, retain) NSString * brewer;
@property (nonatomic, retain) NSDecimalNumber * calories;
@property (nonatomic, retain) NSDecimalNumber * carbonation;
@property (nonatomic, retain) NSString * carbonationUsed;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDecimalNumber * efficiency;
@property (nonatomic, retain) NSDecimalNumber * estAbv;
@property (nonatomic, retain) NSDecimalNumber * estColor;
@property (nonatomic, retain) NSDecimalNumber * estFinalGravity;
@property (nonatomic, retain) NSDecimalNumber * estOriginalGravity;
@property (nonatomic, retain) NSNumber * fermentationStages;
@property (nonatomic, retain) NSDecimalNumber * finalGravity;
@property (nonatomic, retain) NSDecimalNumber * ibu;
@property (nonatomic, retain) NSString * ibuMethod;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDecimalNumber * originalGravity;
@property (nonatomic, retain) NSDecimalNumber * primaryAge;
@property (nonatomic, retain) NSDecimalNumber * primaryTemp;
@property (nonatomic, retain) NSDecimalNumber * secondaryAge;
@property (nonatomic, retain) NSDecimalNumber * secondaryTemp;
@property (nonatomic, retain) NSString * tasteNotes;
@property (nonatomic, retain) NSDecimalNumber * tasteRating;
@property (nonatomic, retain) NSDecimalNumber * tertiaryAge;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) TBNEquipment *equipment;
@property (nonatomic, retain) NSSet *grains;
@property (nonatomic, retain) NSSet *hops;
@property (nonatomic, retain) TBNMash *mash;
@property (nonatomic, retain) NSSet *misc;
@property (nonatomic, retain) TBNStyle *style;
@property (nonatomic, retain) NSSet *waters;
@property (nonatomic, retain) NSSet *yeasts;
@end

@interface TBNRecipe (CoreDataGeneratedAccessors)

- (void)addGrainsObject:(TBNGrain *)value;
- (void)removeGrainsObject:(TBNGrain *)value;
- (void)addGrains:(NSSet *)values;
- (void)removeGrains:(NSSet *)values;

- (void)addHopsObject:(TBNHop *)value;
- (void)removeHopsObject:(TBNHop *)value;
- (void)addHops:(NSSet *)values;
- (void)removeHops:(NSSet *)values;

- (void)addMiscObject:(TBNMisc *)value;
- (void)removeMiscObject:(TBNMisc *)value;
- (void)addMisc:(NSSet *)values;
- (void)removeMisc:(NSSet *)values;

- (void)addWatersObject:(TBNWater *)value;
- (void)removeWatersObject:(TBNWater *)value;
- (void)addWaters:(NSSet *)values;
- (void)removeWaters:(NSSet *)values;

- (void)addYeastsObject:(TBNYeast *)value;
- (void)removeYeastsObject:(TBNYeast *)value;
- (void)addYeasts:(NSSet *)values;
- (void)removeYeasts:(NSSet *)values;

@end
