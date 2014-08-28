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
@property (nonatomic, strong) IBOutlet UIButton* startButton;
@property (nonatomic, strong) IBOutlet UIButton* stopButton;
@property (nonatomic, strong) IBOutlet UILabel* timerLabel;

@property (nonatomic, strong) TBNRecipe* recipe;

- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)startTimerPressed:(id)sender;
- (IBAction)stopTimerPressed:(id)sender;

@end
