//
//  TBNBeerXMLRecipeParser.m
//  BrewdayHelper
//
//  Created by Andrew on 2/28/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import "TBNBeerXMLRecipeParser.h"
#import "TBNBeerXMLEquipmentParser.h"
#import "TBNBeerXMLGrainParser.h"
#import "TBNBeerXMLHopsParser.h"
#import "TBNBeerXMLMashParser.h"
#import "TBNBeerXMLMiscParser.h"
#import "TBNBeerXMLStyleParser.h"
#import "TBNBeerXMLWaterParser.h"
#import "TBNBeerXMLYeastParser.h"

#import "TBNAppDelegate.h"

#import "TBNRecipe.h"
#import "TBNEquipment.h"
#import "TBNGrain.h"
#import "TBNHop.h"
#import "TBNMash.h"
#import "TBNMashSteps.h"
#import "TBNMisc.h"
#import "TBNStyle.h"
#import "TBNWater.h"
#import "TBNYeast.h"

@interface TBNBeerXMLRecipeParser()
@property (nonatomic, strong)TBNRecipe* recipeItem;
@property (nonatomic, strong)TBNBeerXMLEquipmentParser* equipmentParser;
@property (nonatomic, strong)TBNBeerXMLGrainParser* grainParser;
@property (nonatomic, strong)TBNBeerXMLHopsParser* hopsParser;
@property (nonatomic, strong)TBNBeerXMLMashParser* mashParser;
@property (nonatomic, strong)TBNBeerXMLMiscParser* miscParser;
@property (nonatomic, strong)TBNBeerXMLStyleParser* styleParser;
@property (nonatomic, strong)TBNBeerXMLWaterParser* waterParser;
@property (nonatomic, strong)TBNBeerXMLYeastParser* yeastParser;
@end

@implementation TBNBeerXMLRecipeParser
- (BOOL)Parse:(NSString*)fileName
{
    equipmentParser = [[TBNBeerXMLEquipmentParser alloc] init];
    grainParser = [[TBNBeerXMLGrainParser alloc] init];
    hopsParser = [[TBNBeerXMLHopsParser alloc] init];
    mashParser = [[TBNBeerXMLMashParser alloc] init];
    miscParser = [[TBNBeerXMLMiscParser alloc] init];
    styleParser = [[TBNBeerXMLStyleParser alloc] init];
    waterParser = [[TBNBeerXMLWaterParser alloc] init];
    yeastParser = [[TBNBeerXMLYeastParser alloc] init];
    
    return [super Parse:fileName];
}

#pragma mark XMLParserDelegate Methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([[elementName uppercaseString] isEqualToString:@"RECIPE"] || [[elementName uppercaseString] isEqualToString:@"NAME"] || [[elementName uppercaseString] isEqualToString:@"NOTES"] || [[elementName uppercaseString] isEqualToString:@"TYPE"] || [[elementName uppercaseString] isEqualToString:@"BREWER"] || [[elementName uppercaseString] isEqualToString:@"ASST_BREWER"] || [[elementName uppercaseString] isEqualToString:@"BATCH_SIZE"] || [[elementName uppercaseString] isEqualToString:@"BOIL_SIZE"] || [[elementName uppercaseString] isEqualToString:@"BOIL_TIME"] || [[elementName uppercaseString] isEqualToString:@"EFFICIENCY"] || [[elementName uppercaseString] isEqualToString:@"TASTE_NOTES"] || [[elementName uppercaseString] isEqualToString:@"TASTE_RATING"] || [[elementName uppercaseString] isEqualToString:@"OG"] || [[elementName uppercaseString] isEqualToString:@"FG"] || [[elementName uppercaseString] isEqualToString:@"CARBONATION"] || [[elementName uppercaseString] isEqualToString:@"FERMENTATION_STAGES"]|| [[elementName uppercaseString] isEqualToString:@"PRIMARY_AGE"]|| [[elementName uppercaseString] isEqualToString:@"PRIMARY_TEMP"]|| [[elementName uppercaseString] isEqualToString:@"SECONDARY_AGE"] || [[elementName uppercaseString] isEqualToString:@"SECONDARY_TEMP"] || [[elementName uppercaseString] isEqualToString:@"TERTIARY_AGE"] || [[elementName uppercaseString] isEqualToString:@"AGE"] || [[elementName uppercaseString] isEqualToString:@"AGE_TEMP"] || [[elementName uppercaseString] isEqualToString:@"CARBONATION_USED"] || [[elementName uppercaseString] isEqualToString:@"DATE"] || [[elementName uppercaseString] isEqualToString:@"EST_OG"]|| [[elementName uppercaseString] isEqualToString:@"EST_FG"]|| [[elementName uppercaseString] isEqualToString:@"EST_COLOR"]|| [[elementName uppercaseString] isEqualToString:@"IBU"] || [[elementName uppercaseString] isEqualToString:@"IBU_METHOD"] || [[elementName uppercaseString] isEqualToString:@"EST_ABV"] || [[elementName uppercaseString] isEqualToString:@"ABV"] || [[elementName uppercaseString] isEqualToString:@"ACTUAL_EFFICIENCY"] || [[elementName uppercaseString] isEqualToString:@"CALORIES"])
    {
        if (!recipeItem)
            recipeItem = [NSEntityDescription insertNewObjectForEntityForName:@"TBNRecipe"
                                                       inManagedObjectContext:self.appDelegate.managedObjectContext];
        
        if (!self.currentStringValue)
            self.currentStringValue = [[NSMutableString alloc] initWithCapacity:100];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"HOPS"])
    {
        [hopsParser setParentParser:self];
        [parser setDelegate:hopsParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"FERMENTABLES"])
    {
        [grainParser setParentParser:self];
        [parser setDelegate:grainParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"EQUIPMENT"])
    {
        [equipmentParser setParentParser:self];
        [parser setDelegate:equipmentParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MASH"])
    {
        [mashParser setParentParser:self];
        [parser setDelegate:mashParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MISCS"])
    {
        [miscParser setParentParser:self];
        [parser setDelegate:miscParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"STYLE"])
    {
        [styleParser setParentParser:self];
        [parser setDelegate:styleParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"WATERS"])
    {
        [waterParser setParentParser:self];
        [parser setDelegate:waterParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"YEASTS"])
    {
        [yeastParser setParentParser:self];
        [parser setDelegate:yeastParser];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    
    if([[elementName uppercaseString] isEqualToString:@"RECIPES"])
    {
        NSError* error;
        if (![self.appDelegate.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"RECIPE"])
    {
        recipeItem.equipment = [equipmentParser.createdItems anyObject];
        [recipeItem addGrains:grainParser.createdItems];
        [recipeItem addHops:hopsParser.createdItems];
        recipeItem.mash = [mashParser.createdItems anyObject];
        [recipeItem addMisc:miscParser.createdItems];
        recipeItem.style = [styleParser.createdItems anyObject];
        [recipeItem addWaters:waterParser.createdItems];
        [recipeItem addYeasts:yeastParser.createdItems];
        
        [equipmentParser.createdItems removeAllObjects];
        [grainParser.createdItems removeAllObjects];
        [hopsParser.createdItems removeAllObjects];
        [mashParser.createdItems removeAllObjects];
        [miscParser.createdItems removeAllObjects];
        [styleParser.createdItems removeAllObjects];
        [waterParser.createdItems removeAllObjects];
        [yeastParser.createdItems removeAllObjects];
        
        recipeItem = nil;
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NAME"])
    {
        if (self.currentStringValue.length > 0)
        {
            TBNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TBNRecipe" inManagedObjectContext:appDelegate.managedObjectContext];
            [request setEntity:entity];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", self.currentStringValue];
            
            request.predicate = predicate;
            
            NSError *error = nil;
            NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([results count] > 0)
            {
                [appDelegate.managedObjectContext deleteObject:recipeItem];
                recipeItem = [results objectAtIndex:0];
            }
            
            recipeItem.name = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NOTES"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.notes = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TYPE"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.type = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"BREWER"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.brewer = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ASST_BREWER"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.asstBrewer =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"BATCH_SIZE"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.batchSize =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"BOIL_SIZE"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.boilSize =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"BOIL_TIME"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.boilTime = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"EFFICIENCY"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.efficiency = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TASTE_NOTES"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.tasteNotes =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TASTE_RATING"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.tasteRating =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"OG"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.originalGravity =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"FG"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.finalGravity =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CARBONATION"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.carbonation =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"FERMENTATION_STAGES"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.fermentationStages =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"PRIMARY_AGE"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.primaryAge =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"PRIMARY_TEMP"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.primaryTemp =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"SECONDARY_AGE"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.secondaryAge =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"SECONDARY_TEMP"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.secondaryTemp =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TERTIARY_AGE"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.tertiaryAge =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"AGE"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.age =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"AGE_TEMP"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.ageTemp = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CARBONATION_USED"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.carbonationUsed = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"DATE"])
    {
        if (self.currentStringValue.length > 0)
        {
            NSDate __block *date = [[NSDate alloc] init];
            
            NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingAllTypes error:nil];
            [detector enumerateMatchesInString:self.currentStringValue
                options:kNilOptions
                range:NSMakeRange(0, [self.currentStringValue length])
                usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
            {
                date = result.date;
            }];
            
            recipeItem.date = date;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"EST_OG"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.estOriginalGravity =[[NSDecimalNumber alloc] initWithString:[[self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@"SG" withString:@""]];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"EST_FG"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.estFinalGravity = [[NSDecimalNumber alloc] initWithString:[[self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@"SG" withString:@""]];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"EST_COLOR"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.estColor = [[NSDecimalNumber alloc] initWithString:[[self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@"SRM" withString:@""]];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"IBU"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.ibu = [[NSDecimalNumber alloc] initWithString:[[self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@"IBU" withString:@""]];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"IBU_METHOD"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.ibuMethod =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"EST_ABV"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.estAbv =[[NSDecimalNumber alloc] initWithString:[[self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@"%" withString:@""]];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ABV"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.abv =[[NSDecimalNumber alloc] initWithString:[[self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByReplacingOccurrencesOfString:@"%" withString:@""]];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ACTUAL_EFFICIENCY"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.actualEfficiency =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CALORIES"])
    {
        if (self.currentStringValue.length > 0)
        {
            recipeItem.calories =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
}

#pragma mark Properties
@synthesize recipeItem;
@synthesize equipmentParser;
@synthesize grainParser;
@synthesize hopsParser;
@synthesize mashParser;
@synthesize miscParser;
@synthesize styleParser;
@synthesize waterParser;
@synthesize yeastParser;

@end
