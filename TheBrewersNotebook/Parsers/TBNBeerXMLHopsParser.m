//
//  TBNBeerXMLHopsParser.m
//  BrewdayHelper
//
//  Created by Andrew on 2/27/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import "TBNBeerXMLHopsParser.h"
#import "TBNAppDelegate.h"
#import "TBNHop.h"

@interface TBNBeerXMLHopsParser()
@property (nonatomic, strong)TBNHop* hopItem;
@end

@implementation TBNBeerXMLHopsParser

#pragma mark XMLParserDelegate Methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([[elementName uppercaseString] isEqualToString:@"HOPS"] || [[elementName uppercaseString] isEqualToString:@"NAME"] || [[elementName uppercaseString] isEqualToString:@"NOTES"] || [[elementName uppercaseString] isEqualToString:@"ORIGIN"] || [[elementName uppercaseString] isEqualToString:@"ALPHA"] || [[elementName uppercaseString] isEqualToString:@"AMOUNT"] || [[elementName uppercaseString] isEqualToString:@"USE"] || [[elementName uppercaseString] isEqualToString:@"TIME"] || [[elementName uppercaseString] isEqualToString:@"TYPE"] || [[elementName uppercaseString] isEqualToString:@"FORM"] || [[elementName uppercaseString] isEqualToString:@"BETA"] || [[elementName uppercaseString] isEqualToString:@"HSI"])
    {
        if (!hopItem)
        {
            hopItem = [NSEntityDescription insertNewObjectForEntityForName:@"TBNHop"
                                                inManagedObjectContext:self.appDelegate.managedObjectContext];
        }
        
        if (!self.currentStringValue)
            self.currentStringValue = [[NSMutableString alloc] initWithCapacity:100];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    if([[elementName uppercaseString] isEqualToString:@"HOPS"])
    {
        NSError* error;
        if (![self.appDelegate.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        if (self.parentParser)
            [parser setDelegate:self.parentParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"HOP"])
    {
        if (hopItem)
        {
            [self.createdItems addObject:hopItem];
            hopItem = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NAME"])
    {
        if (self.currentStringValue.length > 0)
        {
            TBNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TBNHop" inManagedObjectContext:appDelegate.managedObjectContext];
            [request setEntity:entity];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", self.currentStringValue];
            
            request.predicate = predicate;
            
            NSError *error = nil;
            NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([results count] > 0)
            {
                [appDelegate.managedObjectContext deleteObject:hopItem];
                hopItem = [results objectAtIndex:0];
            }
            
            hopItem.name = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NOTES"])
    {
        if (self.currentStringValue.length > 0)
        {
            hopItem.notes = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ORIGIN"])
    {
        if (self.currentStringValue.length > 0)
        {
            hopItem.origin = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ALPHA"])
    {
        if (self.currentStringValue.length > 0)
        {
            hopItem.alpha =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"AMOUNT"])
    {
        if (self.currentStringValue.length > 0)
        {
            hopItem.amount =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"USE"])
    {
        if (self.currentStringValue.length > 0)
        {
            hopItem.use =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TIME"])
    {
        if (self.currentStringValue.length > 0)
        {
            hopItem.time = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TYPE"])
    {
        if (self.currentStringValue.length > 0)
        {
            hopItem.type =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"FORM"])
    {
        if (self.currentStringValue.length > 0)
        {
            hopItem.form =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"BETA"])
    {
        if (self.currentStringValue.length > 0)
        {
            hopItem.beta =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"HSI"])
    {
        if (self.currentStringValue.length > 0)
        {
            hopItem.hsi =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
}

@synthesize hopItem;


@end
