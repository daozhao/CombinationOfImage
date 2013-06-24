//
//  ViewController.h
//  CombinationOfImageDemo
//
//  Created by chen daozhao on 13-6-24.
//  Copyright (c) 2013年 chen daozhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureImageView.h"
#import "CombinationOfImageView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet GestureImageView *handImageView;
@property (weak, nonatomic) IBOutlet CombinationOfImageView *cbImageView;

@end
