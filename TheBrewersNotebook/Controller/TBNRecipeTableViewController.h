//
//  TBNRecipeTableViewController.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/12/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLDrive.h"


@interface TBNRecipeTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) GTLServiceDrive *driveService;

- (IBAction)editButtonPressed:(id)sender;

@end
