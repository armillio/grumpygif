//
//  DetailViewInteractor.h
//  GrumpyGif
//
//  Created by Armando on 10/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "BaseInteractor.h"
@class DetailViewProvider;
@class ImageEntity;

@interface DetailViewInteractor : BaseInteractor
@property (strong,nonatomic) DetailViewProvider *detailViewProvider;
-(ImageEntity *)getDataForDetailViewWithImageId:(NSString *)imageId;
@end
