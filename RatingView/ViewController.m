//
//  ViewController.m
//  RatingView
//
//  Created by Fanny on 1/24/13.
//  Copyright (c) 2013 Fanny. All rights reserved.
//

#import "ViewController.h"
#import "RateView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.editableRatingView.rating = 0;
    self.editableRatingView.editable = YES;
    self.editableRatingView.delegate = self;
    
    self.readonlyRatingView.rating = 3.5;
    self.readonlyRatingView.editable = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEditableRatingView:nil];
    [super viewDidUnload];
}

- (void)rateView:(RateView *)rateView RatingDidChanged:(float)rating
{
    NSLog(@"Rating: %f", rating);
}
@end
