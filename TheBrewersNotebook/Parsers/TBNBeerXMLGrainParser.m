//
//  TBNBeerXMLGrainParser.m
//  BrewdayHelper
//
//  Created by Andrew on 2/27/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import "TBNBeerXMLGrainParser.h"
#import "TBNAppDelegate.h"
#import "TBNGrain.h"

@interface TBNBeerXMLGrainParser()
@property (nonatomic, strong)TBNGrain* grainItem;
@end

@implementation TBNBeerXMLGrainParser

#pragma mark XMLParserDelegate Methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([[elementName uppercaseString] isEqualToString:@"FERMENTABLE"] || [[elementName uppercaseString] isEqualToString:@"NAME"] || [[elementName uppercaseString] isEqualToString:@"NOTES"] || [[elementName uppercaseString] isEqualToString:@"TYPE"] || [[elementName uppercaseString] isEqualToString:@"AMOUNT"] || [[elementName uppercaseString] isEqualToString:@"YIELD"] || [[elementName uppercaseString] isEqualToString:@"COLOR"] || [[elementName uppercaseString] isEqualToString:@"ADD_AFTER_BOIL"] || [[elementName uppercaseString] isEqualToString:@"ORIGIN"] || [[elementName uppercaseString] isEqualToString:@"SUPPLIER"] || [[elementName uppercaseString] isEqualToString:@"COARSE_FINE_DIFF"] || [[elementName uppercaseString] isEqualToString:@"MOISTURE"] || [[elementName uppercaseString] isEqualToString:@"DIASTATIC_POWER"] || [[elementName uppercaseString] isEqualToString:@"PROTEIN"] || [[elementName uppercaseString] isEqualToString:@"MAX_IN_BATCH"] || [[elementName uppercaseString] isEqualToString:@"RECOMMEND_MASH"] || [[elementName uppercaseString] isEqualToString:@"IBU_GAL_PER_LB"])
    {
        if (!grainItem)
        {
            grainItem = [NSEntityDescription insertNewObjectForEntityForName:@"TBNGrain"
                                                  inManagedObjectContext:self.appDelegate.managedObjectContext];
        }
        
        if (!self.currentStringValue)
            self.currentStringValue = [[NSMutableString alloc] initWithCapacity:100];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    if([[elementName uppercaseString] isEqualToString:@"FERMENTABLES"])
    {
        NSError* error;
        if (![self.appDelegate.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        if (self.parentParser)
            [parser setDelegate:self.parentParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"FERMENTABLE"])
    {
        [self.createdItems addObject:grainItem];
        grainItem = nil;
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NAME"])
    {
        if (self.currentStringValue.length > 0)
        {
            TBNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TBNGrain" inManagedObjectContext:appDelegate.managedObjectContext];
            [request setEntity:entity];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", self.currentStringValue];
            
            request.predicate = predicate;
            
            NSError *error = nil;
            NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([results count] > 0)
            {
                [appDelegate.managedObjectContext deleteObject:grainItem];
                grainItem = [results objectAtIndex:0];
            }
            
            grainItem.name = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NOTES"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.notes = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TYPE"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.type = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"AMOUNT"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.amount =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"YIELD"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.yield =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"COLOR"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.color =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ADD_AFTER_BOIL"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.addAfterBoil =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ORIGIN"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.origin = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"SUPPLIER"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.supplier = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"COARSE_FINE_DIFF"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.coarseFineDiff =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MOISTURE"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.moisture =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"DIASTATIC_POWER"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.diastaticPower =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"PROTEIN"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.protein =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MAX_IN_BATCH"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.maxInBatch =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"RECOMMEND_MASH"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.recommendMash =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"IBU_GAL_PER_LB"])
    {
        if (self.currentStringValue.length > 0)
        {
            grainItem.ibuGalPerLB =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
}

#pragma mark Properties
@synthesize grainItem;

@end
