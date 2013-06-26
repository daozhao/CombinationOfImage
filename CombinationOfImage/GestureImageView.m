//
//  GestureImageView.m
//  DoGestureBySelfDemo
//
//  Created by chen daozhao on 13-6-21.
//  Copyright (c) 2013年 chen daozhao. All rights reserved.
//

#import "GestureImageView.h"

@interface GestureImageView ()

@property(nonatomic,assign) CGSize cropSize;
@property(nonatomic,assign) CGFloat outputWidth;
@property(nonatomic,assign) CGFloat minimumScale;
@property(nonatomic,assign) CGFloat maximumScale;


@property(nonatomic,assign) NSUInteger gestureCount;
@property(nonatomic,assign) CGPoint touchCenter;
@property(nonatomic,assign) CGPoint rotationCenter;
@property(nonatomic,assign) CGPoint scaleCenter;
@property(nonatomic,assign) CGFloat scale;

@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer;
@property (strong, nonatomic) UIRotationGestureRecognizer *rotationRecognizer;
@property (strong, nonatomic) UIPinchGestureRecognizer *pinchRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

@end


@implementation GestureImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) addPanGesture
{
    if ( ! self.panRecognizer ){
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        
        self.panRecognizer.cancelsTouchesInView = NO;
        self.panRecognizer.delegate = self;
        [self addGestureRecognizer:self.panRecognizer];
    }
}

- (void) addRotationGesture
{
    if ( ! self.rotationRecognizer ){
        
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        self.rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
        
        self.rotationRecognizer.cancelsTouchesInView = NO;
        self.rotationRecognizer.delegate = self;
        [self addGestureRecognizer:self.rotationRecognizer];
    }
}

- (void) addPinchGesture
{
    if ( ! self.pinchRecognizer ){
        
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        self.pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        
        self.pinchRecognizer.cancelsTouchesInView = NO;
        self.pinchRecognizer.delegate = self;
        [self addGestureRecognizer:self.pinchRecognizer];
    }
}

- (void) addTapRecognizer
{
    if (! self.tapRecognizer ){
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        
        self.tapRecognizer.numberOfTapsRequired = 2;
        [self addGestureRecognizer:self.tapRecognizer];
    }
}

- (void) addAllGesture
{
    [self addPanGesture];
    [self addPinchGesture];
    [self addRotationGesture];
//    [self addTapRecognizer];
    
}


#pragma mark Gestures

- (BOOL)handleGestureState:(UIGestureRecognizerState)state
{
    BOOL handle = YES;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            self.gestureCount++;
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            self.gestureCount--;
            handle = NO;
            if(self.gestureCount == 0) {
                CGFloat scale = self.scale;
                if(self.minimumScale != 0 && self.scale < self.minimumScale) {
                    scale = self.minimumScale;
                } else if(self.maximumScale != 0 && self.scale > self.maximumScale) {
                    scale = self.maximumScale;
                }
                if(scale != self.scale) {
                    CGFloat deltaX = self.scaleCenter.x-self.bounds.size.width/2.0;
                    CGFloat deltaY = self.scaleCenter.y-self.bounds.size.height/2.0;
                    
                    CGAffineTransform transform =  CGAffineTransformTranslate(self.transform, deltaX, deltaY);
                    transform = CGAffineTransformScale(transform, scale/self.scale , scale/self.scale);
                    transform = CGAffineTransformTranslate(transform, -deltaX, -deltaY);
                    self.userInteractionEnabled = NO;
                    [UIView animateWithDuration: 0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        self.transform = transform;
                    } completion:^(BOOL finished) {
                        self.userInteractionEnabled = YES;
                        self.scale = scale;
                    }];
                    
                }
            }
        } break;
        default:
            break;
    }
    return handle;
}


- (IBAction)handlePan:(UIPanGestureRecognizer*)recognizer
{
    if([self handleGestureState:recognizer.state]) {
        CGPoint translation = [recognizer translationInView:self];
        CGAffineTransform transform = CGAffineTransformTranslate( self.transform, translation.x, translation.y);
        self.transform = transform;
        
        [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    }
    
}

- (IBAction)handleRotation:(UIRotationGestureRecognizer*)recognizer
{
    if([self handleGestureState:recognizer.state]) {
        if(recognizer.state == UIGestureRecognizerStateBegan){
            self.rotationCenter = self.touchCenter;
        }
        CGFloat deltaX = self.rotationCenter.x-self.bounds.size.width/2;
        CGFloat deltaY = self.rotationCenter.y-self.bounds.size.height/2;
        
        CGAffineTransform transform =  CGAffineTransformTranslate(self.transform,deltaX,deltaY);
        transform = CGAffineTransformRotate(transform, recognizer.rotation);
        transform = CGAffineTransformTranslate(transform, -deltaX, -deltaY);
        self.transform = transform;
        
        recognizer.rotation = 0;
    }
    
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    if([self handleGestureState:recognizer.state]) {
        if(recognizer.state == UIGestureRecognizerStateBegan){
            self.scaleCenter = self.touchCenter;
        }
        CGFloat deltaX = self.scaleCenter.x-self.bounds.size.width/2.0;
        CGFloat deltaY = self.scaleCenter.y-self.bounds.size.height/2.0;
        
        CGAffineTransform transform =  CGAffineTransformTranslate(self.transform, deltaX, deltaY);
        transform = CGAffineTransformScale(transform, recognizer.scale, recognizer.scale);
        transform = CGAffineTransformTranslate(transform, -deltaX, -deltaY);
        self.scale *= recognizer.scale;
        self.transform = transform;
        
        recognizer.scale = 1;
    }
}

- (IBAction)handleTap:(UITapGestureRecognizer *)recogniser {
    //    [self reset:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark Touches

- (void)handleTouches:(NSSet*)touches
{
    self.touchCenter = CGPointZero;
    if(touches.count < 2) return;
    
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = (UITouch*)obj;
        CGPoint touchLocation = [touch locationInView:self];
        self.touchCenter = CGPointMake(self.touchCenter.x + touchLocation.x, self.touchCenter.y +touchLocation.y);
    }];
    self.touchCenter = CGPointMake(self.touchCenter.x/touches.count, self.touchCenter.y/touches.count);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:[event allTouches]];
}

@end
