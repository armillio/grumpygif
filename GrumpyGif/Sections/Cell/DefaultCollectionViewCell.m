//
//  MainViewCell.m
//  GrumpyGif
//
//  Created by Armando on 07/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "DefaultCollectionViewCell.h"

@implementation DefaultCollectionViewCell

- (void)setupImageView
{
    _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    
    [self.contentView addSubview:_imageView];
}
-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setupImageView];
        
        [self addGestureRecognizerToCell:self];
        
        if([_whoCalledMe isEqualToString:@"SearchViewController"]){
            if(_indexPath.row == 0){
                [self animateCell:self andIndexPath:_indexPath];
            }
        }

    }
    return self;
}
-(NSString *)whoCalledMe{
    if(_whoCalledMe == nil){
        _whoCalledMe = [[NSString alloc] init];
    }
    return _whoCalledMe;
}
- (void)addGestureRecognizerToCell:(DefaultCollectionViewCell *)cell
{
    UISwipeGestureRecognizer* swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeSave:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [cell addGestureRecognizer: swipeGestureRecognizer];
}
-(void) swipeSave:(id)sender{
    [self.delegate swipeToSave:sender];
    [self animateCell:self andIndexPath:self.indexPath];
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
    NSLog(@"Animated");
}

@end