//
//  TBNBeerXMLParser.h
//  BrewdayHelper
//
//  Created by Andrew on 2/26/14.
//  Copyright (c) 2014 Letteka Brewing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TBNAppDelegate, TBNBeerXMLParser;

@interface TBNBeerXMLParser : NSObject <NSXMLParserDelegate>
- (BOOL)Parse:(NSString*)fileName;

@property (nonatomic, strong)TBNAppDelegate* appDelegate;
@property (nonatomic, strong)NSMutableString* currentStringValue;
@property (nonatomic, strong)NSMutableSet* createdItems;
@property (nonatomic, strong)TBNBeerXMLParser* parentParser;
@end
