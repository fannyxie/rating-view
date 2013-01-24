//
//  RateView.h
//
//  Created by Fanny on 12/16/12.
//  Copyright (c) 2012 Fanny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RateView;

@protocol RateViewDelegate

-(void)rateView:(RateView *)rateView RatingDidChanged:(float)rating;

@end

@interface RateView : UIView

@property (nonatomic, retain) UIImage *notSelectedImage;
@property (nonatomic, retain) UIImage *halfSelectedImage;
@property (nonatomic, retain) UIImage *fullSelectedImage;
@property (nonatomic, assign) float rating;
@property (nonatomic, assign) BOOL editable;
@property (nonatomic, assign) int maxRating;
@property (nonatomic, assign) int middleMargin;
@property (nonatomic, assign) int leftMargin;
@property (nonatomic, assign) CGSize minImageSize;
@property (nonatomic, retain) NSMutableArray *imageView;
@property (nonatomic, retain) id<RateViewDelegate> delegate;

@end
