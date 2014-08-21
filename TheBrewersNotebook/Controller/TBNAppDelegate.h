//
//  TBNAppDelegate.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/12/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, strong, nonatomic) NSString *kKeychainItemName;
@property (readonly, strong, nonatomic) NSString *kClientID;
@property (readonly, strong, nonatomic) NSString *kClientSecret;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
