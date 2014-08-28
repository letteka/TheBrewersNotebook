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

@implementation TBNRecipeTimerViewController {
    NSTimer *_timer;
    NSInteger _minutes;
    NSInteger _seconds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:self.recipe.name];
    
    // temp data
    _minutes = 2;
    [self setTimerText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerFires{
    if (_minutes > 0 || _seconds > 0)
    {
        if (_seconds > 0) {
            _seconds--;
        }
        else if (_seconds == 0) {
            _seconds = 59;
            _minutes--;
        }
        [self setTimerText];
    }
    else
    {
        self.timerLabel.text = @"00:00";
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)setTimerText
{
    self.timerLabel.text = [NSString stringWithFormat:@"%02d:%02d", _minutes, _seconds];
}

#pragma mark - IBActions
- (IBAction)nextButtonPressed:(id)sender {
    [UIView animateWithDuration:0.5 animations:^(void) {
        [self.pageControl setCurrentPage:[self.pageControl currentPage] + 1];
    }];
}

- (IBAction)startTimerPressed:(id)sender
{
    [self.stopButton setUserInteractionEnabled:YES];
    [self.startButton setUserInteractionEnabled:NO];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(timerFires)
                                           userInfo:nil
                                            repeats:YES];
    [_timer fire];
}

- (IBAction)stopTimerPressed:(id)sender
{
    [self.startButton setUserInteractionEnabled:YES];
    [self.stopButton setUserInteractionEnabled:NO];
    
    [_timer invalidate];
    _timer = nil;
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
