//
//  TBNBeerXMLParser.m
//  BrewdayHelper
//
//  Created by Andrew on 2/26/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import "TBNBeerXMLParser.h"
#import "TBNAppDelegate.h"

@implementation TBNBeerXMLParser

-(id)init
{
    self.appDelegate = [UIApplication sharedApplication].delegate;
    self.createdItems = [[NSMutableSet alloc] init];
    return [super init];
}

- (BOOL)Parse:(NSString*)fileName
{
    BOOL success = NO;
    
    if (fileName)
    {
        NSURL *xmlURL = [NSURL fileURLWithPath:fileName];
        
        NSXMLParser* beerXMLParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
        [beerXMLParser setDelegate:self];
        [beerXMLParser setShouldResolveExternalEntities:YES];
        success = [beerXMLParser parse];
    }
    
    return success;
}

#pragma mark XMLParserDelegate Methods
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    self.currentStringValue = [[self.currentStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.currentStringValue)
    {
        [self.currentStringValue appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Error %ld, Description: %@, Line: %ld, Column: %ld",
          (long)[parseError code],
          [[parser parserError] localizedDescription],
          (long)[parser lineNumber],
          (long)[parser columnNumber]);
}

#pragma mark
@synthesize appDelegate;
@synthesize currentStringValue;
@synthesize createdItems;
@synthesize parentParser;
@end
