//
//  TBNBeerXMLYeastParser.m
//  BrewdayHelper
//
//  Created by Andrew on 2/28/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import "TBNBeerXMLYeastParser.h"
#import "TBNAppDelegate.h"
#import "TBNYeast.h"

@interface TBNBeerXMLYeastParser()
@property (nonatomic, strong)TBNYeast* yeastItem;
@end

@implementation TBNBeerXMLYeastParser

#pragma mark XMLParserDelegate Methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([[elementName uppercaseString] isEqualToString:@"YEAST"] || [[elementName uppercaseString] isEqualToString:@"NAME"] || [[elementName uppercaseString] isEqualToString:@"NOTES"] || [[elementName uppercaseString] isEqualToString:@"TYPE"] || [[elementName uppercaseString] isEqualToString:@"FORM"] || [[elementName uppercaseString] isEqualToString:@"AMOUNT"] || [[elementName uppercaseString] isEqualToString:@"AMOUNT_IS_WEIGHT"] || [[elementName uppercaseString] isEqualToString:@"LABORATORY"] || [[elementName uppercaseString] isEqualToString:@"PRODUCT_ID"] || [[elementName uppercaseString] isEqualToString:@"MIN_TEMPERATURE"] || [[elementName uppercaseString] isEqualToString:@"MAX_TEMPERATURE"] || [[elementName uppercaseString] isEqualToString:@"FLOCCULATION"] || [[elementName uppercaseString] isEqualToString:@"ATTENUATION"] || [[elementName uppercaseString] isEqualToString:@"BEST_FOR"] || [[elementName uppercaseString] isEqualToString:@"MAX_REUSE"] || [[elementName uppercaseString] isEqualToString:@"TIMES_CULTURED"] || [[elementName uppercaseString] isEqualToString:@"ADD_TO_SECONDARY"]|| [[elementName uppercaseString] isEqualToString:@"CULTURE_DATE"])
    {
        if (!yeastItem)
        {
            yeastItem = [NSEntityDescription insertNewObjectForEntityForName:@"TBNYeast"
                                                      inManagedObjectContext:self.appDelegate.managedObjectContext];
        }
        if (!self.currentStringValue)
            self.currentStringValue = [[NSMutableString alloc] initWithCapacity:100];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    if([[elementName uppercaseString] isEqualToString:@"YEASTS"])
    {
        NSError* error;
        if (![self.appDelegate.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        if (self.parentParser)
            [parser setDelegate:self.parentParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"YEAST"])
    {
        [self.createdItems addObject:yeastItem];
        yeastItem = nil;
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NAME"])
    {
        if (self.currentStringValue.length > 0)
        {
            TBNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TBNYeast" inManagedObjectContext:appDelegate.managedObjectContext];
            [request setEntity:entity];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", self.currentStringValue];
            
            request.predicate = predicate;
            
            NSError *error = nil;
            NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([results count] > 0)
            {
                [appDelegate.managedObjectContext deleteObject:yeastItem];
                yeastItem = [results objectAtIndex:0];
            }
            
            yeastItem.name = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NOTES"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.notes = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"AMOUNT"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.amount = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TYPE"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.type =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"FORM"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.form =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"AMOUNT_IS_WEIGHT"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.amountIsWeight =[[NSDecimalNumber alloc] initWithBool:[self.currentStringValue isEqualToString:@"TRUE"]];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"LABORATORY"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.laboratory = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"PRODUCT_ID"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.productId =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MIN_TEMPERATURE"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.minTemp =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MAX_TEMPERATURE"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.maxTemp =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"FLOCCULATION"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.flocculation =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ATTENUATION"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.attenuation =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"BEST_FOR"])
    {
        if (self.currentStringValue.length > 0)	
        {
            yeastItem.bestFor =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MAX_REUSE"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.maxReuse = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TIMES_CULTURED"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.timesCultured =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ADD_TO_SECONDARY"])
    {
        if (self.currentStringValue.length > 0)
        {
            yeastItem.addToSecondary =[[NSDecimalNumber alloc] initWithBool:[self.currentStringValue isEqualToString:@"TRUE"]];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CULTURE_DATE"])
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
            
            yeastItem.cultureDate = date;
            self.currentStringValue = nil;
        }
    }
}

#pragma mark Properties
@synthesize yeastItem;
@end
