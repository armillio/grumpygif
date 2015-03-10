//
//  MainViewCell.m
//  GrumpyGif
//
//  Created by Armando on 07/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "MainViewCell.h"
#import "ImageEntity+Model.h"

@implementation MainViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:_imageView];
        
        UISwipeGestureRecognizer* swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipetoSave:)];
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.contentView addGestureRecognizer:swipeGestureRecognizer];
    }
    
    return self;
}

-(void)swipetoSave:(UISwipeGestureRecognizer *)swipeGestureRecognizer{
    //[self.delegate saveGifwithDictionary:<#(NSDictionary *)#>];
}
@end