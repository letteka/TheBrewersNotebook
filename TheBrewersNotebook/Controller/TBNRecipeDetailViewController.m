//
//  TBNRecipeDetailViewController.m
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/20/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import "TBNRecipeDetailViewController.h"

#import "TBNRecipeTimerViewController.h"

@interface TBNRecipeDetailViewController ()

@end

@implementation TBNRecipeDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:self.recipe.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TBNRecipeTimerSegue"])
    {
        TBNRecipeTimerViewController *recipeDetailViewController = [segue destinationViewController];
        TBNRecipe *recipe = self.recipe;
        recipeDetailViewController.recipe = recipe;
    }
}


@end
