//
//  MainViewCell.m
//  GrumpyGif
//
//  Created by Armando on 07/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "DefaultCollectionViewCell.h"

NSString *const kSearchCollectionView = @"SearchViewController";

@implementation DefaultCollectionViewCell

- (void)setupImageView{
    _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    
    [self.contentView addSubview:_imageView];
}
-(void) configureCell{
    if([self.whoCalledMe isEqualToString:kSearchCollectionView]){
        [self addGestureRecognizerToCell:self];
    }
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self){
        [self setupImageView];
    }
    return self;
}
- (void)addGestureRecognizerToCell:(DefaultCollectionViewCell *)cell{
    UISwipeGestureRecognizer* swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeSave:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [cell addGestureRecognizer: swipeGestureRecognizer];
}
-(void) swipeSave:(id)sender{
    [self animateCell:self andIndexPath:self.indexPath];
    [self.delegate swipeToSave:sender];
}
- (void)animateCell:(DefaultCollectionViewCell *)cell andIndexPath:(NSIndexPath *)indexPath {
    CGFloat previousPosition = cell.layer.position.x;
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.toValue = @(previousPosition - 100);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation];
    group.duration = 0.6;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.delegate = self;
    [cell.layer addAnimation:group forKey:@"groupAnimation"];
}

@end