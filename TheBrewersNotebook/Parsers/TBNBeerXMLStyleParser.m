//
//  TBNBeerXMLStyleParser.m
//  BrewdayHelper
//
//  Created by Andrew on 2/28/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import "TBNBeerXMLStyleParser.h"
#import "TBNAppDelegate.h"
#import "TBNStyle.h"

@interface TBNBeerXMLStyleParser()
@property (nonatomic, strong)TBNStyle* styleItem;
@end

@implementation TBNBeerXMLStyleParser

#pragma mark XMLParserDelegate Methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([[elementName uppercaseString] isEqualToString:@"STYLE"] || [[elementName uppercaseString] isEqualToString:@"NAME"] || [[elementName uppercaseString] isEqualToString:@"NOTES"] || [[elementName uppercaseString] isEqualToString:@"CATEGORY"] || [[elementName uppercaseString] isEqualToString:@"CATEGORY_NUMBER"] || [[elementName uppercaseString] isEqualToString:@"STYLE_LETTER"] || [[elementName uppercaseString] isEqualToString:@"STYLE_GUIDE"] || [[elementName uppercaseString] isEqualToString:@"TYPE"] || [[elementName uppercaseString] isEqualToString:@"OG_MIN"] || [[elementName uppercaseString] isEqualToString:@"OG_MAX"] || [[elementName uppercaseString] isEqualToString:@"FG_MIN"] || [[elementName uppercaseString] isEqualToString:@"FG_MAX"] || [[elementName uppercaseString] isEqualToString:@"IBU_MIN"] || [[elementName uppercaseString] isEqualToString:@"IBU_MAX"] || [[elementName uppercaseString] isEqualToString:@"COLOR_MIN"] || [[elementName uppercaseString] isEqualToString:@"CARB_MIN"] || [[elementName uppercaseString] isEqualToString:@"CARB_MAX"] || [[elementName uppercaseString] isEqualToString:@"ABV_MAX"] || [[elementName uppercaseString] isEqualToString:@"ABV_MIN"] || [[elementName uppercaseString] isEqualToString:@"PROFILE"] || [[elementName uppercaseString] isEqualToString:@"INGREDIENTS"] || [[elementName uppercaseString] isEqualToString:@"EXAMPLES"] || [[elementName uppercaseString] isEqualToString:@"COLOR_MAX"])
    {
        if (!styleItem)
        {
            styleItem = [NSEntityDescription insertNewObjectForEntityForName:@"TBNStyle"
                                                      inManagedObjectContext:self.appDelegate.managedObjectContext];
        }
        if (!self.currentStringValue)
            self.currentStringValue = [[NSMutableString alloc] initWithCapacity:100];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    if([[elementName uppercaseString] isEqualToString:@"STYLES"])
    {
        NSError* error;
        if (![self.appDelegate.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"STYLE"])
    {
        [self.createdItems addObject:styleItem];
        styleItem = nil;
        
        if (self.parentParser)
            [parser setDelegate:self.parentParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NAME"])
    {
        if (self.currentStringValue.length > 0)
        {
            TBNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TBNStyle" inManagedObjectContext:appDelegate.managedObjectContext];
            [request setEntity:entity];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", self.currentStringValue];
            
            request.predicate = predicate;
            
            NSError *error = nil;
            NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([results count] > 0)
            {
                [appDelegate.managedObjectContext deleteObject:styleItem];
                styleItem = [results objectAtIndex:0];
            }
            
            styleItem.name = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NOTES"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.notes = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CATEGORY"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.category = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CATEGORY_NUMBER"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.categoryNumber =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"STYLE_LETTER"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.styleLetter =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"STYLE_GUIDE"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.styleGuide =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TYPE"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.type = [[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"OG_MIN"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.originalGravityMin =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"OG_MAX"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.originalGravityMax =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"FG_MIN"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.finalGravityMin =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"FG_MAX"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.finalGravityMax =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"IBU_MIN"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.ibuMin =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"IBU_MAX"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.ibuMax =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"COLOR_MIN"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.colorMin =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"COLOR_MAX"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.colorMax =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CARB_MIN"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.carbMin =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CARB_MAX"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.carbMax =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ABV_MAX"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.abvMax =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"ABV_MIN"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.abvMin =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"PROFILE"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.profile =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"INGREDIENTS"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.ingredients =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"EXAMPLES"])
    {
        if (self.currentStringValue.length > 0)
        {
            styleItem.examples =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
}

#pragma mark Properties
@synthesize styleItem;
@end
