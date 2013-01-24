//
//  ViewController.h
//  RatingView
//
//  Created by Fanny on 1/24/13.
//  Copyright (c) 2013 Fanny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface ViewController : UIViewController<RateViewDelegate>

@property (weak, nonatomic) IBOutlet RateView *editableRatingView;
@property (weak, nonatomic) IBOutlet RateView *readonlyRatingView;

@end
