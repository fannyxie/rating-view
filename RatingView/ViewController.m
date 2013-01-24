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
    
    self.ratingView.rating = 0;
    self.ratingView.editable = YES;
    self.ratingView.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setRatingView:nil];
    [super viewDidUnload];
}

- (void)rateView:(RateView *)rateView RatingDidChanged:(float)rating
{
    NSLog(@"Rating: %f", rating);
}
@end
