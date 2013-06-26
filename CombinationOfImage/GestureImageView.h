//
//  GestureImageView.h
//  DoGestureBySelfDemo
//
//  Created by chen daozhao on 13-6-21.
//  Copyright (c) 2013年 chen daozhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureImageView : UIImageView <UIGestureRecognizerDelegate>


- (void) addPanGesture;
- (void) addTapRecognizer;
- (void) addPinchGesture;
- (void) addRotationGesture;

- (void) addAllGesture;

@end
