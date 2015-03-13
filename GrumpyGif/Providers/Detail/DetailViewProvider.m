//
//  DetailViewProvider.m
//  GrumpyGif
//
//  Created by Armando on 10/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "DetailViewProvider.h"
#import "ImageEntity+Model.h"

@implementation DetailViewProvider
-(ImageEntity *)getDataForDetailViewWithImageId:(NSString *)imageId{
    
    return [[ImageEntity alloc] getImageDataWithId:imageId
                                           withMoc:self.managedObjectContext];
}
-(BOOL)deleteImageWithId:(NSString *)imageId{
    return [[ImageEntity alloc] deleteImageWithId:imageId
                                          withMoc:self.managedObjectContext];
}
@end
