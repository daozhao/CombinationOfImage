//
//  CombinationOfImageView.h
//  CombinationOfImageDemo
//
//  Created by chen daozhao on 13-6-24.
//  Copyright (c) 2013年 chen daozhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CombinationOfImageView : UIView


@property (nonatomic,readonly) NSMutableArray *imageList;


- (void) addImage:(UIImage *) image;
- (void) addImageWithName:(NSString *)imageName;

-(void) changeImageWithName:(NSString *)name atIndex:(NSInteger)index;
-(void) changeImage:(UIImage *)image atIndex:(NSInteger)index;


@end
