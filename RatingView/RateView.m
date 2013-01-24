//
//  RateView.m
//
//  Created by Fanny on 12/16/12.
//  Copyright (c) 2012 Fanny. All rights reserved.
//

#import "RateView.h"

@implementation RateView

@synthesize notSelectedImage = _notSelectedImage;
@synthesize halfSelectedImage = _halfSelectedImage;
@synthesize fullSelectedImage = _fullSelectedImage;
@synthesize rating = _rating;
@synthesize editable = _editable;
@synthesize maxRating = _maxRating;
@synthesize middleMargin = _middleMargin;
@synthesize leftMargin = _leftMargin;
@synthesize minImageSize = _minImageSize;
@synthesize imageView = _imageView;
@synthesize delegate = _delegate;

- (void)baseInit{
    _notSelectedImage = [UIImage imageNamed:@"notSelected.gif"];;
    _halfSelectedImage = [UIImage imageNamed:@"halfSelected.gif"];
    _fullSelectedImage = [UIImage imageNamed:@"fullSelected.gif"];
    _rating = 0;
    _editable = NO;
    _imageView = [[NSMutableArray alloc] init];
    _maxRating = 5;
    _middleMargin = 5;
    _leftMargin = 5;
    _delegate = nil;
    [self resetMaxRating];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self baseInit];
    }
    return self;
}

- (void)refresh {
    for(int i = 0; i < self.imageView.count; i++) {
        UIImageView *imageView = [self.imageView objectAtIndex:i];
        if (self.rating >= i+1) {
            imageView.image = self.fullSelectedImage;
        } else if (self.rating > i) {
            imageView.image = self.halfSelectedImage;
        } else {
            imageView.image = self.notSelectedImage;
        }
    }
}

- (void) layoutSubviews {
    [super layoutSubviews];

    float desireImageWidth = (self.frame.size.width - self.leftMargin - self.middleMargin * self.imageView.count)/self.imageView.count;
    float imageWidth = MAX(self.minImageSize.width, desireImageWidth);
    float imageHeight = MAX(self.minImageSize.height, self.frame.size.height);
    
    for(int i = 0; i < self.imageView.count; i++){
        UIImageView *imageView = [self.imageView objectAtIndex:i];
        CGRect imageFrame = CGRectMake(self.leftMargin + i*(self.middleMargin + imageWidth), 0, imageWidth, imageHeight);
        imageView.frame = imageFrame;
    }

}

- (void)setMaxRating:(int)maxRating {
    if (_maxRating != maxRating) {
        _maxRating = maxRating;
        [self resetMaxRating];
    }
}

- (void) resetMaxRating {
    // Remove old image views
    for(int i = 0; i < self.imageView.count; ++i) {
        UIImageView *imageView = (UIImageView *) [self.imageView objectAtIndex:i];
        [imageView removeFromSuperview];
    }
    [self.imageView removeAllObjects];
    
    // Add new image views
    for(int i = 0; i < _maxRating; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageView addObject:imageView];
        [self addSubview:imageView];
    }

    // Relayout and refresh
    [self setNeedsLayout];
    [self refresh];
}

- (void)setNotSelectedImage:(UIImage *)image {
    _notSelectedImage = image;
    [self refresh];
}

- (void)setHalfSelectedImage:(UIImage *)image {
    _halfSelectedImage = image;
    [self refresh];
}

- (void)setFullSelectedImage:(UIImage *)image {
    _fullSelectedImage = image;
    [self refresh];
}

- (void)setRating:(float)rating {
    _rating = rating;
    [self refresh];
}

- (void) handleTouchAtLocation:(CGPoint)location {
    if (!self.editable) return;
    
    int newRating = 0;
    for (int i = self.imageView.count - 1; i >= 0; i--) {
        UIImageView *imageView = [self.imageView objectAtIndex:i];
        if(location.x > imageView.frame.origin.x) {
            newRating = i+1;
            break;
        }
    }
    self.rating = newRating;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.delegate rateView:self RatingDidChanged:self.rating];
}


@end
