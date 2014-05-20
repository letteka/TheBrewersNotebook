//
//  TBNRecipeDetailViewController.m
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 5/20/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import "TBNRecipeDetailViewController.h"

@interface TBNRecipeDetailViewController ()

@end

enum
{
    TBNRecipeDetailMainSection = 0,
    TBNRecipeDetailHopsSection,
    TBNRecipeDetailFermentablesSection,
    TBNRecipeDetailYeastSection,
    TBNRecipeDetailWaterSection,
    TBNRecipeDetailSectionCount,
} TBNRecipeDetailSections;

enum
{
    TBNRecipeDetailSectionMainRow = 0,
    TBNRecipeDetailSectionRowCount,
} TBNRecipeDetailSection;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return TBNRecipeDetailSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows = 0;
    // Return the number of rows in the section.
    switch (section) {
        case TBNRecipeDetailMainSection:
            rows = TBNRecipeDetailSectionCount;
            break;
            
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecipeCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell with data from the managed object.

    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
