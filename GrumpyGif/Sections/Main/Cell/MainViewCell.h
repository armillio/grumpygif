//
//  MainViewCell.h
//  GrumpyGif
//
//  Created by Armando on 07/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageSave.h"
@interface MainViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) id<ImageSave> delegate;
@end
