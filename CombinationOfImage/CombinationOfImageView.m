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

- (void) addImageWithName:(NSString *)imageName
{
    [self addImageWithName:imageName withFrame:CGRectZero];
}

- (void) addImageWithName:(NSString *)imageName withFrame:(CGRect) frame
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    [self addImage:image withFrame:frame];
}

- (void) addImage:(UIImage *) image
{
    [self addImage:image withFrame:CGRectZero];
}

- (void) addImage:(UIImage *) image withFrame:(CGRect) frame
{
    GestureImageView *imageView;
    if ( CGRectEqualToRect(frame, CGRectZero) ){
        if ( image.size.height > self.bounds.size.width || image.size.width > self.bounds.size.width ) {
            CGSize size = [self sizeThatFits:image.size];
            frame = CGRectMake(0, 0, size.width, size.height);
        } else {
            frame = CGRectMake(0, 0, image.size.width, image.size.height);
            //            imageView = [[GestureImageView alloc] initWithImage:image];
        }
    }
    
    imageView = [[GestureImageView alloc] initWithFrame:frame];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addImageView:imageView];
}

- (void) addImageView:(GestureImageView *) imageView
{
    [imageView addAllGesture];
    [self.imageList addObject:imageView];
    [self addSubview:imageView];
    
    self.clipsToBounds = YES;
}

-(void) changeImageWithName:(NSString *)name atIndex:(NSInteger)index
{
    [self changeImage:[UIImage imageNamed:name] atIndex:index];
}

-(void) changeImage:(UIImage *)image atIndex:(NSInteger)index
{
    if ( index < self.imageList.count ){
        ((GestureImageView *)self.imageList[index]).image = image;
    }
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
