//
//  TBNBeerXMLMashParser.m
//  BrewdayHelper
//
//  Created by Andrew on 2/27/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import "TBNBeerXMLMashParser.h"
#import "TBNAppDelegate.h"
#import "TBNMash.h"
#import "TBNMashSteps.h"

@interface TBNBeerXMLMashParser()
@property (nonatomic, strong)TBNMash* mashItem;
@property (nonatomic, strong)TBNMashSteps* mashStepsItem;
@end

@implementation TBNBeerXMLMashParser

#pragma mark XMLParserDelegate Methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([[elementName uppercaseString] isEqualToString:@"MASH_STEP"])
    {
        mashStepsItem = [NSEntityDescription insertNewObjectForEntityForName:@"TBNMashSteps"
                                                 inManagedObjectContext:self.appDelegate.managedObjectContext];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MASH"] || [[elementName uppercaseString] isEqualToString:@"NAME"] || [[elementName uppercaseString] isEqualToString:@"NOTES"] || [[elementName uppercaseString] isEqualToString:@"GRAIN_TEMP"] || [[elementName uppercaseString] isEqualToString:@"TUN_TEMP"] || [[elementName uppercaseString] isEqualToString:@"SPARGE_TEMP"] || [[elementName uppercaseString] isEqualToString:@"PH"] || [[elementName uppercaseString] isEqualToString:@"TUN_WEIGHT"] || [[elementName uppercaseString] isEqualToString:@"TUN_SPECIFIC_HEAT"] || [[elementName uppercaseString] isEqualToString:@"EQUIP_ADJUST"] || [[elementName uppercaseString] isEqualToString:@"INFUSE_AMOUNT"] || [[elementName uppercaseString] isEqualToString:@"STEP_TIME"] || [[elementName uppercaseString] isEqualToString:@"STEP_TEMP"] || [[elementName uppercaseString] isEqualToString:@"RAMP_TIME"] || [[elementName uppercaseString] isEqualToString:@"END_TEMP"] || [[elementName uppercaseString] isEqualToString:@"DESCRIPTION"]|| [[elementName uppercaseString] isEqualToString:@"WATER_GRAIN_RATIO"]|| [[elementName uppercaseString] isEqualToString:@"DECOCTION_AMT"]|| [[elementName uppercaseString] isEqualToString:@"INFUSE_TEMP"])
    {
        if (!mashItem)
        {
            mashItem = [NSEntityDescription insertNewObjectForEntityForName:@"TBNMash"
                                                     inManagedObjectContext:self.appDelegate.managedObjectContext];
        }
        
        if (!self.currentStringValue)
            self.currentStringValue = [[NSMutableString alloc] initWithCapacity:100];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    if([[elementName uppercaseString] isEqualToString:@"MASHS"])
    {
        NSError* error;
        if (![self.appDelegate.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"MASH"])
    {
        [self.createdItems addObject:mashItem];
        mashItem = nil;
        
        if (self.parentParser)
            [parser setDelegate:self.parentParser];
    }
    else if([[elementName uppercaseString] isEqualToString:@"MASH_STEP"])
    {
        [mashItem addStepsObject:mashStepsItem];
        mashStepsItem = nil;
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NAME"])
    {
        TBNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        
        if (mashStepsItem)
        {
            if (self.currentStringValue.length > 0)
            {
                [mashItem.steps enumerateObjectsUsingBlock:^(TBNMashSteps *mashStep, BOOL *stop) {
                    if ([mashStep.name compare:self.currentStringValue options:NSCaseInsensitiveSearch])
                    {
                        [appDelegate.managedObjectContext deleteObject:mashStepsItem];
                        self.mashStepsItem = mashStep;
                        
                        *stop = YES;
                    }
                }];
                
                mashStepsItem.name = self.currentStringValue;
                self.currentStringValue = nil;
            }
        }
        else
        {
            if (self.currentStringValue.length > 0)
            {
                NSFetchRequest *request = [[NSFetchRequest alloc] init];
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"TBNMash" inManagedObjectContext:appDelegate.managedObjectContext];
                [request setEntity:entity];
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", self.currentStringValue];
                
                request.predicate = predicate;
                
                NSError *error = nil;
                NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
                
                if ([results count] > 0)
                {
                    [appDelegate.managedObjectContext deleteObject:mashItem];
                    mashItem = [results objectAtIndex:0];
                }
                
                mashItem.name = self.currentStringValue;
                self.currentStringValue = nil;
            }
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NOTES"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashItem.notes = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"GRAIN_TEMP"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashItem.grainTemp = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TUN_TEMP"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashItem.tunTemp = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"SPARGE_TEMP"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashItem.spargeTemp =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"PH"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashItem.ph =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TUN_WEIGHT"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashItem.tunWeight =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TUN_SPECIFIC_HEAT"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashItem.tunSpecificHeat = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"EQUIP_ADJUST"])
    {
        if (self.currentStringValue.length > 0)
        {
            NSString* equipAdjust = [[NSString alloc] initWithString:self.currentStringValue];
            mashItem.equipAdjust = [[NSNumber alloc] initWithBool:[equipAdjust isEqualToString:@"TRUE"]];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TYPE"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashStepsItem.type =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"INFUSE_AMOUNT"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashStepsItem.infuseAmount =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"STEP_TIME"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashStepsItem.stepTime =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"STEP_TEMP"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashStepsItem.stepTemp =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"RAMP_TIME"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashStepsItem.rampTime =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"END_TEMP"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashStepsItem.endTime =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"DESCRIPTION"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashStepsItem.stepDescription =[[NSString alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"WATER_GRAIN_RATIO"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashStepsItem.waterGrainRatio =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"DECOCTION_AMT"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashStepsItem.decoctionAmount =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"INFUSE_TEMP"])
    {
        if (self.currentStringValue.length > 0)
        {
            mashStepsItem.infuseTemp =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
}

@synthesize mashItem;
@synthesize mashStepsItem;

@end
