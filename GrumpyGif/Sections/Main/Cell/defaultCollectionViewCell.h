//
//  MainViewCell.h
//  GrumpyGif
//
//  Created by Armando on 07/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GestureProtocol <NSObject>
@optional

-(void)swipeToSave:(id)sender;

@end

@interface DefaultCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) id<GestureProtocol> delegate;

@end
