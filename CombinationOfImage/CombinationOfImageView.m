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
    imageView = [[GestureImageView alloc] init];
    
    [self addImageView:imageView withImage:image withFrame:frame];
    
    [imageView addAllGesture];
}

- (void) addFixImage:(UIImage *) image
{
   [self addFixImage:image withFrame:CGRectZero];
}
- (void) addFixImageWithName:(NSString *)imageName
{
    [self addFixImageWithName:imageName withFrame:CGRectZero];
}

- (void) addFixImage:(UIImage *) image withFrame:(CGRect) frame
{
    UIImageView *imageView;
    imageView = [[UIImageView alloc] init];
    
    [self addImageView:imageView withImage:image withFrame:frame];
    
}
- (void) addFixImageWithName:(NSString *)imageName withFrame:(CGRect) frame
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    [self addFixImage:image withFrame:frame];
}

- (void) addImageView:(UIImageView *) imageView withImage:(UIImage *) image withFrame:(CGRect) frame
{
    
    if ( CGRectEqualToRect(frame, CGRectZero) ){
        if ( image.size.height > self.bounds.size.width || image.size.width > self.bounds.size.width ) {
            CGSize size = [self sizeThatFits:image.size];
            frame = CGRectMake(0, 0, size.width, size.height);
        } else {
            frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }
    }
    
    imageView.frame = frame;
    imageView.image = image;
    imageView.contentMode = (image.size.width > frame.size.width || image.size.height > frame.size.height ) ? UIViewContentModeScaleAspectFit : UIViewContentModeCenter ;
    
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
        UIImageView *imageView = ((UIImageView *)self.imageList[index]);
        
        imageView.contentMode = (image.size.width > imageView.frame.size.width || image.size.height > imageView.frame.size.height ) ? UIViewContentModeScaleAspectFit : UIViewContentModeCenter ;
        
        imageView.image = image;
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
