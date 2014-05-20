//
//  TBNBeerXMLMiscParser.m
//  BrewdayHelper
//
//  Created by Andrew on 2/28/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import "TBNBeerXMLMiscParser.h"
#import "TBNAppDelegate.h"
#import "TBNMisc.h"

@interface TBNBeerXMLMiscParser()
@property (nonatomic, strong)TBNMisc* miscItem;
@end

@implementation TBNBeerXMLMiscParser

#pragma mark XMLParserDelegate Methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([[elementName uppercaseString] isEqualToString:@"MISC"] || [[elementName uppercaseString] isEqualToString:@"NAME"] || [[elementName uppercaseString] isEqualToString:@"NOTES"] || [[elementName uppercaseString] isEqualToString:@"TYPE"] || [[elementName uppercaseString] isEqualToString:@"USE"] || [[elementName uppercaseString] isEqualToString:@"AMOUNT"] || [[elementName uppercaseString] isEqualToString:@"TIME"] || [[elementName uppercaseString] isEqualToString:@"AMOUNT_IS_WEIGHT"] || [[elementName uppercaseString] isEqualToString:@"USE_FOR"])
    {
        if (!miscItem)
        {
            miscItem = [NSEntityDescription insertNewObjectForEntityForName:@"TBNMisc"
                                                     inManagedObjectContext:self.appDelegate.managedObjectContext];
        }
        
        if (!self.currentStringValue)
            self.currentStringValue = [[NSMutableString alloc] initWithCapacity:100];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    if([[elementName uppercaseString] isEqualToString:@"MISCS"])
    {
        NSError* error;
        if (![self.appDelegate.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        if (self.parentParser)
            [parser setDelegate:self.parentParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MISC"])
    {
        [self.createdItems addObject:miscItem];
        miscItem = nil;
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NAME"])
    {
        if (self.currentStringValue.length > 0)
        {
            TBNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TBNMisc" inManagedObjectContext:appDelegate.managedObjectContext];
            [request setEntity:entity];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", self.currentStringValue];
            
            request.predicate = predicate;
            
            NSError *error = nil;
            NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([results count] > 0)
            {
                [appDelegate.managedObjectContext deleteObject:miscItem];
                miscItem = [results objectAtIndex:0];
            }
            
            miscItem.name = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NOTES"])
    {
        if (self.currentStringValue.length > 0)
        {
            miscItem.notes = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TYPE"])
    {
        if (self.currentStringValue.length > 0)
        {
            miscItem.type = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"USE"])
    {
        if (self.currentStringValue.length > 0)
        {
            miscItem.use =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"AMOUNT"])
    {
        if (self.currentStringValue.length > 0)
        {
            miscItem.amount =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TIME"])
    {
        if (self.currentStringValue.length > 0)
        {
            miscItem.time =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"AMOUNT_IS_WEIGHT"])
    {
        if (self.currentStringValue.length > 0)
        {
            NSString* amountIsWeight = [[NSString alloc] initWithString:self.currentStringValue];
            miscItem.amountIsWeight = [[NSNumber alloc] initWithBool:[amountIsWeight isEqualToString:@"TRUE"]];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"USE_FOR"])
    {
        if (self.currentStringValue.length > 0)
        {
            miscItem.useFor = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
}

#pragma mark Properties
@synthesize miscItem;

@end
