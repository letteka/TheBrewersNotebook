//
//  TBNBeerXMLEquipmentParser.m
//  BrewdayHelper
//
//  Created by Andrew on 2/26/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import "TBNBeerXMLEquipmentParser.h"
#import "TBNEquipment.h"
#import "TBNAppDelegate.h"

@interface TBNBeerXMLEquipmentParser()
@property (nonatomic, strong)TBNEquipment* equipmentItem;
@end

@implementation TBNBeerXMLEquipmentParser

#pragma mark XMLParserDelegate Methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([[elementName uppercaseString] isEqualToString:@"EQUIPMENT"] || [[elementName uppercaseString] isEqualToString:@"NAME"] || [[elementName uppercaseString] isEqualToString:@"NOTES"] || [[elementName uppercaseString] isEqualToString:@"BOIL_SIZE"] || [[elementName uppercaseString] isEqualToString:@"BATCH_SIZE"] || [[elementName uppercaseString] isEqualToString:@"TUN_VOLUME"] || [[elementName uppercaseString] isEqualToString:@"TUN_WEIGHT"] || [[elementName uppercaseString] isEqualToString:@"TUN_SPECIFIC_HEAT"] || [[elementName uppercaseString] isEqualToString:@"TOP_UP_WATER"] || [[elementName uppercaseString] isEqualToString:@"TRUB_CHILLER_LOSS"] || [[elementName uppercaseString] isEqualToString:@"EVAP_RATE"] || [[elementName uppercaseString] isEqualToString:@"BOIL_TIME"] || [[elementName uppercaseString] isEqualToString:@"CALC_BOIL_VOLUME"] || [[elementName uppercaseString] isEqualToString:@"LAUTER_DEADSPACE"] || [[elementName uppercaseString] isEqualToString:@"TOP_UP_KETTLE"] || [[elementName uppercaseString] isEqualToString:@"HOP_UTILIZATION"])
    {
        if (!equipmentItem)
        {
            equipmentItem = [NSEntityDescription insertNewObjectForEntityForName:@"TBNEquipment"
                                                          inManagedObjectContext:self.appDelegate.managedObjectContext];
        }
        
        if (!self.currentStringValue)
            self.currentStringValue = [[NSMutableString alloc] initWithCapacity:100];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [super parser:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    if([[elementName uppercaseString] isEqualToString:@"EQUIPMENTS"])
    {
        NSError* error;
        if (![self.appDelegate.managedObjectContext save:&error])
        {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"EQUIPMENT"])
    {
        [self.createdItems addObject:equipmentItem];
        equipmentItem = nil;
        
        if (self.parentParser)
            [parser setDelegate:self.parentParser];
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NAME"])
    {
        if (self.currentStringValue.length > 0)
        {
            TBNAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"TBNEquipment" inManagedObjectContext:appDelegate.managedObjectContext];
            [request setEntity:entity];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@", self.currentStringValue];
            
            request.predicate = predicate;
            
            NSError *error = nil;
            NSArray *results = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([results count] > 0)
            {
                [appDelegate.managedObjectContext deleteObject:equipmentItem];
                equipmentItem = [results objectAtIndex:0];
            }
            
            equipmentItem.name = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"NOTES"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.notes = self.currentStringValue;
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"BOIL_SIZE"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.boilSize = [[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"BATCH_SIZE"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.batchSize =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TUN_VOLUME"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.tunVolume =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TUN_WEIGHT"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.tunWeight =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TUN_SPECIFIC_HEAT"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.tunSpecificHeat =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TOP_UP_WATER"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.topUpWater =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TRUB_CHILLER_LOSS"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.trubChillerLoss =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"EVAP_RATE"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.evapRate =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"BOIL_TIME"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.boilTime =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"CALC_BOIL_VOLUME"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.calcBoilVolume =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"LAUTER_DEADSPACE"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.lauterDeadspace =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"TOP_UP_KETTLE"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.topUpKettle =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
    else if ([[elementName uppercaseString] isEqualToString:@"HOP_UTILIZATION"])
    {
        if (self.currentStringValue.length > 0)
        {
            equipmentItem.hopUtilization =[[NSDecimalNumber alloc] initWithString:self.currentStringValue];
            self.currentStringValue = nil;
        }
    }
}



#pragma mark Properties
@synthesize equipmentItem;

@end
