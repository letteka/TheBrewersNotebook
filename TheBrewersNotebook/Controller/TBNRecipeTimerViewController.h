//
//  TBNRecipeTimerViewController.h
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 8/26/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TBNRecipe.h"

@interface TBNRecipeTimerViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIPageControl* pageControl;

@property (nonatomic, strong) TBNRecipe* recipe;

- (IBAction)nextButtonPressed:(id)sender;

@end
