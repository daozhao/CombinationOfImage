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
    [self.cbImageView addImageWithName:@"me.JPG"];
}
- (IBAction)addFixImage:(id)sender {
    [self.cbImageView addFixImageWithName:@"me.JPG"];
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
- (IBAction)addLogo:(id)sender {
    [self.cbImageView addImageWithName:@"24.png"];
}
- (IBAction)addLogoWithFrame:(id)sender {
    [self.cbImageView addImageWithName:@"24.png" withFrame:CGRectMake(100, 100, 256, 256)];
}

- (IBAction)addLogo2X:(id)sender {
    [self.cbImageView addImageWithName:@"binocular.png"];
}
- (IBAction)addLogo2xWithFrame:(id)sender {
    [self.cbImageView addImageWithName:@"binocular.png" withFrame:CGRectMake(100, 100, 384, 384)];
}

@end
