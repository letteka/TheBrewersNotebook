//
//  TBNBeerXMLWaterParser.m
//  BrewdayHelper
//
//  Created by Andrew on 2/28/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import "TBNBeerXMLWaterParser.h"
#import "TBNAppDelegate.h"
#import "TBNWater.h"

@interface TBNBeerXMLWaterParser()
@property (nonatomic, strong)TBNWater* waterItem;
@end

@implementation TBNBeerXMLWaterParser

#pragma mark XMLParserDelegate Methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([[elementName uppercaseString] isEqualToString:@"WATER"] || [[elementName uppercaseString] isEqualToString:@"NAME"] || [[elementName uppercaseString] isEqualToString:@"NOTES"] || [[elementName uppercaseString] isEqualToString:@"AMOUNT"] || [[elementName uppercaseString] isEqualToString:@"CALCIUM"] || [[elementName uppercaseString] isEqualToString:@"BICARBONATE"] || [[elementName uppercaseString] isEqualToString:@"SULFATE"] || [[elementName uppercaseString] isEqualToString:@"CHLORIDE"] || [[elementName uppercaseString] isEqualToString:@"SODIUM"] || [[elementName uppercaseString] isEqualToString:@"MAGNESIUM"] || [[elementName uppercaseString] isEqualToString:@"PH"])
    {
        if (!waterItem)
        {
            waterItem = [NSEntityDescription insertNewObjectForEntityForName:@"TBNWater"
                                                      inManagedObjectContext:self.appDelegate.managedObjectContext];
        }
        if (!self.currentStringValue)
            self.currentStringValue = [[NSMutableString alloc] initWithCapacity:100];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    if([[elementName uppercaseString] isEqualToString:@"WATERS"])
    {
        NSError* error;
        if (![self.appDelegate.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        if (self.parentParser)
            [parser setDelegate:self.parentParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"WATER"])
    {
        [self.createdItems addObject:waterItem];
        waterItem = nil;
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NAME"])
    {
        if (self.currentStringValue.length > 0)
        {
            TBNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TBNWater" inManagedObjectContext:appDelegate.managedObjectContext];
            [request setEntity:entity];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", self.currentStringValue];
            
            request.predicate = predicate;
            
            NSError *error = nil;
            NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([results count] > 0)
            {
                [appDelegate.managedObjectContext deleteObject:waterItem];
                waterItem = [results objectAtIndex:0];
            }
            
            waterItem.name = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NOTES"])
    {
        if (self.currentStringValue.length > 0)
        {
            waterItem.notes = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"AMOUNT"])
    {
        if (self.currentStringValue.length > 0)
        {
            waterItem.amount = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CALCIUM"])
    {
        if (self.currentStringValue.length > 0)
        {
            waterItem.calcium =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"BICARBONATE"])
    {
        if (self.currentStringValue.length > 0)
        {
            waterItem.bicarbonate =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"SULFATE"])
    {
        if (self.currentStringValue.length > 0)
        {
            waterItem.sulfate =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CHLORIDE"])
    {
        if (self.currentStringValue.length > 0)
        {
            waterItem.chloride = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"SODIUM"])
    {
        if (self.currentStringValue.length > 0)
        {
            waterItem.sodium =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MAGNESIUM"])
    {
        if (self.currentStringValue.length > 0)
        {
            waterItem.magnesium =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"PH"])
    {
        if (self.currentStringValue.length > 0)
        {
            waterItem.ph =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
}

#pragma mark Properties
@synthesize waterItem;
@end
