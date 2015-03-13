//
//  DetailViewInteractor.m
//  GrumpyGif
//
//  Created by Armando on 10/03/15.
//  Copyright (c) 2015 Armando Carmona. All rights reserved.
//

#import "DetailViewInteractor.h"
#import "ImageEntity+Model.h"
#import "DetailViewProvider.h"

@implementation DetailViewInteractor
-(ImageEntity *)getDataForDetailViewWithImageId:(NSString *)imageId{
    return[self.detailViewProvider getDataForDetailViewWithImageId:imageId];
}
-(BOOL)deleteImageWithId:(NSString *)imageId{
    return [self.detailViewProvider deleteImageWithId:imageId];
}
-(DetailViewProvider *)detailViewProvider{
    if(_detailViewProvider == nil){
        _detailViewProvider = [[DetailViewProvider alloc] init];
    }
    return _detailViewProvider;
}
@end
