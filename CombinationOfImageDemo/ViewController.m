//
//  ViewController.m
//  CombinationOfImageDemo
//
//  Created by chen daozhao on 13-6-24.
//  Copyright (c) 2013年 chen daozhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addGesture:(id)sender {
    [self.handImageView addAllGesture];
}

- (IBAction)addImage:(id)sender {
    [self.cbImageView addImageWithName:@"IMG_0218.JPG"];
}
- (IBAction)addFixImage:(id)sender {
    [self.cbImageView addFixImageWithName:@"IMG_0218.JPG"];
}

- (IBAction)changeImage:(id)sender {
    [self.cbImageView changeImageWithName:@"IMG_0217.JPG" atIndex:0];
}
- (IBAction)addFixImageWithFrame:(id)sender {
    [self.cbImageView addFixImageWithName:@"abc.png" withFrame:CGRectMake(100, 100, 300, 400)];
}

- (IBAction)addImageWithFrame:(id)sender {
    [self.cbImageView addImageWithName:@"abc.png" withFrame:CGRectMake(100, 100, 300, 400)];
}

@end
