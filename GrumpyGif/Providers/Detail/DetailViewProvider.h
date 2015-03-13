//
//  DetailViewProvider.h
//  GrumpyGif
//
//  Created by Armando on 10/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "BaseProvider.h"
@class ImageEntity;
@interface DetailViewProvider : BaseProvider
-(ImageEntity *)getDataForDetailViewWithImageId:(NSString *)imageId;
-(BOOL)deleteImageWithId:(NSString *)imageId;
@end
