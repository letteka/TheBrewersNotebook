//
//  TBNRecipeTimerViewController.m
//  TheBrewersNotebook
//
//  Created by Andrew Kettel on 8/26/14.
//  Copyright (c) 2014 ParthenonSoftwareGroup. All rights reserved.
//

#import "TBNRecipeTimerViewController.h"

@interface TBNRecipeTimerViewController ()

@end

@implementation TBNRecipeTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:self.recipe.name];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)nextButtonPressed:(id)sender {
    [UIView animateWithDuration:0.5 animations:^(void) {
        [self.pageControl setCurrentPage:[self.pageControl currentPage] + 1];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
