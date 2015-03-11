//
//  MainViewCell.m
//  GrumpyGif
//
//  Created by Armando on 07/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "DefaultCollectionViewCell.h"
#import "MainViewController.h"
#import "SearchViewController.h"

@interface DefaultCollectionViewCell()

@property (nonatomic, strong) MainViewController *mainViewController;
@property (nonatomic, strong) SearchViewController *searchViewController;

@end

@implementation DefaultCollectionViewCell

- (void)setupImageView
{
    _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    
    [self.contentView addSubview:_imageView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setupImageView];
        
        [self addGestureRecognizerToCell:self];

        if(_indexPath.row == 0){
            [self animateCell:_indexPath];
        }
    }

    return self;
}
-(MainViewController *)mainViewController{
    if(_mainViewController){
        _mainViewController = [[MainViewController alloc] init];
    }
    return _mainViewController;
}
-(SearchViewController *)searchViewController{
    if(_searchViewController){
        _searchViewController = [[SearchViewController alloc] init];
    }
    return _searchViewController;
}
- (void)addGestureRecognizerToCell:(DefaultCollectionViewCell *)cell
{
    UISwipeGestureRecognizer* swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeSave:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [cell addGestureRecognizer: swipeGestureRecognizer];
}
-(void) swipeSave:(id)sender{
    [self.delegate swipeToSave:sender];
    [self animateCell:self.indexPath];
}
- (void)animateCell:(NSIndexPath *)tappedCellPath {
    CGFloat previousPosition = [self.searchViewController.searchCollectionView cellForItemAtIndexPath:tappedCellPath].layer.position.x;
    CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.toValue = @(previousPosition - 100);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation];
    group.duration = 0.6;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.delegate = self;
    [[self.searchViewController.searchCollectionView cellForItemAtIndexPath:tappedCellPath].layer addAnimation:group forKey:@"groupAnimation"];
}

@end