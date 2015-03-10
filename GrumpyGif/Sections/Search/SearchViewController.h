//
//  SearchViewController.h
//  GrumpyGif
//
//  Created by Armando on 09/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageSave.h"
@interface SearchViewController : UIViewController
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) id<ImageSave> delegate;
@end

