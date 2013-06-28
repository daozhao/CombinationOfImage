//
//  CombinationOfImageView.m
//  CombinationOfImageDemo
//
//  Created by chen daozhao on 13-6-24.
//  Copyright (c) 2013年 chen daozhao. All rights reserved.
//

#import "CombinationOfImageView.h"
#import "GestureImageView.h"

@implementation CombinationOfImageView

@synthesize imageList = _imageList;

#pragma mark -
#pragma mark Overridden Getters

- (NSMutableArray *) imageList
{
    if (! _imageList) {
        _imageList = [[NSMutableArray alloc] init];
    }
    return _imageList;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        // Initialization code
    }
    return self;
}

- (void) addImage:(NSString *)imageName
{
//    GestureImageView *image = [[GestureImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    GestureImageView *imageView;
    UIImage *image = [UIImage imageNamed:imageName];
    if ( image.size.height > self.bounds.size.width || image.size.width > self.bounds.size.width ) {
        CGSize size = [self sizeThatFits:image.size];
        imageView = [[GestureImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    } else {
        imageView = [[GestureImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    }
//    GestureImageView *image = [[GestureImageView alloc] initWithImage:<#(UIImage *)#>
    [imageView addAllGesture];
    [self.imageList addObject:imageView];
    [self addSubview:imageView];
    
    self.clipsToBounds = YES;
    //    self.multipleTouchEnabled = YES;
//    self.userInteractionEnabled = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
